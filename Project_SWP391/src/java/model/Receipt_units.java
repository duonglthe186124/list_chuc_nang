package model;

public class Receipt_units {

    private int id, line_id, unit_id;

    public Receipt_units() {
    }

    public Receipt_units(int id, int line_id, int unit_id) {
        this.id = id;
        this.line_id = line_id;
        this.unit_id = unit_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getLine_id() {
        return line_id;
    }

    public void setLine_id(int line_id) {
        this.line_id = line_id;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

}
