package model;

public class Return_lines {

    private int return_line_id, return_id, unit_id;
    private String reason;

    public Return_lines() {
    }

    public Return_lines(int return_line_id, int return_id, int unit_id, String reason) {
        this.return_line_id = return_line_id;
        this.return_id = return_id;
        this.unit_id = unit_id;
        this.reason = reason;
    }

    public int getReturn_line_id() {
        return return_line_id;
    }

    public void setReturn_line_id(int return_line_id) {
        this.return_line_id = return_line_id;
    }

    public int getReturn_id() {
        return return_id;
    }

    public void setReturn_id(int return_id) {
        this.return_id = return_id;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

}
