package dao;

import bean.Image;
import config.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ImageDAO {
    
    public boolean addImage(Image image) {
        String sql = "INSERT INTO Images (listing_id, url) VALUES (?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, image.getListingId());
            ps.setString(2, image.getUrl());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Image> getImagesByListingId(int listingId) {
        List<Image> images = new ArrayList<>();
        String sql = "SELECT * FROM Images WHERE listing_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, listingId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Image image = new Image();
                image.setId(rs.getInt("id"));
                image.setListingId(rs.getInt("listing_id"));
                image.setUrl(rs.getString("url"));
                images.add(image);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return images;
    }
    
    public boolean deleteImagesByListingId(int listingId) {
        String sql = "DELETE FROM Images WHERE listing_id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, listingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 