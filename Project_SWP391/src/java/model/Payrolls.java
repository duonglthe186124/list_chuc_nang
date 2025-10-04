package model;

import java.util.Date;

public class Payrolls {
    private int payroll_id, employee_id;
    private Date period_start, period_end;
    private float gross_amount, net_amount;
    private Date created_at;

    public Payrolls() {
    }

    public Payrolls(int payroll_id, int employee_id, Date period_start, Date period_end, float gross_amount, float net_amount, Date created_at) {
        this.payroll_id = payroll_id;
        this.employee_id = employee_id;
        this.period_start = period_start;
        this.period_end = period_end;
        this.gross_amount = gross_amount;
        this.net_amount = net_amount;
        this.created_at = created_at;
    }

    public int getPayroll_id() {
        return payroll_id;
    }

    public void setPayroll_id(int payroll_id) {
        this.payroll_id = payroll_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public Date getPeriod_start() {
        return period_start;
    }

    public void setPeriod_start(Date period_start) {
        this.period_start = period_start;
    }

    public Date getPeriod_end() {
        return period_end;
    }

    public void setPeriod_end(Date period_end) {
        this.period_end = period_end;
    }

    public float getGross_amount() {
        return gross_amount;
    }

    public void setGross_amount(float gross_amount) {
        this.gross_amount = gross_amount;
    }

    public float getNet_amount() {
        return net_amount;
    }

    public void setNet_amount(float net_amount) {
        this.net_amount = net_amount;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }
    
}
