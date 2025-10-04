package model;

import java.util.Date;

public class Product_units {

    private int unit_id, product_id;
    private String unit_name;
    private int qty;
    private float unit_price;
    private String status;
    private Date warranty_end_date, created_at;

    public int getUnit_id() {
        return unit_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public String getUnit_name() {
        return unit_name;
    }

    public int getQty() {
        return qty;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public String getStatus() {
        return status;
    }

    public Date getWarranty_end_date() {
        return warranty_end_date;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public Product_units(int unit_id, int product_id, String unit_name, int qty, float unit_price, String status, Date warranty_end_date, Date created_at) {
        this.unit_id = unit_id;
        this.product_id = product_id;
        this.unit_name = unit_name;
        this.qty = qty;
        this.unit_price = unit_price;
        this.status = status;
        this.warranty_end_date = warranty_end_date;
        this.created_at = created_at;
    }

    public Product_units() {
    }
}
