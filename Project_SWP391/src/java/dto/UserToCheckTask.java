/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author hoang
 */
public class UserToCheckTask {
    private int userId;
    private int roleId;
    private String fullname, rolename; 

    public UserToCheckTask() {
    }

    public UserToCheckTask(int userId, int roleId, String fullname, String rolename) {
        this.userId = userId;
        this.roleId = roleId;
        this.fullname = fullname;
        this.rolename = rolename;
    }

    
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }
    
    

    
}
