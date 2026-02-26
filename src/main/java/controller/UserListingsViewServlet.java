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

@WebServlet("/view-user-listings/*")
public class UserListingsViewServlet extends HttpServlet {
    private ListingBO listingBO;
    
    @Override
    public void init() throws ServletException {
        listingBO = new ListingBO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int userId = Integer.parseInt(pathInfo.substring(1));
            List<Listing> approvedListings = listingBO.getApprovedListingsByUserId(userId);
            
            request.setAttribute("listings", approvedListings);
            request.setAttribute("userId", userId);
            request.getRequestDispatcher("/view/user-listings-view.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
} 