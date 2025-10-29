package dto;

import java.time.LocalDateTime;

/**
 *
 * @author ASUS
 */
public class Response_OrderInfoDTO {

    private String fullname;
    private LocalDateTime order_date;
    private String status;
    private int line_count, total_qty;
    private float total_value;

    public Response_OrderInfoDTO() {
    }

    public Response_OrderInfoDTO(String fullname, LocalDateTime order_date, String status, int line_count, int total_qty, float total_value) {
        this.fullname = fullname;
        this.order_date = order_date;
        this.status = status;
        this.line_count = line_count;
        this.total_qty = total_qty;
        this.total_value = total_value;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public LocalDateTime getOrder_date() {
        return order_date;
    }

    public void setOrder_date(LocalDateTime order_date) {
        this.order_date = order_date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getLine_count() {
        return line_count;
    }

    public void setLine_count(int line_count) {
        this.line_count = line_count;
    }

    public int getTotal_qty() {
        return total_qty;
    }

    public void setTotal_qty(int total_qty) {
        this.total_qty = total_qty;
    }

    public float getTotal_value() {
        return total_value;
    }

    public void setTotal_value(float total_value) {
        this.total_value = total_value;
    }

}
