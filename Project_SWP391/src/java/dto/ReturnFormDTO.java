/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author Ha Trung KI
 */
public class ReturnFormDTO {

    // 1. IMEI (để tìm kiếm)
    private String imei;
    private int unitId; // ID của IMEI

    // 2. Mã sản phẩm (SKU)
    private String skuCode;

    // 3. Tên sản phẩm
    private String productName;

    // 4. Tình trạng sản phẩm (hiện tại)
    private String currentStatus; // Sẽ là "SOLD"

    // 5. Đơn hàng gốc (ID)
    private int orderId;
    
    // 6. Tên Khách hàng
    private String customerName;

    // 7. SĐT Khách hàng
    private String customerPhone;

    // 8. Tên Nhà cung cấp (để đổi trả)
    private String supplierName;

    // 9. SĐT Nhà cung cấp
    private String supplierPhone;
    
    // 10. Email Nhà cung cấp
    private String supplierEmail;
    
    // (Các trường 8, 9, 10 là thông tin Nhà cung cấp)

    public ReturnFormDTO() {}

    // Getters and Setters
    public String getImei() { return imei; }
    public void setImei(String imei) { this.imei = imei; }
    public int getUnitId() { return unitId; }
    public void setUnitId(int unitId) { this.unitId = unitId; }
    public String getSkuCode() { return skuCode; }
    public void setSkuCode(String skuCode) { this.skuCode = skuCode; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getCurrentStatus() { return currentStatus; }
    public void setCurrentStatus(String currentStatus) { this.currentStatus = currentStatus; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getCustomerPhone() { return customerPhone; }
    public void setCustomerPhone(String customerPhone) { this.customerPhone = customerPhone; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
    public String getSupplierPhone() { return supplierPhone; }
    public void setSupplierPhone(String supplierPhone) { this.supplierPhone = supplierPhone; }
    public String getSupplierEmail() { return supplierEmail; }
    public void setSupplierEmail(String supplierEmail) { this.supplierEmail = supplierEmail; }
}