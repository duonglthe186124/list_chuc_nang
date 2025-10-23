/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

public class InventoryDTO {
    private int product_id;
    private String product_name;
    private String brand_name;
    private int total_units;
    private int available_units;
    private int damaged_units;

    public int getProduct_id() { return product_id; }
    public void setProduct_id(int product_id) { this.product_id = product_id; }

    public String getProduct_name() { return product_name; }
    public void setProduct_name(String product_name) { this.product_name = product_name; }

    public String getBrand_name() { return brand_name; }
    public void setBrand_name(String brand_name) { this.brand_name = brand_name; }

    public int getTotal_units() { return total_units; }
    public void setTotal_units(int total_units) { this.total_units = total_units; }

    public int getAvailable_units() { return available_units; }
    public void setAvailable_units(int available_units) { this.available_units = available_units; }

    public int getDamaged_units() { return damaged_units; }
    public void setDamaged_units(int damaged_units) { this.damaged_units = damaged_units; }
}
