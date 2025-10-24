package model;

import java.util.Date;

public class Warehouse_locations {

    private int location_id;
    private String code, area, aisle, slot;
    private int capacity;
    private String description;
    private Date created_at;

    public Warehouse_locations() {
    }

    public Warehouse_locations(int location_id, String code, String area, String aisle, String slot, int capacity, String description, Date created_at) {
        this.location_id = location_id;
        this.code = code;
        this.area = area;
        this.aisle = aisle;
        this.slot = slot;
        this.capacity = capacity;
        this.description = description;
        this.created_at = created_at;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAisle() {
        return aisle;
    }

    public void setAisle(String aisle) {
        this.aisle = aisle;
    }

    public String getSlot() {
        return slot;
    }

    public void setSlot(String slot) {
        this.slot = slot;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

}
