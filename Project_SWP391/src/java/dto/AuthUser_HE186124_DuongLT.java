/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.ArrayList;

/**
 *
 * @author hoang
 */
public class AuthUser_HE186124_DuongLT {

    private int userId;
    private String fullname;
    private String email;
    private int roleId;
    private String roleName;
    private String description_role;

    public AuthUser_HE186124_DuongLT(int userId, String fullname, String email, int roleId, String roleName, String description_role) {
        this.userId = userId;
        this.fullname = fullname;
        this.email = email;
        this.roleId = roleId;
        this.roleName = roleName;
        this.description_role = description_role;
    }

    public AuthUser_HE186124_DuongLT() {
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getDescription_role() {
        return description_role;
    }

    public void setDescription_role(String description_role) {
        this.description_role = description_role;
    }

   
    
    

}
