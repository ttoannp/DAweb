package bo;

import bean.Listing;
import bean.Location;
import bean.Image;
import dao.ListingDAO;
import dao.LocationDAO;
import dao.ImageDAO;

import java.util.List;

public class ListingBO {
    private ListingDAO listingDAO;
    private LocationDAO locationDAO;
    private ImageDAO imageDAO;
    
    public ListingBO() {
        listingDAO = new ListingDAO();
        locationDAO = new LocationDAO();
        imageDAO = new ImageDAO();
    }
    
    public boolean addListing(Listing listing, List<String> imageUrls) {
        // Thêm location trước
        int locationId = locationDAO.addLocation(listing.getLocation());
        if (locationId == -1) {
            return false;
        }
        
        listing.setLocationId(locationId);
        
        // Thêm listing
        int listingId = listingDAO.addListing(listing);
        if (listingId == -1) {
            return false;
        }
        
        // Thêm images
        if (imageUrls != null && !imageUrls.isEmpty()) {
            for (String imageUrl : imageUrls) {
                Image image = new Image(listingId, imageUrl);
                imageDAO.addImage(image);
            }
        }
        
        return true;
    }
    
    public Listing getListingById(int id) {
        Listing listing = listingDAO.getListingById(id);
        if (listing != null) {
            // Lấy images cho listing
            listing.setImages(imageDAO.getImagesByListingId(id));
        }
        return listing;
    }
    
    public List<Listing> getApprovedListings() {
        List<Listing> listings = listingDAO.getApprovedListings();
        // Lấy images cho mỗi listing
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }
    
    public List<Listing> getPendingListings() {
        return listingDAO.getPendingListings();
    }
    
    public List<Listing> getListingsByUserId(int userId) {
        List<Listing> listings = listingDAO.getListingsByUserId(userId);
        // Lấy images cho mỗi listing
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }
    
    public boolean updateListingStatus(int listingId, String status) {
        return listingDAO.updateListingStatus(listingId, status);
    }
    
    public List<Listing> searchListings(String keyword, String province, String district, int categoryId, long minPrice, long maxPrice) {
        List<Listing> listings = listingDAO.searchListings(keyword, province, district, categoryId, minPrice, maxPrice);
        // Lấy images cho mỗi listing
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }
    
    public boolean deleteListing(int listingId) {
        return listingDAO.deleteListing(listingId);
    }
    
    public boolean updateListing(Listing listing, List<String> imageUrls) {
        // Cập nhật location
        boolean locationUpdated = locationDAO.updateLocation(listing.getLocationId(), listing.getLocation());
        if (!locationUpdated) {
            return false;
        }
        
        // Cập nhật listing
        boolean listingUpdated = listingDAO.updateListing(listing);
        if (!listingUpdated) {
            return false;
        }
        
        // Nếu có ảnh mới, thêm vào
        if (imageUrls != null && !imageUrls.isEmpty()) {
            for (String imageUrl : imageUrls) {
                Image image = new Image(listing.getId(), imageUrl);
                imageDAO.addImage(image);
            }
        }
        
        return true;
    }
    
    public int getApprovedListingsCount() {
        return listingDAO.getApprovedListingsCount();
    }
    
    public List<Listing> getApprovedListingsByUserId(int userId) {
        List<Listing> listings = listingDAO.getApprovedListingsByUserId(userId);
        // Lấy images cho mỗi listing
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }
    public List<Listing> getAllListingsByUserId(int userId) {
        List<Listing> listings = listingDAO.getListingsByUserId(userId);
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }


    public List<Listing> searchListingsWithSorting(String keyword, String province, String district, int categoryId, long minPrice, long maxPrice, String sortBy) {
        List<Listing> listings = listingDAO.getListingsWithSorting(keyword, province, district, categoryId, minPrice, maxPrice, sortBy);
        // Lấy images cho mỗi listing
        for (Listing listing : listings) {
            listing.setImages(imageDAO.getImagesByListingId(listing.getId()));
        }
        return listings;
    }

} 