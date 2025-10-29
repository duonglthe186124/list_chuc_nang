package dto;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

public class PayrollDTO {
    private int payroll_id;
    private int employee_id;
    private String employee_code;
    private String employee_name;
    private Date period_start;
    private Date period_end;
    private BigDecimal gross_amount;
    private BigDecimal net_amount;
    private Date created_at;
    private List<SalaryComponentDTO> components;

    public PayrollDTO() {
    }

    public PayrollDTO(int payroll_id, int employee_id, String employee_code, String employee_name,
                     Date period_start, Date period_end, BigDecimal gross_amount, BigDecimal net_amount, Date created_at) {
        this.payroll_id = payroll_id;
        this.employee_id = employee_id;
        this.employee_code = employee_code;
        this.employee_name = employee_name;
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

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public String getEmployee_name() {
        return employee_name;
    }

    public void setEmployee_name(String employee_name) {
        this.employee_name = employee_name;
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

    public BigDecimal getGross_amount() {
        return gross_amount;
    }

    public void setGross_amount(BigDecimal gross_amount) {
        this.gross_amount = gross_amount;
    }

    public BigDecimal getNet_amount() {
        return net_amount;
    }

    public void setNet_amount(BigDecimal net_amount) {
        this.net_amount = net_amount;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public List<SalaryComponentDTO> getComponents() {
        return components;
    }

    public void setComponents(List<SalaryComponentDTO> components) {
        this.components = components;
    }
}

