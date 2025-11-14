/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.math.BigDecimal;
import java.util.Date;

public class InventoryDetailDTO {

    private int unitId; // ID của Product_unit
    
    // Từ Product_units
    private String imei;
    private String status; // Tình trạng sản phẩm
    private BigDecimal purchasePrice; // Giá nhập
    private Date receiptDate; // Ngày nhập

    // Từ Products
    private String productName;

    // Từ Warehouse_locations
    private String locationCode; // Vị trí kho

    // Từ Suppliers
    private String supplierName; // Nhà cung cấp

    // Từ Quality_Inspections (lần kiểm kê cuối)
    private Date lastInspectionDate; // Ngày kiểm kê
    private String inspectorName; // Nhân viên kiểm kê

    // Từ Shipments (nếu đã bán)
    private Date issueDate; // Ngày xuất

    public InventoryDetailDTO() {}

    // Getters and Setters
    public int getUnitId() { return unitId; }
    public void setUnitId(int unitId) { this.unitId = unitId; }
    public String getImei() { return imei; }
    public void setImei(String imei) { this.imei = imei; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public BigDecimal getPurchasePrice() { return purchasePrice; }
    public void setPurchasePrice(BigDecimal purchasePrice) { this.purchasePrice = purchasePrice; }
    public Date getReceiptDate() { return receiptDate; }
    public void setReceiptDate(Date receiptDate) { this.receiptDate = receiptDate; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getLocationCode() { return locationCode; }
    public void setLocationCode(String locationCode) { this.locationCode = locationCode; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public Date getLastInspectionDate() { return lastInspectionDate; }
    public void setLastInspectionDate(Date lastInspectionDate) { this.lastInspectionDate = lastInspectionDate; }
    public String getInspectorName() { return inspectorName; }
    public void setInspectorName(String inspectorName) { this.inspectorName = inspectorName; }
    public Date getIssueDate() { return issueDate; }
    public void setIssueDate(Date issueDate) { this.issueDate = issueDate; }
}