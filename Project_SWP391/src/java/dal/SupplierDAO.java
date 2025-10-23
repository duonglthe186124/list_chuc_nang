package dal;

import dto.SupplierResponseDTO;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class SupplierDAO extends DBContext {

    public List<SupplierResponseDTO> list_supplier() {
        List<SupplierResponseDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.supplier_id, s.supplier_name FROM Suppliers s");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SupplierResponseDTO line = new SupplierResponseDTO(
                            rs.getInt("supplier_id"),
                            rs.getString("supplier_name"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
