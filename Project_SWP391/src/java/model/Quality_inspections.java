package model;

import java.util.Date;

public class Quality_inspections {
    private int inspection_id;
    private String inspection_no;
    private int unit_id, location_id, inspected_by;
    private Date inspected_date;
    private String status, result, note;

    public Quality_inspections() {
    }

    public Quality_inspections(int inspection_id, String inspection_no, int unit_id, int location_id, int inspected_by, Date inspected_date, String status, String result, String note) {
        this.inspection_id = inspection_id;
        this.inspection_no = inspection_no;
        this.unit_id = unit_id;
        this.location_id = location_id;
        this.inspected_by = inspected_by;
        this.inspected_date = inspected_date;
        this.status = status;
        this.result = result;
        this.note = note;
    }

    public int getInspection_id() {
        return inspection_id;
    }

    public void setInspection_id(int inspection_id) {
        this.inspection_id = inspection_id;
    }

    public String getInspection_no() {
        return inspection_no;
    }

    public void setInspection_no(String inspection_no) {
        this.inspection_no = inspection_no;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public int getInspected_by() {
        return inspected_by;
    }

    public void setInspected_by(int inspected_by) {
        this.inspected_by = inspected_by;
    }

    public Date getInspected_date() {
        return inspected_date;
    }

    public void setInspected_date(Date inspected_date) {
        this.inspected_date = inspected_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
    
}
