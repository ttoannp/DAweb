package bean;

public class Image {
    private int id;
    private int listingId;
    private String url;

    public Image() {}

    public Image(int listingId, String url) {
        this.listingId = listingId;
        this.url = url;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getListingId() {
        return listingId;
    }

    public void setListingId(int listingId) {
        this.listingId = listingId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
} 