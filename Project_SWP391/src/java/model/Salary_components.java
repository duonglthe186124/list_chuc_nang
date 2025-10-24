package model;

public class Salary_components {

    private int comp_id, payroll_id;
    private String comp_type;
    private float amount;

    public Salary_components() {
    }

    public Salary_components(int comp_id, int payroll_id, String comp_type, float amount) {
        this.comp_id = comp_id;
        this.payroll_id = payroll_id;
        this.comp_type = comp_type;
        this.amount = amount;
    }

    public int getComp_id() {
        return comp_id;
    }

    public void setComp_id(int comp_id) {
        this.comp_id = comp_id;
    }

    public int getPayroll_id() {
        return payroll_id;
    }

    public void setPayroll_id(int payroll_id) {
        this.payroll_id = payroll_id;
    }

    public String getComp_type() {
        return comp_type;
    }

    public void setComp_type(String comp_type) {
        this.comp_type = comp_type;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

}
