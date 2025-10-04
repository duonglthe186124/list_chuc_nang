package model;

public class Outbound_lines {

    private int outbound_line_id, outbound_id, product_id, unit_id, qty;
    private float unit_price;

    public Outbound_lines() {
    }

    public Outbound_lines(int outbound_line_id, int outbound_id, int product_id, int unit_id, int qty, float unit_price) {
        this.outbound_line_id = outbound_line_id;
        this.outbound_id = outbound_id;
        this.product_id = product_id;
        this.unit_id = unit_id;
        this.qty = qty;
        this.unit_price = unit_price;
    }

    public int getOutbound_line_id() {
        return outbound_line_id;
    }

    public void setOutbound_line_id(int outbound_line_id) {
        this.outbound_line_id = outbound_line_id;
    }

    public int getOutbound_id() {
        return outbound_id;
    }

    public void setOutbound_id(int outbound_id) {
        this.outbound_id = outbound_id;
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
