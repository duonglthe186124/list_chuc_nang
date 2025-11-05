/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class UnitViewDTO {
    private int unitId;
    private String imei, serialNumber, status;
    private Timestamp warrantyStart, warrantyEnd;

    public UnitViewDTO() {
    }

    public UnitViewDTO(int unitId, String imei, String serialNumber, String status, Timestamp warrantyStart, Timestamp warrantyEnd) {
        this.unitId = unitId;
        this.imei = imei;
        this.serialNumber = serialNumber;
        this.status = status;
        this.warrantyStart = warrantyStart;
        this.warrantyEnd = warrantyEnd;
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

    public String getSerialNumber() {
        return serialNumber;
    }

    public void setSerialNumber(String serialNumber) {
        this.serialNumber = serialNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getWarrantyStart() {
        return warrantyStart;
    }

    public void setWarrantyStart(Timestamp warrantyStart) {
        this.warrantyStart = warrantyStart;
    }

    public Timestamp getWarrantyEnd() {
        return warrantyEnd;
    }

    public void setWarrantyEnd(Timestamp warrantyEnd) {
        this.warrantyEnd = warrantyEnd;
    }
    
    
    
}
