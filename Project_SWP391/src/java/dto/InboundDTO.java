/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;

public class InboundDTO {
    private int receipts_id;
    private String receipts_no;
    private String supplier_name;
    private String employee_code;
    private String status;
    private String note;
    private Date received_at;

    public int getReceipts_id() { return receipts_id; }
    public void setReceipts_id(int receipts_id) { this.receipts_id = receipts_id; }

    public String getReceipts_no() { return receipts_no; }
    public void setReceipts_no(String receipts_no) { this.receipts_no = receipts_no; }

    public String getSupplier_name() { return supplier_name; }
    public void setSupplier_name(String supplier_name) { this.supplier_name = supplier_name; }

    public String getEmployee_code() { return employee_code; }
    public void setEmployee_code(String employee_code) { this.employee_code = employee_code; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Date getReceived_at() { return received_at; }
    public void setReceived_at(Date received_at) { this.received_at = received_at; }
}
