package model;

public class Containers {

    private int container_id;
    private String container_code;
    private int box_type, location_id;

    public Containers() {
    }

    public Containers(int container_id, String container_code, int box_type, int location_id) {
        this.container_id = container_id;
        this.container_code = container_code;
        this.box_type = box_type;
        this.location_id = location_id;
    }

    public int getContainer_id() {
        return container_id;
    }

    public void setContainer_id(int container_id) {
        this.container_id = container_id;
    }

    public String getContainer_code() {
        return container_code;
    }

    public void setContainer_code(String container_code) {
        this.container_code = container_code;
    }

    public int getBox_type() {
        return box_type;
    }

    public void setBox_type(int box_type) {
        this.box_type = box_type;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

}
