package model;

import java.util.Date;

public class Outbound_inventory {
    private int outbound_id;
    private String oubound_code;
    private int user_id, created_by;
    private Date created_at;
    private String note;

    public Outbound_inventory() {
    }

    public Outbound_inventory(int outbound_id, String oubound_code, int user_id, int created_by, Date created_at, String note) {
        this.outbound_id = outbound_id;
        this.oubound_code = oubound_code;
        this.user_id = user_id;
        this.created_by = created_by;
        this.created_at = created_at;
        this.note = note;
    }

    public int getOutbound_id() {
        return outbound_id;
    }

    public void setOutbound_id(int outbound_id) {
        this.outbound_id = outbound_id;
    }

    public String getOubound_code() {
        return oubound_code;
    }

    public void setOubound_code(String oubound_code) {
        this.oubound_code = oubound_code;
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

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
    
}
