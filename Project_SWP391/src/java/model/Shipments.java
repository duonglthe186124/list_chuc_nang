package model;

import java.util.Date;

public class Shipments {

    private int shipment_id;
    private String shipment_no;
    private int user_id, created_by;
    private Date requested_at;
    private String status, note;

    public Shipments() {
    }

    public Shipments(int shipment_id, String shipment_no, int user_id, int created_by, Date requested_at, String status, String note) {
        this.shipment_id = shipment_id;
        this.shipment_no = shipment_no;
        this.user_id = user_id;
        this.created_by = created_by;
        this.requested_at = requested_at;
        this.status = status;
        this.note = note;
    }

    public int getShipment_id() {
        return shipment_id;
    }

    public void setShipment_id(int shipment_id) {
        this.shipment_id = shipment_id;
    }

    public String getShipment_no() {
        return shipment_no;
    }

    public void setShipment_no(String shipment_no) {
        this.shipment_no = shipment_no;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }

    public Date getRequested_at() {
        return requested_at;
    }

    public void setRequested_at(Date requested_at) {
        this.requested_at = requested_at;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
