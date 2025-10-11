/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author hoang
 */
public class ProductInfoScreen_DuongLT {

    private int productId;
    private String productName;
    private String brandName;
    private String cpu;
    private String memory;
    private String storage;
    private int camera;
    private String typeName;
    private int qty;
    private String imageUrl;
    

    public ProductInfoScreen_DuongLT() {
    }

    public ProductInfoScreen_DuongLT(int productId, String productName, String brandName, String cpu, String memory, String storage, int camera, String typeName, int qty, String imageUrl) {
        this.productId = productId;
        this.productName = productName;
        this.brandName = brandName;
        this.cpu = cpu;
        this.memory = memory;
        this.storage = storage;
        this.camera = camera;
        this.typeName = typeName;
        this.qty = qty;
        this.imageUrl = imageUrl;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getBrandName() {
        return brandName;
    }

    public void setBrandName(String brandName) {
        this.brandName = brandName;
    }

    public String getCpu() {
        return cpu;
    }

    public void setCpu(String cpu) {
        this.cpu = cpu;
    }

    public String getMemory() {
        return memory;
    }

    public void setMemory(String memory) {
        this.memory = memory;
    }

    public String getStorage() {
        return storage;
    }

    public void setStorage(String storage) {
        this.storage = storage;
    }

    public int getCamera() {
        return camera;
    }

    public void setCamera(int camera) {
        this.camera = camera;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    
}
