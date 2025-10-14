package model;

import java.util.Date;

public class Inventory_transactions {

    private int tx_id;
    private String tx_type;
    private int product_id, unit_id, qty;
    private Integer from_location, to_location;
    private String ref_code;
    private Integer related_inbound_id, related_outbound_id;
    private int employee_id;
    private Date tx_date;
    private String note;

    public Inventory_transactions() {
    }

    public Inventory_transactions(int tx_id, String tx_type, int product_id, int unit_id, int qty, Integer from_location, Integer to_location, String ref_code, Integer related_inbound_id, Integer related_outbound_id, int employee_id, Date tx_date, String note) {
        this.tx_id = tx_id;
        this.tx_type = tx_type;
        this.product_id = product_id;
        this.unit_id = unit_id;
        this.qty = qty;
        this.from_location = from_location;
        this.to_location = to_location;
        this.ref_code = ref_code;
        this.related_inbound_id = related_inbound_id;
        this.related_outbound_id = related_outbound_id;
        this.employee_id = employee_id;
        this.tx_date = tx_date;
        this.note = note;
    }

    public int getTx_id() {
        return tx_id;
    }

    public void setTx_id(int tx_id) {
        this.tx_id = tx_id;
    }

    public String getTx_type() {
        return tx_type;
    }

    public void setTx_type(String tx_type) {
        this.tx_type = tx_type;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public Integer getFrom_location() {
        return from_location;
    }

    public void setFrom_location(Integer from_location) {
        this.from_location = from_location;
    }

    public Integer getTo_location() {
        return to_location;
    }

    public void setTo_location(Integer to_location) {
        this.to_location = to_location;
    }

    public String getRef_code() {
        return ref_code;
    }

    public void setRef_code(String ref_code) {
        this.ref_code = ref_code;
    }

    public Integer getRelated_inbound_id() {
        return related_inbound_id;
    }

    public void setRelated_inbound_id(Integer related_inbound_id) {
        this.related_inbound_id = related_inbound_id;
    }

    public Integer getRelated_outbound_id() {
        return related_outbound_id;
    }

    public void setRelated_outbound_id(Integer related_outbound_id) {
        this.related_outbound_id = related_outbound_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public Date getTx_date() {
        return tx_date;
    }

    public void setTx_date(Date tx_date) {
        this.tx_date = tx_date;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
