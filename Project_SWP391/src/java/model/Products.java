package model;

import java.util.Date;

public class Products {

    private int product;
    private String sku_code, name;
    private int brand_id, spec_id;
    private String description;
    private Date created_at, updated_at;

    public Products() {
    }

    public int getProduct() {
        return product;
    }

    public void setProduct(int product) {
        this.product = product;
    }

    public String getSku_code() {
        return sku_code;
    }

    public void setSku_code(String sku_code) {
        this.sku_code = sku_code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public Date getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(Date updated_at) {
        this.updated_at = updated_at;
    }

    public Products(int product, String sku_code, String name, int brand_id, int spec_id, String description, Date created_at, Date updated_at) {
        this.product = product;
        this.sku_code = sku_code;
        this.name = name;
        this.brand_id = brand_id;
        this.spec_id = spec_id;
        this.description = description;
        this.created_at = created_at;
        this.updated_at = updated_at;
    }

}
