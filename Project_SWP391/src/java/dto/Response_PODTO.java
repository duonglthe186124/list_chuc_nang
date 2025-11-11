package dto;

import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */
public class Response_PODTO {

    private int po_id;
    private String po_code, supplier;
    private int received, total;
    private float total_amount;
    private String created_by;
    private LocalDateTime created_at;
    private String status;

    public Response_PODTO() {
    }

    public Response_PODTO(int po_id, String po_code, String supplier, int received, int total, float total_amount, String created_by, LocalDateTime created_at, String status) {
        this.po_id = po_id;
        this.po_code = po_code;
        this.supplier = supplier;
        this.received = received;
        this.total = total;
        this.total_amount = total_amount;
        this.created_by = created_by;
        this.created_at = created_at;
        this.status = status;
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

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public int getReceived() {
        return received;
    }

    public void setReceived(int received) {
        this.received = received;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public float getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(float total_amount) {
        this.total_amount = total_amount;
    }

    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
