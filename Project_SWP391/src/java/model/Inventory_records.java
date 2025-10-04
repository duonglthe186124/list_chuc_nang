package model;

import java.util.Date;

public class Inventory_records {

    private int inventory_id, product_id, location_id, qty;
    private Date last_update;

    public int getInventory_id() {
        return inventory_id;
    }

    public void setInventory_id(int inventory_id) {
        this.inventory_id = inventory_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public Date getLast_update() {
        return last_update;
    }

    public void setLast_update(Date last_update) {
        this.last_update = last_update;
    }

    public Inventory_records(int inventory_id, int product_id, int location_id, int qty, Date last_update) {
        this.inventory_id = inventory_id;
        this.product_id = product_id;
        this.location_id = location_id;
        this.qty = qty;
        this.last_update = last_update;
    }

    public Inventory_records() {
    }
}
