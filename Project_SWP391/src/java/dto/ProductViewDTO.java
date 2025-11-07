/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.math.BigDecimal;

/**
 *
 * @author hoang
 */
public class ProductViewDTO {
    private int productId,batteryCapacity,camera;
    private String name, skuCode, brandName, storage, memory, cpu, color, screenType, imageUrl;
    private BigDecimal screenSize, purchasePrice;

    public ProductViewDTO() {
    }

    public ProductViewDTO(int productId, int batteryCapacity, int camera, String name, String skuCode, String brandName, String storage, String memory, String cpu, String color, String screenType, String imageUrl, BigDecimal screenSize, BigDecimal purchasePrice) {
        this.productId = productId;
        this.batteryCapacity = batteryCapacity;
        this.camera = camera;
        this.name = name;
        this.skuCode = skuCode;
        this.brandName = brandName;
        this.storage = storage;
        this.memory = memory;
        this.cpu = cpu;
        this.color = color;
        this.screenType = screenType;
        this.imageUrl = imageUrl;
        this.screenSize = screenSize;
        this.purchasePrice = purchasePrice;
    }

   

    
   

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getBatteryCapacity() {
        return batteryCapacity;
    }

    public void setBatteryCapacity(int batteryCapacity) {
        this.batteryCapacity = batteryCapacity;
    }

    public int getCamera() {
        return camera;
    }

    public void setCamera(int camera) {
        this.camera = camera;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSkuCode() {
        return skuCode;
    }

    public void setSkuCode(String skuCode) {
        this.skuCode = skuCode;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public String getMemory() {
        return memory;
    }

    public void setMemory(String memory) {
        this.memory = memory;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getScreenType() {
        return screenType;
    }

    public void setScreenType(String screenType) {
        this.screenType = screenType;
    }

    public BigDecimal getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(BigDecimal screenSize) {
        this.screenSize = screenSize;
    }

    public BigDecimal getPurchasePrice() {
        return purchasePrice;
    }

    public void setPurchasePrice(BigDecimal purchasePrice) {
        this.purchasePrice = purchasePrice;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
}
