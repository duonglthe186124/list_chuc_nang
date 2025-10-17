package model;

import java.util.Date;

public class Receipts {

    private int receipts_id;
    private String receipts_no;
    private int po_id, received_by;
    private String status, note;
    private Date received_at;

    public Receipts() {
    }

    public Receipts(int receipts_id, String receipts_no, int po_id, int received_by, String status, String note, Date received_at) {
        this.receipts_id = receipts_id;
        this.receipts_no = receipts_no;
        this.po_id = po_id;
        this.received_by = received_by;
        this.status = status;
        this.note = note;
        this.received_at = received_at;
    }

    public int getReceipts_id() {
        return receipts_id;
    }

    public void setReceipts_id(int receipts_id) {
        this.receipts_id = receipts_id;
    }

    public String getReceipts_no() {
        return receipts_no;
    }

    public void setReceipts_no(String receipts_no) {
        this.receipts_no = receipts_no;
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

    public Date getReceived_at() {
        return received_at;
    }

    public void setReceived_at(Date received_at) {
        this.received_at = received_at;
    }

}
