/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;

public class InspectionViewDTO {

    private String inspection_no;
    private Date inspected_date;
    private String result;
    private String note;
    
    // Dữ liệu JOIN
    private String imei; // Từ Product_units
    private String productName; // Từ Products
    private String inspectorName; // Từ Users
    private String locationCode; // Từ Warehouse_locations

    public InspectionViewDTO() {
    }

    // Getters and Setters
    public String getInspection_no() { return inspection_no; }
    public void setInspection_no(String inspection_no) { this.inspection_no = inspection_no; }
    public Date getInspected_date() { return inspected_date; }
    public void setInspected_date(Date inspected_date) { this.inspected_date = inspected_date; }
    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    public String getImei() { return imei; }
    public void setImei(String imei) { this.imei = imei; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getInspectorName() { return inspectorName; }
    public void setInspectorName(String inspectorName) { this.inspectorName = inspectorName; }
    public String getLocationCode() { return locationCode; }
    public void setLocationCode(String locationCode) { this.locationCode = locationCode; }
}