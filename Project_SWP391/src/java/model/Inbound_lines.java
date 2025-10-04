package model;

public class Inbound_lines {

    private int inbound_line_id, inbound_id, product_id, unit_id, qty;
    private float unit_price;

    public Inbound_lines() {
    }

    public Inbound_lines(int inbound_line_id, int inbound_id, int product_id, int unit_id, int qty, float unit_price) {
        this.inbound_line_id = inbound_line_id;
        this.inbound_id = inbound_id;
        this.product_id = product_id;
        this.unit_id = unit_id;
        this.qty = qty;
        this.unit_price = unit_price;
    }

    public int getInbound_line_id() {
        return inbound_line_id;
    }

    public void setInbound_line_id(int inbound_line_id) {
        this.inbound_line_id = inbound_line_id;
    }

    public int getInbound_id() {
        return inbound_id;
    }

    public void setInbound_id(int inbound_id) {
        this.inbound_id = inbound_id;
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

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

}
