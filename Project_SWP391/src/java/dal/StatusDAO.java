/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
// dal/StatusDAO.java
package dal;

import dto.StatusDTO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

public class StatusDAO extends DBContext {

    public List<StatusDTO> getAllOrderStatuses() throws SQLException {
        List<StatusDTO> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT [status] FROM Orders";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StatusDTO s = new StatusDTO();
                s.setStatusCode(rs.getString("status"));
                statuses.add(s);
            }
        }
        return statuses;
    }
}
