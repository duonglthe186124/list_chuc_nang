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
public class SpecsOptions {

    private String brandName;
    private String cpu;
    private String memory;
    private String storage;
    private String color;
    private int battery;
    private BigDecimal screenSize;
    private String screenType;
    private int camera;

    private BigDecimal minPrice;
    private BigDecimal maxPrice;

    public SpecsOptions(String brandName, String cpu, String memory, String storage, String color, int battery, BigDecimal screenSize, String screenType, int camera, BigDecimal minPrice, BigDecimal maxPrice) {
        this.brandName = brandName;
        this.cpu = cpu;
        this.memory = memory;
        this.storage = storage;
        this.color = color;
        this.battery = battery;
        this.screenSize = screenSize;
        this.screenType = screenType;
        this.camera = camera;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
    }

    public SpecsOptions() {
        
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

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getBattery() {
        return battery;
    }

    public void setBattery(int battery) {
        this.battery = battery;
    }

    public BigDecimal getScreenSize() {
        return screenSize;
    }

    public void setScreenSize(BigDecimal screenSize) {
        this.screenSize = screenSize;
    }

    public String getScreenType() {
        return screenType;
    }

    public void setScreenType(String screenType) {
        this.screenType = screenType;
    }

    public int getCamera() {
        return camera;
    }

    public void setCamera(int camera) {
        this.camera = camera;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }

    public BigDecimal getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
    }
    
}
