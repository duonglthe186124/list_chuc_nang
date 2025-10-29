package dto;

public class EmployeeFormDTO {
    private int user_id;
    private String email;
    private String password;
    private String fullname;
    private String phone;
    private String address;
    private String sec_address;
    private int role_id;
    private String employee_code;
    private String hire_date;
    private int position_id;
    private String bank_account;
    private Integer boss_id;
    private boolean is_actived;

    public EmployeeFormDTO() {
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getSec_address() {
        return sec_address;
    }

    public void setSec_address(String sec_address) {
        this.sec_address = sec_address;
    }

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
    }

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public String getHire_date() {
        return hire_date;
    }

    public void setHire_date(String hire_date) {
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

    public Integer getBoss_id() {
        return boss_id;
    }

    public void setBoss_id(Integer boss_id) {
        this.boss_id = boss_id;
    }

    public boolean isIs_actived() {
        return is_actived;
    }

    public void setIs_actived(boolean is_actived) {
        this.is_actived = is_actived;
    }
}

