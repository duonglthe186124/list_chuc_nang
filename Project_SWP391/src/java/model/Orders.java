package model;

import java.util.Date;

public class Orders {

    private int order_id, user_id;
    private float total_amount;
    private String status;
    private Date order_date;

    public Orders() {
    }

    public Orders(int order_id, int user_id, float total_amount, String status, Date order_date) {
        this.order_id = order_id;
        this.user_id = user_id;
        this.total_amount = total_amount;
        this.status = status;
        this.order_date = order_date;
    }

    public int getOrder_id() {
        return order_id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public float getTotal_amount() {
        return total_amount;
    }

    public void setTotal_amount(float total_amount) {
        this.total_amount = total_amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getOrder_date() {
        return order_date;
    }

    public void setOrder_date(Date order_date) {
        this.order_date = order_date;
    }

}
