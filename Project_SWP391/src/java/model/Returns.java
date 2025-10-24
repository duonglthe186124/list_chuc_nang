package model;

import java.util.Date;

public class Returns {

    private int return_id;
    private String return_no;
    private int order_id, created_by;
    private Date created_at;
    private String status;

    public Returns() {
    }

    public Returns(int return_id, String return_no, int order_id, int created_by, Date created_at, String status) {
        this.return_id = return_id;
        this.return_no = return_no;
        this.order_id = order_id;
        this.created_by = created_by;
        this.created_at = created_at;
        this.status = status;
    }

    public int getReturn_id() {
        return return_id;
    }

    public void setReturn_id(int return_id) {
        this.return_id = return_id;
    }

    public String getReturn_no() {
        return return_no;
    }

    public void setReturn_no(String return_no) {
        this.return_no = return_no;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
