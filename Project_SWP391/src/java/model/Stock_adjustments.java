package model;

import java.util.Date;

public class Stock_adjustments {

    private int adjustments_id;
    private String adjustment_no;
    private int product_id, unit_id, qty_before, qty_after, delta;
    private String reason;
    private int created_by;
    private Date created_at;

    public Stock_adjustments() {
    }

    public Stock_adjustments(int adjustments_id, String adjustment_no, int product_id, int unit_id, int qty_before, int qty_after, int delta, String reason, int created_by, Date created_at) {
        this.adjustments_id = adjustments_id;
        this.adjustment_no = adjustment_no;
        this.product_id = product_id;
        this.unit_id = unit_id;
        this.qty_before = qty_before;
        this.qty_after = qty_after;
        this.delta = delta;
        this.reason = reason;
        this.created_by = created_by;
        this.created_at = created_at;
    }

    public int getAdjustments_id() {
        return adjustments_id;
    }

    public void setAdjustments_id(int adjustments_id) {
        this.adjustments_id = adjustments_id;
    }

    public String getAdjustment_no() {
        return adjustment_no;
    }

    public void setAdjustment_no(String adjustment_no) {
        this.adjustment_no = adjustment_no;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public int getQty_before() {
        return qty_before;
    }

    public void setQty_before(int qty_before) {
        this.qty_before = qty_before;
    }

    public int getQty_after() {
        return qty_after;
    }

    public void setQty_after(int qty_after) {
        this.qty_after = qty_after;
    }

    public int getDelta() {
        return delta;
    }

    public void setDelta(int delta) {
        this.delta = delta;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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

}
