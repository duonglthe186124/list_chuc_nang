package dto;

import java.util.Date;

public class EmployeeInfoDTO {
    private int employee_id;
    private int user_id;
    private String employee_code;
    private Date hire_date;
    private String position_name;
    private String bank_account;
    private String boss_name;
    private String email;
    private String fullname;
    private String phone;
    private String address;
    private int role_id;
    private String role_name;
    private boolean is_actived;

    public EmployeeInfoDTO() {
    }

    public EmployeeInfoDTO(int employee_id, int user_id, String employee_code, Date hire_date, 
                          String position_name, String bank_account, String boss_name, 
                          String email, String fullname, String phone, String address, 
                          int role_id, String role_name, boolean is_actived) {
        this.employee_id = employee_id;
        this.user_id = user_id;
        this.employee_code = employee_code;
        this.hire_date = hire_date;
        this.position_name = position_name;
        this.bank_account = bank_account;
        this.boss_name = boss_name;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
        this.role_name = role_name;
        this.is_actived = is_actived;
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

    public String getPosition_name() {
        return position_name;
    }

    public void setPosition_name(String position_name) {
        this.position_name = position_name;
    }

    public String getBank_account() {
        return bank_account;
    }

    public void setBank_account(String bank_account) {
        this.bank_account = bank_account;
    }

    public String getBoss_name() {
        return boss_name;
    }

    public void setBoss_name(String boss_name) {
        this.boss_name = boss_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

    public boolean isIs_actived() {
        return is_actived;
    }

    public void setIs_actived(boolean is_actived) {
        this.is_actived = is_actived;
    }
}

