package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;
import dto.Response_TransactionDTO;

public class TransactionDAO extends DBContext {

    public List<Response_TransactionDTO> transactions(String search_name, String status, int offset, int limit) {
        List<Response_TransactionDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "	r.receipts_id,\n"
                + "	r.receipts_no,\n"
                + "	r.status,\n"
                + "	r.received_at,\n"
                + "	er.employee_code AS received_by,\n"
                + "	s.display_name AS supplier,\n"
                + "	COUNT(rl.receipt_id) AS total_line,\n"
                + "	SUM(rl.qty_expected) AS total_expected,\n"
                + "	SUM(rl.qty_received) AS total_received,\n"
                + "	SUM(rl.qty_received * rl.unit_price) AS total\n"
                + "FROM Receipts r\n"
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Employees er ON r.received_by = er.employee_id\n"
                + "LEFT JOIN Users ur ON er.user_id = ur.user_id\n"
                + "LEFT JOIN Receipt_lines rl ON r.receipts_id = rl.receipt_id\n"
                + "LEFT JOIN Products p ON rl.product_id = p.product_id\n"
                + "WHERE 1 = 1 ");

        List<Object> params = new ArrayList();

        if (search_name != null) {
            sql.append("AND s.display_name LIKE ? ");
            params.add(search_name);
        }
        if (status != null) {
            sql.append("AND r.status = ? ");
            params.add(status);
        }

        sql.append("\nGROUP BY\n"
                + "	r.receipts_id,\n"
                + "	r.receipts_no,\n"
                + "	r.status,\n"
                + "	r.received_at,\n"
                + "	er.employee_code,\n"
                + "	s.display_name\n")
                .append("ORDER BY r.received_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Response_TransactionDTO line = new Response_TransactionDTO(
                        rs.getInt("receipts_id"),
                        rs.getString("receipts_no"),
                        rs.getString("status"),
                        rs.getDate("received_at"),
                        rs.getString("received_by"),
                        rs.getString("supplier"),
                        rs.getInt("total_line"),
                        rs.getInt("total_expected"),
                        rs.getInt("total_received"),
                        rs.getFloat("total")
                );
                list.add(line);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int total_lines(String search_name, String tx_type) {
        int total_fields = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "	COUNT(DISTINCT r.receipts_id) AS total_fields\n"
                + "FROM Receipts r\n"
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Employees er ON r.received_by = er.employee_id\n"
                + "LEFT JOIN Users ur ON er.user_id = ur.user_id\n"
                + "LEFT JOIN Receipt_lines rl ON r.receipts_id = rl.receipt_id\n"
                + "LEFT JOIN Products p ON rl.product_id = p.product_id\n"
                + "WHERE 1 = 1 ");

        List<Object> params = new ArrayList();

        if (search_name != null) {
            sql.append("AND s.display_name LIKE ? ");
            params.add(search_name);
        }
        if (tx_type != null) {
            sql.append("AND r.status = ? ");
            params.add(tx_type);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                total_fields = rs.getInt("total_fields");
            }
            rs.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total_fields;
    }

    public static void main(String[] args) {
        TransactionDAO dao = new TransactionDAO();
        List<Response_TransactionDTO> list = dao.transactions(null, null, 0, 10);
        int total = dao.total_lines(null, null);
        if (!list.isEmpty()) {
            System.out.println(list.get(0).getSupplier());
        }
    }
}
