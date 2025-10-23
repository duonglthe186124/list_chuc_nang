package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Request_PurchaseOrderDTO {

    private String po_code;
    private int supplier_id, created_by;
    private Date created_at;
    private float total_amount;
    private String status, note;

    public Request_PurchaseOrderDTO() {
    }

    public Request_PurchaseOrderDTO(String po_code, int supplier_id, int created_by, Date created_at, float total_amount, String status, String note) {
        this.po_code = po_code;
        this.supplier_id = supplier_id;
        this.created_by = created_by;
        this.created_at = created_at;
        this.total_amount = total_amount;
        this.status = status;
        this.note = note;
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

    public float getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(float total_amount) {
        this.total_amount = total_amount;
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
