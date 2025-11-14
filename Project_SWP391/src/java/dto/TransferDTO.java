/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

public class TransferDTO {

    private int unitId;
    private String imei;
    private String productName;
    private int currentContainerId;
    private String currentContainerCode;
    private String currentLocationCode;

    public TransferDTO() {
    }

    public int getUnitId() {
        return unitId;
    }

    public void setUnitId(int unitId) {
        this.unitId = unitId;
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getCurrentContainerId() {
        return currentContainerId;
    }

    public void setCurrentContainerId(int currentContainerId) {
        this.currentContainerId = currentContainerId;
    }

    public String getCurrentContainerCode() {
        return currentContainerCode;
    }

    public void setCurrentContainerCode(String currentContainerCode) {
        this.currentContainerCode = currentContainerCode;
    }

    public String getCurrentLocationCode() {
        return currentLocationCode;
    }

    public void setCurrentLocationCode(String currentLocationCode) {
        this.currentLocationCode = currentLocationCode;
    }

}
