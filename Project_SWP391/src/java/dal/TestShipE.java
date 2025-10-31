/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ShipEmployeesDTO;
import java.util.ArrayList;

/**
 *
 * @author hoang
 */
public class TestShipE {
    public static void main(String[] args) {
        try {
        ShipEmployeesDAO dao = new ShipEmployeesDAO();
        ArrayList<ShipEmployeesDTO> list = dao.getShipEmployees();
        for (ShipEmployeesDTO s : list) {
            System.out.println(s.geteId() + " | " + s.geteCode() + " | " + s.geteName());
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    }
}
