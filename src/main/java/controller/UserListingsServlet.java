package controller;

import bean.Listing;
import bean.User;
import bo.ListingBO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/user-listings")
public class UserListingsServlet extends HttpServlet {
    private ListingBO listingBO;

    @Override
    public void init() throws ServletException {
        listingBO = new ListingBO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ Bổ sung cấu hình UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        User currentUser = (User) request.getSession().getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Listing> listings = listingBO.getAllListingsByUserId(currentUser.getId());
        request.setAttribute("listings", listings);
        request.getRequestDispatcher("/view/user-listings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ✅ Bổ sung cấu hình UTF-8
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        int listingId = Integer.parseInt(request.getParameter("listingId"));

        if ("delete".equals(action)) {
            boolean success = listingBO.deleteListing(listingId);
            if (success) {
                request.setAttribute("message", "Xóa tin đăng thành công!");
            } else {
                request.setAttribute("error", "Không thể xóa tin đăng!");
            }
        }

        doGet(request, response);
    }
}