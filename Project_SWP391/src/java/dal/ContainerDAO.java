package dal;

import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ASUS
 */
public class ContainerDAO extends DBContext {

    public int create_new_container(String container_code, int location_id) {
        int container_id = -1;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Containers(container_code, location_id)"
                + "VALUES(?, ?)");
        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, container_code);
            ps.setInt(2, location_id);
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        container_id = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return container_id;
    }
}
