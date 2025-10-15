package dal;

import dto.ViewTransactionDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import util.*;

/**
 *
 * @author ASUS
 */
public class ViewTransactionDAO extends DBContext {

    public boolean check_exists_transaction(int tx_id) {
        int count = 0;
        boolean check = false;

        String sql = "SELECT COUNT(tx_id) AS total\n"
                + "FROM Inventory_transactions\n"
                + "WHERE tx_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, tx_id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt("total");
                if (count > 0) {
                    check = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return check;
    }

    public ViewTransactionDTO view_transaction(int tx_id) {
        ViewTransactionDTO line = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "	t.tx_id, \n"
                + "	t.tx_type, \n"
                + "	p.product_name, \n"
                + "	pu.status,\n"
                + "	p.description,\n"
                + "	t.qty,\n"
                + "	pu.unit_price,\n"
                + "	t.qty * pu.unit_price AS total_price,\n"
                + "	CASE\n"
                + "		WHEN t.tx_type = 'Inbound'  THEN s.supplier_name          -- nguồn là supplier (nếu có)\n"
                + "		WHEN t.tx_type = 'Outbound' THEN fl.code                  -- nguồn là kho (from_location)\n"
                + "		WHEN t.tx_type = 'Moving'   THEN fl.code                  -- nguồn là kho (from_location)\n"
                + "		WHEN t.tx_type = 'Destroy'  THEN fl.code                  -- nguồn là kho (from_location)\n"
                + "		ELSE fl.code\n"
                + "	END AS from_code,\n"
                + "\n"
                + "	CASE\n"
                + "		WHEN t.tx_type = 'Inbound'  THEN tl.code                  -- đích là kho (to_location)\n"
                + "		WHEN t.tx_type = 'Outbound' THEN cu.fullname               -- đích là user/khách (Outbound_inventory.user_id -> Users)\n"
                + "		WHEN t.tx_type = 'Moving'   THEN tl.code                  -- đích là kho (to_location)\n"
                + "		WHEN t.tx_type = 'Destroy'  THEN NULL                     -- tiêu huỷ không có đích\n"
                + "		ELSE tl.code\n"
                + "	END AS to_code,\n"
                + "\n"
                + "	CASE\n"
                + "		WHEN t.tx_type = 'Inbound'  THEN ib.inbound_code                 \n"
                + "		WHEN t.tx_type = 'Outbound' THEN ob.outbound_code             \n"
                + "		ELSE NULL\n"
                + "	END AS tx_code,\n"
                + "\n"
                + "	CASE\n"
                + "		WHEN t.tx_type = 'Inbound'  THEN s.supplier_name          \n"
                + "		WHEN t.tx_type = 'Outbound' THEN cu.fullname              \n"
                + "	END AS tx_name,\n"
                + "\n"
                + "	CASE\n"
                + "		WHEN t.tx_type = 'Inbound'  THEN ib.received_at          \n"
                + "		WHEN t.tx_type = 'Outbound' THEN ob.created_at           \n"
                + "	END AS date,\n"
                + "\n"
                + "  COALESCE(ib.inbound_code, ob.outbound_code, t.ref_code) AS ref_code,\n"
                + "\n"
                + "	e.employee_code,\n"
                + "	eu.fullname,\n"
                + "	t.tx_date,\n"
                + "	t.name,\n"
                + "	t.color,\n"
                + "	t.memory,\n"
                + "	t.unit,\n"
                + "	t.price\n"
                + "FROM Inventory_transactions t\n"
                + "LEFT JOIN Products p             ON t.product_id = p.product_id\n"
                + "JOIN Product_units pu            ON t.unit_id    = pu.unit_id\n"
                + "LEFT JOIN Employees e            ON t.employee_id = e.employee_id\n"
                + "LEFT JOIN Users eu               ON e.user_id = eu.user_id\n"
                + "LEFT JOIN Warehouse_locations fl ON t.from_location = fl.location_id\n"
                + "LEFT JOIN Warehouse_locations tl ON t.to_location   = tl.location_id\n"
                + "LEFT JOIN Inbound_inventory ib   ON t.related_inbound_id  = ib.inbound_id\n"
                + "LEFT JOIN Suppliers s            ON ib.supplier_id        = s.supplier_id\n"
                + "LEFT JOIN Outbound_inventory ob  ON t.related_outbound_id = ob.outbound_id\n"
                + "LEFT JOIN Users cu               ON ob.user_id            = cu.user_id\n"
                + "WHERE 1 = 1 ");

        if (check_exists_transaction(tx_id)) {
            sql.append(" AND tx_id = ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, tx_id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                line = new ViewTransactionDTO(
                        rs.getString("tx_type"),
                        rs.getDate("tx_date"),
                        rs.getString("ref_code"),
                        rs.getString("employee_code"),
                        rs.getString("fullname"),
                        rs.getString("product_name"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getInt("qty"),
                        rs.getString("from_code"),
                        rs.getString("to_code"),
                        rs.getString("tx_code"),
                        rs.getString("tx_name"),
                        rs.getDate("date"),
                        rs.getString("name"),
                        rs.getString("color"),
                        rs.getString("memory"),
                        rs.getString("unit"),
                        rs.getFloat("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }

    public static void main(String[] args) {
        ViewTransactionDAO dao = new ViewTransactionDAO();
        ViewTransactionDTO l = dao.view_transaction(1);

        if (l != null) {
            System.out.println(l.getTx_type());
        }
    }
}
