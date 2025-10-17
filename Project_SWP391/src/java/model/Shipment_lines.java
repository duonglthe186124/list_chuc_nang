package model;

public class Shipment_lines {

    private int line_id, shipment_id, product_id, qty;

    public Shipment_lines() {
    }

    public Shipment_lines(int line_id, int shipment_id, int product_id, int qty) {
        this.line_id = line_id;
        this.shipment_id = shipment_id;
        this.product_id = product_id;
        this.qty = qty;
    }

    public int getLine_id() {
        return line_id;
    }

    public void setLine_id(int line_id) {
        this.line_id = line_id;
    }

    public int getShipment_id() {
        return shipment_id;
    }

    public void setShipment_id(int shipment_id) {
        this.shipment_id = shipment_id;
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

}
