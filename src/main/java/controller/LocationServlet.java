package controller;

import dao.LocationDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/location")
public class LocationServlet extends HttpServlet {
    private LocationDAO locationDAO;
    
    @Override
    public void init() throws ServletException {
        locationDAO = new LocationDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("getDistricts".equals(action)) {
            String province = request.getParameter("province");
            List<String> districts = locationDAO.getDistrictsByProvince(province);
            
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            
            StringBuilder json = new StringBuilder();
            json.append("[");
            for (int i = 0; i < districts.size(); i++) {
                json.append("\"").append(districts.get(i)).append("\"");
                if (i < districts.size() - 1) {
                    json.append(",");
                }
            }
            json.append("]");
            
            response.getWriter().write(json.toString());
        }
    }
} 