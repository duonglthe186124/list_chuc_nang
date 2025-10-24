package model;

import java.util.Date;

public class Employees {

    private int employee_id, user_id;
    private String employee_code;
    private Date hire_date;
    private int position_id;
    private String bank_account;
    private int boss_id;

    public Employees() {
    }

    public Employees(int employee_id, int user_id, String employee_code, Date hire_date, int position_id, String bank_account, int boss_id) {
        this.employee_id = employee_id;
        this.user_id = user_id;
        this.employee_code = employee_code;
        this.hire_date = hire_date;
        this.position_id = position_id;
        this.bank_account = bank_account;
        this.boss_id = boss_id;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public Date getHire_date() {
        return hire_date;
    }

    public void setHire_date(Date hire_date) {
        this.hire_date = hire_date;
    }

    public int getPosition_id() {
        return position_id;
    }

    public void setPosition_id(int position_id) {
        this.position_id = position_id;
    }

    public String getBank_account() {
        return bank_account;
    }

    public void setBank_account(String bank_account) {
        this.bank_account = bank_account;
    }

    public int getBoss_id() {
        return boss_id;
    }

    public void setBoss_id(int boss_id) {
        this.boss_id = boss_id;
    }

}
