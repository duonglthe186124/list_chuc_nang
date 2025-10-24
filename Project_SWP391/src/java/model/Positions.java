package model;

public class Positions {

    private int position_id;
    private String position_name, description;

    public Positions() {
    }

    public Positions(int position_id, String position_name, String description) {
        this.position_id = position_id;
        this.position_name = position_name;
        this.description = description;
    }

    public int getPosition_id() {
        return position_id;
    }

    public void setPosition_id(int position_id) {
        this.position_id = position_id;
    }

    public String getPosition_name() {
        return position_name;
    }

    public void setPosition_name(String position_name) {
        this.position_name = position_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
