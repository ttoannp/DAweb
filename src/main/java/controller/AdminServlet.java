package controller;

import bean.Listing;
import bean.User;
import bean.Category;
import bo.ListingBO;
import bo.UserBO;
import bo.CategoryBO;
import bo.LocationBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {
    private ListingBO listingBO;
    private UserBO userBO;
    private CategoryBO categoryBO;
    private LocationBO locationBO;
    
    @Override
    public void init() throws ServletException {
        listingBO = new ListingBO();
        userBO = new UserBO();
        categoryBO = new CategoryBO();
        locationBO = new LocationBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // Dashboard admin
            List<Listing> pendingListings = listingBO.getPendingListings();
            List<User> allUsers = userBO.getAllUsers();
            int approvedListingsCount = listingBO.getApprovedListingsCount();
            
            request.setAttribute("pendingListings", pendingListings);
            request.setAttribute("allUsers", allUsers);
            request.setAttribute("approvedListingsCount", approvedListingsCount);
            request.getRequestDispatcher("/view/admin/dashboard.jsp").forward(request, response);
        } else if (pathInfo.equals("/pending")) {
            // Quản lý tin chờ duyệt
            List<Listing> pendingListings = listingBO.getPendingListings();
            request.setAttribute("pendingListings", pendingListings);
            request.getRequestDispatcher("/view/admin/pending-listings.jsp").forward(request, response);
        } else if (pathInfo.equals("/users")) {
            // Quản lý người dùng
            List<User> allUsers = userBO.getAllUsers();
            request.setAttribute("allUsers", allUsers);
            request.getRequestDispatcher("/view/admin/users.jsp").forward(request, response);
        } else if (pathInfo.equals("/categories")) {
            // Quản lý danh mục
            List<Category> categories = categoryBO.getAllCategories();
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/view/admin/categories.jsp").forward(request, response);
        } else if (pathInfo.equals("/locations")) {
            // Quản lý địa điểm
            List<String> provinces = locationBO.getAllProvinces();
            request.setAttribute("provinces", provinces);
            request.getRequestDispatcher("/view/admin/locations.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null || !"admin".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getParameter("action");
        String listingIdStr = request.getParameter("listingId");
        
        if ("approve".equals(action) || "reject".equals(action)) {
            try {
                int listingId = Integer.parseInt(listingIdStr);
                String status = "approve".equals(action) ? "approved" : "rejected";
                
                if (listingBO.updateListingStatus(listingId, status)) {
                    request.setAttribute("success", "Cập nhật trạng thái tin thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID tin không hợp lệ!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/pending");
        } else if ("addCategory".equals(action)) {
            String categoryName = request.getParameter("categoryName");
            if (categoryName != null && !categoryName.trim().isEmpty()) {
                Category category = new Category(categoryName.trim());
                if (categoryBO.addCategory(category)) {
                    request.setAttribute("success", "Thêm danh mục thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi thêm danh mục!");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else if ("updateCategory".equals(action)) {
            try {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                String categoryName = request.getParameter("categoryName");
                if (categoryName != null && !categoryName.trim().isEmpty()) {
                    if (categoryBO.updateCategory(categoryId, categoryName.trim())) {
                        request.setAttribute("success", "Cập nhật danh mục thành công!");
                    } else {
                        request.setAttribute("error", "Có lỗi xảy ra khi cập nhật danh mục!");
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID danh mục không hợp lệ!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else if ("deleteCategory".equals(action)) {
            try {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                if (categoryBO.deleteCategory(categoryId)) {
                    request.setAttribute("success", "Xóa danh mục thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi xóa danh mục!");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID danh mục không hợp lệ!");
            }
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else if ("addProvince".equals(action)) {
            String province = request.getParameter("province");
            if (province != null && !province.trim().isEmpty()) {
                if (locationBO.addProvince(province.trim())) {
                    request.setAttribute("success", "Thêm tỉnh/thành thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi thêm tỉnh/thành!");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/locations");
        } else if ("addDistrict".equals(action)) {
            String province = request.getParameter("province");
            String district = request.getParameter("district");
            if (province != null && !province.trim().isEmpty() && 
                district != null && !district.trim().isEmpty()) {
                if (locationBO.addDistrict(province.trim(), district.trim())) {
                    request.setAttribute("success", "Thêm quận/huyện thành công!");
                } else {
                    request.setAttribute("error", "Có lỗi xảy ra khi thêm quận/huyện!");
                }
            }
            response.sendRedirect(request.getContextPath() + "/admin/locations");
        }
    }
} 