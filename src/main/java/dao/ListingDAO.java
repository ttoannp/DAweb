package dao;

import bean.Listing;
import bean.User;
import bean.Location;
import bean.Category;
import config.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListingDAO {
    
    public int addListing(Listing listing) {
        String sql = "INSERT INTO Listings (user_id, title, description, price, area, location_id, category_id) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, listing.getUserId());
            ps.setString(2, listing.getTitle());
            ps.setString(3, listing.getDescription());
            ps.setLong(4, listing.getPrice());
            ps.setFloat(5, listing.getArea());
            ps.setInt(6, listing.getLocationId());
            ps.setInt(7, listing.getCategoryId());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }
    
    public Listing getListingById(int id) {
        String sql = "SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, " +
                    "loc.province, loc.district, loc.ward, loc.address, " +
                    "c.name as category_name " +
                    "FROM Listings l " +
                    "JOIN Users u ON l.user_id = u.id " +
                    "JOIN Locations loc ON l.location_id = loc.id " +
                    "JOIN Categories c ON l.category_id = c.id " +
                    "WHERE l.id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToListing(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<Listing> getApprovedListings() {
        List<Listing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, " +
                    "loc.province, loc.district, loc.ward, loc.address, " +
                    "c.name as category_name " +
                    "FROM Listings l " +
                    "JOIN Users u ON l.user_id = u.id " +
                    "JOIN Locations loc ON l.location_id = loc.id " +
                    "JOIN Categories c ON l.category_id = c.id " +
                    "WHERE l.status = 'approved' " +
                    "ORDER BY l.created_at DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public List<Listing> getPendingListings() {
        List<Listing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, " +
                    "loc.province, loc.district, loc.ward, loc.address, " +
                    "c.name as category_name " +
                    "FROM Listings l " +
                    "JOIN Users u ON l.user_id = u.id " +
                    "JOIN Locations loc ON l.location_id = loc.id " +
                    "JOIN Categories c ON l.category_id = c.id " +
                    "WHERE l.status = 'pending' " +
                    "ORDER BY l.created_at DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public List<Listing> getListingsByUserId(int userId) {
        List<Listing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, " +
                    "loc.province, loc.district, loc.ward, loc.address, " +
                    "c.name as category_name " +
                    "FROM Listings l " +
                    "JOIN Users u ON l.user_id = u.id " +
                    "JOIN Locations loc ON l.location_id = loc.id " +
                    "JOIN Categories c ON l.category_id = c.id " +
                    "WHERE l.user_id = ? " +
                    "ORDER BY l.created_at DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public boolean updateListingStatus(int listingId, String status) {
        String sql = "UPDATE Listings SET status = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setInt(2, listingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Listing> searchListings(String keyword, String province, String district, int categoryId, long minPrice, long maxPrice) {
        List<Listing> listings = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, ");
        sql.append("loc.province, loc.district, loc.ward, loc.address, ");
        sql.append("c.name as category_name ");
        sql.append("FROM Listings l ");
        sql.append("JOIN Users u ON l.user_id = u.id ");
        sql.append("JOIN Locations loc ON l.location_id = loc.id ");
        sql.append("JOIN Categories c ON l.category_id = c.id ");
        sql.append("WHERE l.status = 'approved' ");
        
        List<Object> params = new ArrayList<>();
        int paramIndex = 1;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (l.title LIKE ? OR l.description LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            paramIndex += 2;
        }
        
        if (province != null && !province.trim().isEmpty()) {
            sql.append("AND loc.province = ? ");
            params.add(province);
            paramIndex++;
        }
        
        if (district != null && !district.trim().isEmpty()) {
            sql.append("AND loc.district = ? ");
            params.add(district);
            paramIndex++;
        }
        
        if (categoryId > 0) {
            sql.append("AND l.category_id = ? ");
            params.add(categoryId);
            paramIndex++;
        }
        
        if (minPrice > 0) {
            sql.append("AND l.price >= ? ");
            params.add(minPrice);
            paramIndex++;
        }
        
        if (maxPrice > 0) {
            sql.append("AND l.price <= ? ");
            params.add(maxPrice);
            paramIndex++;
        }
        
        sql.append("ORDER BY l.created_at DESC");
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public boolean deleteListing(int listingId) {
        String sql = "DELETE FROM Listings WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, listingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean updateListing(Listing listing) {
        String sql = "UPDATE Listings SET title = ?, description = ?, price = ?, area = ?, category_id = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, listing.getTitle());
            ps.setString(2, listing.getDescription());
            ps.setLong(3, listing.getPrice());
            ps.setFloat(4, listing.getArea());
            ps.setInt(5, listing.getCategoryId());
            ps.setString(6, listing.getStatus());
            ps.setInt(7, listing.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int getApprovedListingsCount() {
        String sql = "SELECT COUNT(*) FROM Listings WHERE status = 'approved'";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<Listing> getApprovedListingsByUserId(int userId) {
        List<Listing> listings = new ArrayList<>();
        String sql = "SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, " +
                    "loc.province, loc.district, loc.ward, loc.address, " +
                    "c.name as category_name " +
                    "FROM Listings l " +
                    "JOIN Users u ON l.user_id = u.id " +
                    "JOIN Locations loc ON l.location_id = loc.id " +
                    "JOIN Categories c ON l.category_id = c.id " +
                    "WHERE l.user_id = ? AND l.status = 'approved' " +
                    "ORDER BY l.created_at DESC";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    public List<Listing> getListingsWithSorting(String keyword, String province, String district, int categoryId, long minPrice, long maxPrice, String sortBy) {
        List<Listing> listings = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT l.*, u.fullname as user_fullname, u.phone as user_phone, ");
        sql.append("loc.province, loc.district, loc.ward, loc.address, ");
        sql.append("c.name as category_name ");
        sql.append("FROM Listings l ");
        sql.append("JOIN Users u ON l.user_id = u.id ");
        sql.append("JOIN Locations loc ON l.location_id = loc.id ");
        sql.append("JOIN Categories c ON l.category_id = c.id ");
        sql.append("WHERE l.status = 'approved' ");
        
        List<Object> params = new ArrayList<>();
        int paramIndex = 1;
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (l.title LIKE ? OR l.description LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
            paramIndex += 2;
        }
        
        if (province != null && !province.trim().isEmpty()) {
            sql.append("AND loc.province = ? ");
            params.add(province);
            paramIndex++;
        }
        
        if (district != null && !district.trim().isEmpty()) {
            sql.append("AND loc.district = ? ");
            params.add(district);
            paramIndex++;
        }
        
        if (categoryId > 0) {
            sql.append("AND l.category_id = ? ");
            params.add(categoryId);
            paramIndex++;
        }
        
        if (minPrice > 0) {
            sql.append("AND l.price >= ? ");
            params.add(minPrice);
            paramIndex++;
        }
        
        if (maxPrice > 0) {
            sql.append("AND l.price <= ? ");
            params.add(maxPrice);
            paramIndex++;
        }
        
        // Add sorting
        if ("oldest".equals(sortBy)) {
            sql.append("ORDER BY l.created_at ASC");
        } else if ("newest".equals(sortBy)) {
            sql.append("ORDER BY l.created_at DESC");
        } else {
            sql.append("ORDER BY l.created_at DESC");
        }
        
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                listings.add(mapResultSetToListing(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listings;
    }
    
    private Listing mapResultSetToListing(ResultSet rs) throws SQLException {
        Listing listing = new Listing();
        listing.setId(rs.getInt("id"));
        listing.setUserId(rs.getInt("user_id"));
        listing.setTitle(rs.getString("title"));
        listing.setDescription(rs.getString("description"));
        listing.setPrice(rs.getLong("price"));
        listing.setArea(rs.getFloat("area"));
        listing.setLocationId(rs.getInt("location_id"));
        listing.setCategoryId(rs.getInt("category_id"));
        listing.setStatus(rs.getString("status"));
        listing.setCreatedAt(rs.getTimestamp("created_at"));
        
        // Set related objects
        User user = new User();
        user.setId(rs.getInt("user_id"));
        user.setFullname(rs.getString("user_fullname"));
        user.setPhone(rs.getString("user_phone"));
        listing.setUser(user);
        
        Location location = new Location();
        location.setId(rs.getInt("location_id"));
        location.setProvince(rs.getString("province"));
        location.setDistrict(rs.getString("district"));
        location.setWard(rs.getString("ward"));
        location.setAddress(rs.getString("address"));
        listing.setLocation(location);
        
        Category category = new Category();
        category.setId(rs.getInt("category_id"));
        category.setName(rs.getString("category_name"));
        listing.setCategory(category);
        
        return listing;
    }
    
} 