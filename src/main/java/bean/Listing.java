package bean;

import java.sql.Timestamp;
import java.util.List;

public class Listing {
    private int id;
    private int userId;
    private String title;
    private String description;
    private long price;
    private float area;
    private int locationId;
    private int categoryId;
    private String status;
    private Timestamp createdAt;
    
    // Related objects
    private User user;
    private Location location;
    private Category category;
    private List<Image> images;

    public Listing() {}

    public Listing(int userId, String title, String description, long price, float area, int locationId, int categoryId) {
        this.userId = userId;
        this.title = title;
        this.description = description;
        this.price = price;
        this.area = area;
        this.locationId = locationId;
        this.categoryId = categoryId;
        this.status = "pending";
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getPrice() {
        return price;
    }

    public void setPrice(long price) {
        this.price = price;
    }

    public float getArea() {
        return area;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public int getLocationId() {
        return locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<Image> getImages() {
        return images;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public String getFormattedPrice() {
        return String.format("%,d VND", price);
    }

    public String getFormattedArea() {
        return String.format("%.1f m2", area);
    }
} 