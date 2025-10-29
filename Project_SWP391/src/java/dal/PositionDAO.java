package dal;

import model.Positions;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.DBContext;

public class PositionDAO extends DBContext {

    public List<Positions> getAllPositions() {
        List<Positions> list = new ArrayList<>();
        String sql = "SELECT position_id, position_name, description FROM Positions ORDER BY position_id";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Positions pos = new Positions(
                            rs.getInt("position_id"),
                            rs.getString("position_name"),
                            rs.getString("description")
                    );
                    list.add(pos);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getPositionNameById(int position_id) {
        String sql = "SELECT position_name FROM Positions WHERE position_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, position_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("position_name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

