package model;

public class Order_details {

    private int order_no, order_id, product_id, qty;
    private float unit_price, line_amount;

    public Order_details() {
    }

    public Order_details(int order_no, int order_id, int product_id, int qty, float unit_price, float line_amount) {
        this.order_no = order_no;
        this.order_id = order_id;
        this.product_id = product_id;
        this.qty = qty;
        this.unit_price = unit_price;
        this.line_amount = line_amount;
    }

    public int getOrder_no() {
        return order_no;
    }

    public void setOrder_no(int order_no) {
        this.order_no = order_no;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
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

    public float getLine_amount() {
        return line_amount;
    }

    public void setLine_amount(float line_amount) {
        this.line_amount = line_amount;
    }

}
