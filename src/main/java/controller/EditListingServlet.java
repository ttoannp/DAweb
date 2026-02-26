package controller;

import bean.Listing;
import bean.Location;
import bean.User;
import bo.ListingBO;
import bo.CategoryBO;
import dao.LocationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/edit-listing/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 50 // 50 MB
)
public class EditListingServlet extends HttpServlet {
    private ListingBO listingBO;
    private CategoryBO categoryBO;
    private LocationDAO locationDAO;
    
    @Override
    public void init() throws ServletException {
        listingBO = new ListingBO();
        categoryBO = new CategoryBO();
        locationDAO = new LocationDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/user-listings");
            return;
        }
        
        try {
            int listingId = Integer.parseInt(pathInfo.substring(1));
            Listing listing = listingBO.getListingById(listingId);
            
            if (listing == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            // Kiểm tra quyền sở hữu
            if (listing.getUserId() != user.getId() && !"admin".equals(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            List<bean.Category> categories = categoryBO.getAllCategories();
            List<String> provinces = locationDAO.getAllProvinces();
            List<String> districts = locationDAO.getDistrictsByProvince(listing.getLocation().getProvince());
            
            request.setAttribute("listing", listing);
            request.setAttribute("categories", categories);
            request.setAttribute("provinces", provinces);
            request.setAttribute("districts", districts);
            request.getRequestDispatcher("/view/edit-listing.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String listingIdStr = request.getParameter("listingId");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String areaStr = request.getParameter("area");
        String categoryIdStr = request.getParameter("categoryId");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String address = request.getParameter("address");
        
        // Validation
        if (listingIdStr == null || title == null || description == null || priceStr == null || 
            areaStr == null || categoryIdStr == null || province == null || district == null ||
            listingIdStr.trim().isEmpty() || title.trim().isEmpty() || description.trim().isEmpty() || 
            priceStr.trim().isEmpty() || areaStr.trim().isEmpty() || 
            categoryIdStr.trim().isEmpty() || province.trim().isEmpty() || 
            district.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            doGet(request, response);
            return;
        }
        
        try {
            int listingId = Integer.parseInt(listingIdStr);
            long price = Long.parseLong(priceStr);
            float area = Float.parseFloat(areaStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            
            // Kiểm tra quyền sở hữu
            Listing existingListing = listingBO.getListingById(listingId);
            if (existingListing == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            
            if (existingListing.getUserId() != user.getId() && !"admin".equals(user.getRole())) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }
            
            Location location = new Location(province, district, ward, address);
            Listing listing = new Listing(user.getId(), title, description, price, area, existingListing.getLocationId(), categoryId);
            listing.setId(listingId);
            listing.setLocation(location);
            
            // Xử lý upload ảnh mới
            List<String> imageUrls = new ArrayList<>();
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            
            for (Part part : request.getParts()) {
                if (part.getName().equals("images") && part.getSize() > 0) {
                    String fileName = UUID.randomUUID().toString() + "_" + getSubmittedFileName(part);
                    String filePath = uploadPath + File.separator + fileName;
                    part.write(filePath);
                    imageUrls.add("/uploads/" + fileName);
                }
            }
            
                         // Nếu tin đã được duyệt trước đó, đặt lại status thành pending
             if (existingListing.getStatus().equals("approved")) {
                 listing.setStatus("pending");
             }
             
             if (listingBO.updateListing(listing, imageUrls)) {
                 String message = existingListing.getStatus().equals("approved") ? 
                     "Cập nhật tin thành công! Tin sẽ được admin duyệt lại." : 
                     "Cập nhật tin thành công!";
                 request.setAttribute("success", message);
                 response.sendRedirect(request.getContextPath() + "/user-listings");
             } else {
                 request.setAttribute("error", "Có lỗi xảy ra! Vui lòng thử lại.");
                 doGet(request, response);
             }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            doGet(request, response);
        }
    }
    
    private String getSubmittedFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
} 