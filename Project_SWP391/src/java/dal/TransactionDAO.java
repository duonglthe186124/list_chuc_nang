package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.*;
import dto.TransactionDTO;

public class TransactionDAO extends DBContext {

    public List<TransactionDTO> transactions(String search_name, String tx_type, int offset, int limit) {
        List<TransactionDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "  t.tx_id,\n"
                + "  p.product_name,\n"
                + "  t.qty,\n"
                + "  pu.unit_name,\n"
                + "  t.tx_type,\n"
                + "\n"
                + "  CASE\n"
                + "    WHEN t.tx_type = 'Inbound'  THEN s.supplier_name\n"
                + "    WHEN t.tx_type = 'Outbound' THEN fl.code\n"
                + "    WHEN t.tx_type = 'Moving'   THEN fl.code\n"
                + "    WHEN t.tx_type = 'Destroy'  THEN fl.code\n"
                + "    ELSE fl.code\n"
                + "  END AS from_code,\n"
                + "\n"
                + "  CASE\n"
                + "    WHEN t.tx_type = 'Inbound'  THEN tl.code\n"
                + "    WHEN t.tx_type = 'Outbound' THEN u.fullname\n"
                + "    WHEN t.tx_type = 'Moving'   THEN tl.code\n"
                + "    WHEN t.tx_type = 'Destroy'  THEN NULL\n"
                + "    ELSE tl.code\n"
                + "  END AS to_code,\n"
                + "\n"
                + "  e.employee_code,\n"
                + "  t.tx_date\n"
                + "\n")
                .append("FROM Inventory_transactions t\n"
                        + "  JOIN Products p        ON t.product_id = p.product_id\n"
                        + "  JOIN Product_units pu  ON t.unit_id    = pu.unit_id\n"
                        + "  LEFT JOIN Warehouse_locations fl ON t.from_location = fl.location_id\n"
                        + "  LEFT JOIN Warehouse_locations tl ON t.to_location   = tl.location_id\n"
                        + "  LEFT JOIN Employees e           ON t.employee_id   = e.employee_id\n"
                        + "  LEFT JOIN Inbound_inventory ib ON t.related_inbound_id  = ib.inbound_id\n"
                        + "  LEFT JOIN Suppliers s          ON ib.supplier_id        = s.supplier_id\n"
                        + "  LEFT JOIN Outbound_inventory ob ON t.related_outbound_id = ob.outbound_id\n"
                        + "  LEFT JOIN Users u               ON ob.user_id            = u.user_id\n")
                .append("WHERE 1 = 1 ");

        List<Object> params = new ArrayList();

        if (search_name != null) {
            sql.append("AND p.product_name LIKE ? ");
            params.add(search_name);
        }
        if (tx_type != null) {
            sql.append("AND t.tx_type = ? ");
            params.add(tx_type);
        }
        sql.append("ORDER BY t.tx_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TransactionDTO line = new TransactionDTO(
                        rs.getInt("tx_id"),
                        rs.getString("product_name"),
                        rs.getInt("qty"),
                        rs.getString("unit_name"),
                        rs.getString("tx_type"),
                        rs.getString("from_code"),
                        rs.getString("to_code"),
                        rs.getString("employee_code"),
                        rs.getDate("tx_date"));
                list.add(line);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int total_lines(String search_name, String tx_type) {
        int total_pages = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "COUNT(t.tx_id) AS total_pages\n"
                + "	FROM Inventory_transactions t\n"
                + "  JOIN Products p        ON t.product_id = p.product_id\n"
                + "  JOIN Product_units pu  ON t.unit_id    = pu.unit_id\n"
                + "  LEFT JOIN Warehouse_locations fl ON t.from_location = fl.location_id\n"
                + "  LEFT JOIN Warehouse_locations tl ON t.to_location   = tl.location_id\n"
                + "  LEFT JOIN Employees e           ON t.employee_id   = e.employee_id\n"
                + "\n"
                + "  LEFT JOIN Inbound_inventory ib ON t.related_inbound_id  = ib.inbound_id\n"
                + "  LEFT JOIN Suppliers s          ON ib.supplier_id        = s.supplier_id\n"
                + "\n"
                + "  LEFT JOIN Outbound_inventory ob ON t.related_outbound_id = ob.outbound_id\n"
                + "  LEFT JOIN Users u               ON ob.user_id            = u.user_id\n"
                + "\n"
                + "WHERE 1 = 1");

        List<Object> params = new ArrayList();

        if (search_name != null) {
            sql.append("AND p.product_name LIKE ? ");
            params.add(search_name);
        }
        if (tx_type != null) {
            sql.append("AND t.tx_type = ? ");
            params.add(tx_type);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                total_pages = rs.getInt("total_pages");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total_pages;
    }

    public static void main(String[] args) {
        TransactionDAO dao = new TransactionDAO();
        List<TransactionDTO> list = dao.transactions(null, null, 0, 10);
        int total = dao.total_lines(null, null);
        if (!list.isEmpty()) {
            System.out.println(total);
        }
    }
}
