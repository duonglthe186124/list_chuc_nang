package model;

public class Purchase_order_lines {

    private int po_line_id, po_id, product_id;
    private float unit_price;
    private int qty;
    private float line_amount;

    public Purchase_order_lines() {
    }

    public Purchase_order_lines(int po_line_id, int po_id, int product_id, float unit_price, int qty, float line_amount) {
        this.po_line_id = po_line_id;
        this.po_id = po_id;
        this.product_id = product_id;
        this.unit_price = unit_price;
        this.qty = qty;
        this.line_amount = line_amount;
    }

    public int getPo_line_id() {
        return po_line_id;
    }

    public void setPo_line_id(int po_line_id) {
        this.po_line_id = po_line_id;
    }

    public int getPo_id() {
        return po_id;
    }

    public void setPo_id(int po_id) {
        this.po_id = po_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public float getLine_amount() {
        return line_amount;
    }

    public void setLine_amount(float line_amount) {
        this.line_amount = line_amount;
    }

}
