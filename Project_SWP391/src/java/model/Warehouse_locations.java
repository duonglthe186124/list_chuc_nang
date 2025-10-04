package model;

public class Warehouse_locations {

    private int location_id;
    private String code, area, ailse, slot;
    private int max_capacity, current_capacity;
    private String description;

    public Warehouse_locations() {
    }

    public Warehouse_locations(int location_id, String code, String area, String ailse, String slot, int max_capacity, int current_capacity, String description) {
        this.location_id = location_id;
        this.code = code;
        this.area = area;
        this.ailse = ailse;
        this.slot = slot;
        this.max_capacity = max_capacity;
        this.current_capacity = current_capacity;
        this.description = description;
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

    public String getAilse() {
        return ailse;
    }

    public void setAilse(String ailse) {
        this.ailse = ailse;
    }

    public String getSlot() {
        return slot;
    }

    public void setSlot(String slot) {
        this.slot = slot;
    }

    public int getMax_capacity() {
        return max_capacity;
    }

    public void setMax_capacity(int max_capacity) {
        this.max_capacity = max_capacity;
    }

    public int getCurrent_capacity() {
        return current_capacity;
    }

    public void setCurrent_capacity(int current_capacity) {
        this.current_capacity = current_capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
