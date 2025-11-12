/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.ShipEmployeesDTO;
import java.util.ArrayList;
import util.DBContext;
import java.sql.*;

/**
 *
 * @author hoang
 */
public class ShipEmployeesDAO extends DBContext{
    public ArrayList<ShipEmployeesDTO> getShipEmployees() throws SQLException{
        ArrayList<ShipEmployeesDTO> list = new ArrayList<>();
        
        String sql = """
                     SELECT e.employee_id, e.employee_code, 
                            u.fullname, u.email, u.phone
                     FROM Employees e
                     JOIN Users u ON e.user_id = u.user_id
                     WHERE e.position_id = 9;
                     """;
        
        try(PreparedStatement stm = connection.prepareStatement(sql);
                ResultSet rs = stm.executeQuery()){
            
            while (rs.next()) {                
                int eId = rs.getInt("employee_id");
                String eCode = rs.getString("employee_code");
                String eName = rs.getString("fullname");
                String eEmail = rs.getString("email");
                String ePhone = rs.getString("phone");
                
                ShipEmployeesDTO emp = new ShipEmployeesDTO(eCode, eName, eEmail, ePhone, eId);
                list.add(emp);
            }
        }
        return list;
    }
}
