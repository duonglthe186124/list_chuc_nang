package dal;

import dto.Request_POLineDTO;
import dto.Request_PurchaseOrderDTO;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

/**
 * @author ASUS
 */
public class PurchaseOrderDAO extends DBContext {

    public int add_purchase_order(Request_PurchaseOrderDTO object) {
        int po_id = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Purchase_orders (po_code, supplier_id, created_by, total_amount, note)\n"
                + "VALUES(?, ?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
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
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework
        }
        return po_id;
    }

    public void add_po_line(List<Request_POLineDTO> list) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty)\n"
                + "VALUES(?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (Request_POLineDTO line : list) {
                ps.setInt(1, line.getPo_id());
                ps.setInt(2, line.getProduct_id());
                ps.setFloat(3, line.getUnit_price());
                ps.setFloat(4, line.getQty());

                ps.addBatch();
            }
            ps.executeBatch();
            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
