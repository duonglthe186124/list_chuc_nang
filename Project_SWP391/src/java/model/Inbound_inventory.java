package model;

import java.util.Date;

public class Inbound_inventory {

    private int inbound_id;
    private String inbound_code;
    private int supplier_id, po_id, received_by;
    private Date received_at;
    private String note;

    public Inbound_inventory() {
    }

    public Inbound_inventory(int inbound_id, String inbound_code, int supplier_id, int po_id, int received_by, Date received_at, String note) {
        this.inbound_id = inbound_id;
        this.inbound_code = inbound_code;
        this.supplier_id = supplier_id;
        this.po_id = po_id;
        this.received_by = received_by;
        this.received_at = received_at;
        this.note = note;
    }

    public int getInbound_id() {
        return inbound_id;
    }

    public void setInbound_id(int inbound_id) {
        this.inbound_id = inbound_id;
    }

    public String getInbound_code() {
        return inbound_code;
    }

    public void setInbound_code(String inbound_code) {
        this.inbound_code = inbound_code;
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public int getPo_id() {
        return po_id;
    }

    public void setPo_id(int po_id) {
        this.po_id = po_id;
    }

    public int getReceived_by() {
        return received_by;
    }

    public void setReceived_by(int received_by) {
        this.received_by = received_by;
    }

    public Date getReceived_at() {
        return received_at;
    }

    public void setReceived_at(Date received_at) {
        this.received_at = received_at;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
