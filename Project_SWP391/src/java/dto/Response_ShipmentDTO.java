package dto;

import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */

public class Response_ShipmentDTO {

    private int shipment_id;
    private String shipment_no;
    private int order_id;
    private String customer;
    private int total_line;
    private int total_shipped;
    private float total;
    private String created_by;
    private LocalDateTime created_at;
    private String status;

    public Response_ShipmentDTO() {
    }

    public Response_ShipmentDTO(int shipment_id, String shipment_no, int order_id, String customer, int total_line, int total_shipped, float total, String created_by, LocalDateTime created_at, String status) {
        this.shipment_id = shipment_id;
        this.shipment_no = shipment_no;
        this.order_id = order_id;
        this.customer = customer;
        this.total_line = total_line;
        this.total_shipped = total_shipped;
        this.total = total;
        this.created_by = created_by;
        this.created_at = created_at;
        this.status = status;
    }

    public int getShipment_id() {
        return shipment_id;
    }

    public void setShipment_id(int shipment_id) {
        this.shipment_id = shipment_id;
    }

    public String getShipment_no() {
        return shipment_no;
    }

    public void setShipment_no(String shipment_no) {
        this.shipment_no = shipment_no;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public String getCustomer() {
        return customer;
    }

    public void setCustomer(String customer) {
        this.customer = customer;
    }

    public int getTotal_line() {
        return total_line;
    }

    public void setTotal_line(int total_line) {
        this.total_line = total_line;
    }

    public int getTotal_shipped() {
        return total_shipped;
    }

    public void setTotal_shipped(int total_shipped) {
        this.total_shipped = total_shipped;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public String getCreated_by() {
        return created_by;
    }

    public void setCreated_by(String created_by) {
        this.created_by = created_by;
    }

    public LocalDateTime getCreated_at() {
        return created_at;
    }

    public void setCreated_at(LocalDateTime created_at) {
        this.created_at = created_at;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}