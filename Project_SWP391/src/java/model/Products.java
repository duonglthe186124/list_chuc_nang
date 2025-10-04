package model;

import java.util.Date;

public class Products {

    private int product_id;
    private String product_name;
    private int brand_id, spec_id, type_id;
    private String description;
    private Date created_at;

    public Products() {
    }

    public Products(int product_id, String product_name, int brand_id, int spec_id, int type_id, String description, Date created_at) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.brand_id = brand_id;
        this.spec_id = spec_id;
        this.type_id = type_id;
        this.description = description;
        this.created_at = created_at;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getBrand_id() {
        return brand_id;
    }

    public void setBrand_id(int brand_id) {
        this.brand_id = brand_id;
    }

    public int getSpec_id() {
        return spec_id;
    }

    public void setSpec_id(int spec_id) {
        this.spec_id = spec_id;
    }

    public int getType_id() {
        return type_id;
    }

    public void setType_id(int type_id) {
        this.type_id = type_id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

}
