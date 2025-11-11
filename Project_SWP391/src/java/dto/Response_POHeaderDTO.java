package dto;

import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */
public class Response_POHeaderDTO {

    private int po_id;
    private String po_code, supplier_name;
    private LocalDateTime created_at;
    private String created_by, status, note;
    private float total_amount;

    public Response_POHeaderDTO() {
    }

    public Response_POHeaderDTO(int po_id, String po_code, String supplier_name, LocalDateTime created_at, String created_by, String status, String note, float total_amount) {
        this.po_id = po_id;
        this.po_code = po_code;
        this.supplier_name = supplier_name;
        this.created_at = created_at;
        this.created_by = created_by;
        this.status = status;
        this.note = note;
        this.total_amount = total_amount;
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

    public String getSupplier_name() {
        return supplier_name;
    }

    public void setSupplier_name(String supplier_name) {
        this.supplier_name = supplier_name;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
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

    public float getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(float total_amount) {
        this.total_amount = total_amount;
    }

}
