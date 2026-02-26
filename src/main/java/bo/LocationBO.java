package bo;

import bean.Location;
import dao.LocationDAO;

import java.util.List;

public class LocationBO {
    private LocationDAO locationDAO;
    
    public LocationBO() {
        locationDAO = new LocationDAO();
    }
    
    public int addLocation(Location location) {
        return locationDAO.addLocation(location);
    }
    
    public Location getLocationById(int id) {
        return locationDAO.getLocationById(id);
    }
    
    public List<String> getAllProvinces() {
        return locationDAO.getAllProvinces();
    }
    
    public List<String> getDistrictsByProvince(String province) {
        return locationDAO.getDistrictsByProvince(province);
    }
    
    public boolean updateLocation(int locationId, Location location) {
        return locationDAO.updateLocation(locationId, location);
    }
    
    public boolean addProvince(String province) {
        return locationDAO.addProvince(province);
    }
    
    public boolean addDistrict(String province, String district) {
        return locationDAO.addDistrict(province, district);
    }
} 