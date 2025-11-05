package model;

import java.sql.Timestamp;

public class Users {

    private int user_id;
    private String email, password, fullname, phone, address, sec_address;
    private int role_id;
    private boolean is_actived, is_deleted;
    private String avatar_url;
    private String reset_token;
    private Timestamp token_expiry;
    private String roleName;
    public Users() {
    }

    public Users(int user_id, String email, String password, String fullname, String phone, String address, String sec_address, int role_id, boolean is_actived, boolean is_deleted) {
        this.user_id = user_id;
        this.email = email;
        this.password = password;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
        this.sec_address = sec_address;
        this.role_id = role_id;
        this.is_actived = is_actived;
        this.is_deleted = is_deleted;
        this.avatar_url = avatar_url;
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

    public boolean isIs_actived() {
        return is_actived;
    }

    public void setIs_actived(boolean is_actived) {
        this.is_actived = is_actived;
    }

    public boolean isIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(boolean is_deleted) {
        this.is_deleted = is_deleted;
    }

    public String getAvatar_url() {
        return avatar_url;
    }

    public void setAvatar_url(String avatar_url) {
        this.avatar_url = avatar_url;
    }

    public String getReset_token() {
        return reset_token;
    }

    public void setReset_token(String reset_token) {
        this.reset_token = reset_token;
    }

    public Timestamp getToken_expiry() {
        return token_expiry;
    }

    public void setToken_expiry(Timestamp token_expiry) {
        this.token_expiry = token_expiry;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

}
