package dal;

import dto.Response_SupplierDTO;
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

    public List<Response_SupplierDTO> list_supplier() {
        List<Response_SupplierDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.supplier_id, s.supplier_name FROM Suppliers s");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_SupplierDTO line = new Response_SupplierDTO(
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
