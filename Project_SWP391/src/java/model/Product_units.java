package model;

import java.util.Date;

public class Product_units {

    private int unit_id;
    private String imei, serial_number;
    private Date warranty_start, warranty_end;
    private int product_id;
    private float purchase_price;
    private Date receive_date;
    private int container_id;
    private String status;
    private Date created_at, updated_at;

    public Product_units() {
    }

    public Product_units(int unit_id, String imei, String serial_number, Date warranty_start, Date warranty_end, int product_id, float purchase_price, Date receive_date, int container_id, String status, Date created_at, Date updated_at) {
        this.unit_id = unit_id;
        this.imei = imei;
        this.serial_number = serial_number;
        this.warranty_start = warranty_start;
        this.warranty_end = warranty_end;
        this.product_id = product_id;
        this.purchase_price = purchase_price;
        this.receive_date = receive_date;
        this.container_id = container_id;
        this.status = status;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }

    public String getSerial_number() {
        return serial_number;
    }

    public void setSerial_number(String serial_number) {
        this.serial_number = serial_number;
    }

    public Date getWarranty_start() {
        return warranty_start;
    }

    public void setWarranty_start(Date warranty_start) {
        this.warranty_start = warranty_start;
    }

    public Date getWarranty_end() {
        return warranty_end;
    }

    public void setWarranty_end(Date warranty_end) {
        this.warranty_end = warranty_end;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public float getPurchase_price() {
        return purchase_price;
    }

    public void setPurchase_price(float purchase_price) {
        this.purchase_price = purchase_price;
    }

    public Date getReceive_date() {
        return receive_date;
    }

    public void setReceive_date(Date receive_date) {
        this.receive_date = receive_date;
    }

    public int getContainer_id() {
        return container_id;
    }

    public void setContainer_id(int container_id) {
        this.container_id = container_id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

}
