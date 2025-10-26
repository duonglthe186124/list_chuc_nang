package dto;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author hoang
 */
public class OrderList {
    private Integer orderNumber, orderQuantity, shipMentId, shippedQuantity;
    private String productName, cusName, cusEmail, cusPhone, cusAddress;
    private String orderStatus, shipmentStatus, shipmentNote;
    private String shipperName, shipperEmail, shipperPhone;
    private BigDecimal productUnitPrice, orderAmount;
    private Timestamp orderDate, shipmentDate;

    public OrderList() {
    }

    public OrderList(Integer orderNumber, Integer orderQuantity, Integer shipMentId, Integer shippedQuantity, String productName, String cusName, String cusEmail, String cusPhone, String cusAddress, String orderStatus, String shipmentStatus, String shipmentNote, String shipperName, String shipperEmail, String shipperPhone, BigDecimal productUnitPrice, BigDecimal orderAmount, Timestamp orderDate, Timestamp shipmentDate) {
        this.orderNumber = orderNumber;
        this.orderQuantity = orderQuantity;
        this.shipMentId = shipMentId;
        this.shippedQuantity = shippedQuantity;
        this.productName = productName;
        this.cusName = cusName;
        this.cusEmail = cusEmail;
        this.cusPhone = cusPhone;
        this.cusAddress = cusAddress;
        this.orderStatus = orderStatus;
        this.shipmentStatus = shipmentStatus;
        this.shipmentNote = shipmentNote;
        this.shipperName = shipperName;
        this.shipperEmail = shipperEmail;
        this.shipperPhone = shipperPhone;
        this.productUnitPrice = productUnitPrice;
        this.orderAmount = orderAmount;
        this.orderDate = orderDate;
        this.shipmentDate = shipmentDate;
    }

    public Integer getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(Integer orderNumber) {
        this.orderNumber = orderNumber;
    }

    public Integer getOrderQuantity() {
        return orderQuantity;
    }

    public void setOrderQuantity(Integer orderQuantity) {
        this.orderQuantity = orderQuantity;
    }

    public Integer getShipMentId() {
        return shipMentId;
    }

    public void setShipMentId(Integer shipMentId) {
        this.shipMentId = shipMentId;
    }

    public Integer getShippedQuantity() {
        return shippedQuantity;
    }

    public void setShippedQuantity(Integer shippedQuantity) {
        this.shippedQuantity = shippedQuantity;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getCusEmail() {
        return cusEmail;
    }

    public void setCusEmail(String cusEmail) {
        this.cusEmail = cusEmail;
    }

    public String getCusPhone() {
        return cusPhone;
    }

    public void setCusPhone(String cusPhone) {
        this.cusPhone = cusPhone;
    }

    public String getCusAddress() {
        return cusAddress;
    }

    public void setCusAddress(String cusAddress) {
        this.cusAddress = cusAddress;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getShipmentStatus() {
        return shipmentStatus;
    }

    public void setShipmentStatus(String shipmentStatus) {
        this.shipmentStatus = shipmentStatus;
    }

    public String getShipmentNote() {
        return shipmentNote;
    }

    public void setShipmentNote(String shipmentNote) {
        this.shipmentNote = shipmentNote;
    }

    public String getShipperName() {
        return shipperName;
    }

    public void setShipperName(String shipperName) {
        this.shipperName = shipperName;
    }

    public String getShipperEmail() {
        return shipperEmail;
    }

    public void setShipperEmail(String shipperEmail) {
        this.shipperEmail = shipperEmail;
    }

    public String getShipperPhone() {
        return shipperPhone;
    }

    public void setShipperPhone(String shipperPhone) {
        this.shipperPhone = shipperPhone;
    }

    public BigDecimal getProductUnitPrice() {
        return productUnitPrice;
    }

    public void setProductUnitPrice(BigDecimal productUnitPrice) {
        this.productUnitPrice = productUnitPrice;
    }

    public BigDecimal getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(BigDecimal orderAmount) {
        this.orderAmount = orderAmount;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public Timestamp getShipmentDate() {
        return shipmentDate;
    }

    public void setShipmentDate(Timestamp shipmentDate) {
        this.shipmentDate = shipmentDate;
    }
}