package dal;

import model.Roles;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBContext;

public class RoleDAO extends DBContext {

    public List<Roles> getAllRoles() {
        List<Roles> list = new ArrayList<>();
        String sql = "SELECT role_id, role_name, description FROM Roles ORDER BY role_id";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Roles role = new Roles(
                            rs.getInt("role_id"),
                            rs.getString("role_name"),
                            rs.getString("description")
                    );
                    list.add(role);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getRoleNameById(int role_id) {
        String sql = "SELECT role_name FROM Roles WHERE role_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, role_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("role_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

