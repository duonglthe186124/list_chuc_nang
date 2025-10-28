package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Response_TransactionDTO {

    private int receipt_id;
    private String receipt_no, status;
    private Date received_at;
    private String received_by, supplier;
    private int total_line, total_expected, total_received;
    private float total;

    public Response_TransactionDTO() {
    }

    public Response_TransactionDTO(int receipt_id, String receipt_no, String status, Date received_at, String received_by, String supplier, int total_line, int total_expected, int total_received, float total) {
        this.receipt_id = receipt_id;
        this.receipt_no = receipt_no;
        this.status = status;
        this.received_at = received_at;
        this.received_by = received_by;
        this.supplier = supplier;
        this.total_line = total_line;
        this.total_expected = total_expected;
        this.total_received = total_received;
        this.total = total;
    }

    public int getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(int receipt_id) {
        this.receipt_id = receipt_id;
    }

    public String getReceipt_no() {
        return receipt_no;
    }

    public void setReceipt_no(String receipt_no) {
        this.receipt_no = receipt_no;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getReceived_at() {
        return received_at;
    }

    public void setReceived_at(Date received_at) {
        this.received_at = received_at;
    }

    public String getReceived_by() {
        return received_by;
    }

    public void setReceived_by(String received_by) {
        this.received_by = received_by;
    }

    public String getSupplier() {
        return supplier;
    }

    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    public int getTotal_line() {
        return total_line;
    }

    public void setTotal_line(int total_line) {
        this.total_line = total_line;
    }

    public int getTotal_expected() {
        return total_expected;
    }

    public void setTotal_expected(int total_expected) {
        this.total_expected = total_expected;
    }

    public int getTotal_received() {
        return total_received;
    }

    public void setTotal_received(int total_received) {
        this.total_received = total_received;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

}
