package model;

public class Box_types {

    private int box_id;
    private String box_code;
    private int capacity;
    private String description;

    public Box_types() {
    }

    public Box_types(int box_id, String box_code, int capacity, String description) {
        this.box_id = box_id;
        this.box_code = box_code;
        this.capacity = capacity;
        this.description = description;
    }

    public int getBox_id() {
        return box_id;
    }

    public void setBox_id(int box_id) {
        this.box_id = box_id;
    }

    public String getBox_code() {
        return box_code;
    }

    public void setBox_code(String box_code) {
        this.box_code = box_code;
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

}
