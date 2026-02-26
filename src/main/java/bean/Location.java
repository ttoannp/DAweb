package bean;

public class Location {
    private int id;
    private String province;
    private String district;
    private String ward;
    private String address;

    public Location() {}

    public Location(String province, String district, String ward, String address) {
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.address = address;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getWard() {
        return ward;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getFullAddress() {
        StringBuilder sb = new StringBuilder();
        if (address != null && !address.isEmpty()) {
            sb.append(address).append(", ");
        }
        if (ward != null && !ward.isEmpty()) {
            sb.append(ward).append(", ");
        }
        if (district != null && !district.isEmpty()) {
            sb.append(district).append(", ");
        }
        if (province != null && !province.isEmpty()) {
            sb.append(province);
        }
        return sb.toString();
    }
} 