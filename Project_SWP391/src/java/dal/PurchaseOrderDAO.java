package dal;

import dto.PurchaseOrderRequestDTO;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class PurchaseOrderDAO extends DBContext {

    public int add_purchase_order(PurchaseOrderRequestDTO object) {
        int po_id = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Purchase_orders (po_code, supplier_id, created_by, total_amount, note)\n"
                + "VALUES(?, ?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setString(1, object.getPo_code());
            ps.setInt(2, object.getSupplier_id());
            ps.setInt(3, object.getCreated_by());
            ps.setFloat(4, object.getTotal_amount());
            ps.setString(5, object.getNote());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        po_id = rs.getInt(1);
                        
                    }
                }
            }
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return po_id;
    }
}
