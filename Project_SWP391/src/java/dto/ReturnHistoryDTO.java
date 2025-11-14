/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author Ha Trung KI
 */
import java.util.Date;

public class ReturnHistoryDTO {

    // 1. Mã phiếu trả
    private String returnNo;
    
    // 2. Ngày trả
    private Date returnDate;
    
    // 3. IMEI
    private String imei;
    
    // 4. Tên sản phẩm
    private String productName;
    
    // 5. Tên khách hàng
    private String customerName;
    
    // 6. Trạng thái (OPEN, INSPECTED, ...)
    private String status;

    public ReturnHistoryDTO() {}

    // Getters and Setters
    public String getReturnNo() { return returnNo; }
    public void setReturnNo(String returnNo) { this.returnNo = returnNo; }
    public Date getReturnDate() { return returnDate; }
    public void setReturnDate(Date returnDate) { this.returnDate = returnDate; }
    public String getImei() { return imei; }
    public void setImei(String imei) { this.imei = imei; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}