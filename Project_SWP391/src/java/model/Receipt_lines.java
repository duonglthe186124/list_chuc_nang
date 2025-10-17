package model;

public class Receipt_lines {

    private int line_id, receipt_id, product_id, qty_expected, qty_received;
    private float unit_price;
    private String note;

    public Receipt_lines() {
    }

    public Receipt_lines(int line_id, int receipt_id, int product_id, int qty_expected, int qty_received, float unit_price, String note) {
        this.line_id = line_id;
        this.receipt_id = receipt_id;
        this.product_id = product_id;
        this.qty_expected = qty_expected;
        this.qty_received = qty_received;
        this.unit_price = unit_price;
        this.note = note;
    }

    public int getLine_id() {
        return line_id;
    }

    public void setLine_id(int line_id) {
        this.line_id = line_id;
    }

    public int getReceipt_id() {
        return receipt_id;
    }

    public void setReceipt_id(int receipt_id) {
        this.receipt_id = receipt_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getQty_expected() {
        return qty_expected;
    }

    public void setQty_expected(int qty_expected) {
        this.qty_expected = qty_expected;
    }

    public int getQty_received() {
        return qty_received;
    }

    public void setQty_received(int qty_received) {
        this.qty_received = qty_received;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
