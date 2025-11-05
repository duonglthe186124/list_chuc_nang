/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ShipEmployeesDTO;
import dto.StatusDTO;
import dto.UnitViewDTO;
import dto.UserToCheckTask;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hoang
 */
public class TestShipE {

    public static void main(String[] args) {
         try {
        getRoleBySetIdDAO dao = new getRoleBySetIdDAO();
        List<UserToCheckTask> list = dao.getAllUsersWithRoles();
             for (UserToCheckTask u: list) {
                 System.out.println(u.getUserId()+" "+u.getFullname()+" "+u.getRoleId()+" "+u.getRolename());
             }

       
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
}
