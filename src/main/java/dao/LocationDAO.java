package dao;

import bean.Location;
import config.DBConnect;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class LocationDAO {
    
    public int addLocation(Location location) {
        String sql = "INSERT INTO Locations (province, district, ward, address) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, location.getProvince());
            ps.setString(2, location.getDistrict());
            ps.setString(3, location.getWard());
            ps.setString(4, location.getAddress());
            
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
    
    public Location getLocationById(int id) {
        String sql = "SELECT * FROM Locations WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Location location = new Location();
                location.setId(rs.getInt("id"));
                location.setProvince(rs.getString("province"));
                location.setDistrict(rs.getString("district"));
                location.setWard(rs.getString("ward"));
                location.setAddress(rs.getString("address"));
                return location;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<String> getAllProvinces() {
        List<String> provinces = new ArrayList<>();
        String sql = "SELECT DISTINCT province FROM Locations ORDER BY province";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                provinces.add(rs.getString("province"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return provinces;
    }
    
    public List<String> getDistrictsByProvince(String province) {
        List<String> districts = new ArrayList<>();
        String sql = "SELECT DISTINCT district FROM Locations WHERE province = ? ORDER BY district";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, province);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                districts.add(rs.getString("district"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return districts;
    }
    
    public boolean updateLocation(int locationId, Location location) {
        String sql = "UPDATE Locations SET province = ?, district = ?, ward = ?, address = ? WHERE id = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, location.getProvince());
            ps.setString(2, location.getDistrict());
            ps.setString(3, location.getWard());
            ps.setString(4, location.getAddress());
            ps.setInt(5, locationId);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean addProvince(String province) {
        String sql = "INSERT INTO Locations (province) VALUES (?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, province);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean addDistrict(String province, String district) {
        String sql = "INSERT INTO Locations (province, district) VALUES (?, ?)";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, province);
            ps.setString(2, district);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
} 