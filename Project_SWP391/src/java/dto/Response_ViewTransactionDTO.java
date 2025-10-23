package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Response_ViewTransactionDTO {

    private String receipt_no, po_code;
    private Date po_date;
    private String status;
    private Date received_at;
    private String employee_code, fullname, supplier_name, note;

    public Response_ViewTransactionDTO() {
    }

    public Response_ViewTransactionDTO(String receipt_no, String po_code, Date po_date, String status, Date received_at, String employee_code, String fullname, String supplier_name, String note) {
        this.receipt_no = receipt_no;
        this.po_code = po_code;
        this.po_date = po_date;
        this.status = status;
        this.received_at = received_at;
        this.employee_code = employee_code;
        this.fullname = fullname;
        this.supplier_name = supplier_name;
        this.note = note;
    }

    public String getReceipt_no() {
        return receipt_no;
    }

    public void setReceipt_no(String receipt_no) {
        this.receipt_no = receipt_no;
    }

    public String getPo_code() {
        return po_code;
    }

    public void setPo_code(String po_code) {
        this.po_code = po_code;
    }

    public Date getPo_date() {
        return po_date;
    }

    public void setPo_date(Date po_date) {
        this.po_date = po_date;
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

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getSupplier_name() {
        return supplier_name;
    }

    public void setSupplier_name(String supplier_name) {
        this.supplier_name = supplier_name;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
