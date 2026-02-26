package controller;

import bean.Listing;
import bo.ListingBO;
import bo.CategoryBO;
import bo.UserBO;
import dao.LocationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private ListingBO listingBO;
    private CategoryBO categoryBO;
    private UserBO userBO;
    private LocationDAO locationDAO;
    
    @Override
    public void init() throws ServletException {
        listingBO = new ListingBO();
        categoryBO = new CategoryBO();
        userBO = new UserBO();
        locationDAO = new LocationDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String province = request.getParameter("province");
        String district = request.getParameter("district");
        String categoryIdStr = request.getParameter("categoryId");
        String minPriceStr = request.getParameter("minPrice");
        String maxPriceStr = request.getParameter("maxPrice");
        String sortBy = request.getParameter("sortBy");
        
        int categoryId = 0;
        long minPrice = 0;
        long maxPrice = 0;
        
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                categoryId = Integer.parseInt(categoryIdStr);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            try {
                minPrice = Long.parseLong(minPriceStr);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            try {
                maxPrice = Long.parseLong(maxPriceStr);
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        
        List<Listing> listings = listingBO.searchListingsWithSorting(keyword, province, district, categoryId, minPrice, maxPrice, sortBy);
        List<bean.Category> categories = categoryBO.getAllCategories();
        List<String> provinces = locationDAO.getAllProvinces();
        List<String> districts = new ArrayList<>();
        
        if (province != null && !province.trim().isEmpty()) {
            districts = locationDAO.getDistrictsByProvince(province);
        }
        
        request.setAttribute("listings", listings);
        request.setAttribute("categories", categories);
        request.setAttribute("provinces", provinces);
        request.setAttribute("districts", districts);
        // Get top users with most listings
        List<bean.User> topUsers = userBO.getUsersWithMostListings(10);
        
        request.setAttribute("keyword", keyword);
        request.setAttribute("province", province);
        request.setAttribute("district", district);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("topUsers", topUsers);
        
        request.getRequestDispatcher("/view/home.jsp").forward(request, response);
    }
} 