package model;

import java.util.Date;

public class Purchase_orders {

    private int po_id;
    private String po_code;
    private int supplier_id, created_by;
    private Date created_at;
    private String status;
    private float total_amount;
    private String note;

    public Purchase_orders() {
    }

    public Purchase_orders(int po_id, String po_code, int supplier_id, int created_by, Date created_at, String status, float total_amount, String note) {
        this.po_id = po_id;
        this.po_code = po_code;
        this.supplier_id = supplier_id;
        this.created_by = created_by;
        this.created_at = created_at;
        this.status = status;
        this.total_amount = total_amount;
        this.note = note;
    }

    public int getPo_id() {
        return po_id;
    }

    public void setPo_id(int po_id) {
        this.po_id = po_id;
    }

    public String getPo_code() {
        return po_code;
    }

    public void setPo_code(String po_code) {
        this.po_code = po_code;
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public float getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(float total_amount) {
        this.total_amount = total_amount;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
