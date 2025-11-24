package dal;

import dto.Response_PODTO;
import dto.Response_POHeaderDTO;
import dto.Response_POLineDTO;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.Purchase_order_lines;
import model.Purchase_orders;

/**
 * @author ASUS
 */
public class PurchaseOrderDAO extends DBContext {

    public List<Response_PODTO> PO_list(String search, String status, int size, int offset) {
        List<Response_PODTO> list = new ArrayList();
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "    po.po_id,\n"
                + "    po.po_code,\n"
                + "    s.display_name,\n"
                + "    COALESCE(SUM(rc.total_received), 0) AS received,\n"
                + "    SUM(pol.qty) AS total_qty,\n"
                + "    po.total_amount,\n"
                + "    u.fullname,\n"
                + "    po.created_at,\n"
                + "    po.status\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Employees e ON po.created_by = e.employee_id\n"
                + "LEFT JOIN Users u ON e.user_id = u.user_id\n"
                + "LEFT JOIN (\n"
                + "    SELECT\n"
                + "        r.po_id,\n"
                + "        rl.product_id,\n"
                + "        SUM(rl.qty_received) AS total_received\n"
                + "    FROM Receipts r\n"
                + "    JOIN Receipt_lines rl ON r.receipts_id = rl.receipt_id\n"
                + "    WHERE r.status = 'RECEIVED'\n"
                + "    GROUP BY r.po_id, rl.product_id\n"
                + ") rc ON rc.po_id = po.po_id AND rc.product_id = pol.product_id\n"
                + "WHERE 1 = 1 ");

        if (search != null) {
            sql.append("AND (po.po_code LIKE ? OR s.display_name LIKE ? ) ");
            params.add(search);
            params.add(search);
        }

        if (status != null) {
            sql.append("AND po.status = ? ");
            params.add(status);
        }

        sql.append("GROUP BY\n"
                + "    po.po_id,\n"
                + "    po.po_code,\n"
                + "    s.display_name,\n"
                + "    po.total_amount,\n"
                + "    u.fullname,\n"
                + "    po.created_at,\n"
                + "    po.status\n"
                + "ORDER BY po.created_at DESC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(size);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_PODTO line = new Response_PODTO(
                            rs.getInt("po_id"),
                            rs.getString("po_code"),
                            rs.getString("display_name"),
                            rs.getInt("received"),
                            rs.getInt("total_qty"),
                            rs.getFloat("total_amount"),
                            rs.getString("fullname"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getString("status")
                    );
                    list.add(line);
                }
            }

            ps.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int total_items(String search, String status) {
        int items = 0;
        List<Object> params = new ArrayList();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT\n"
                + "	COUNT(po.po_id) AS total_items\n"
                + "FROM Purchase_orders po\n"
                + "WHERE 1 = 1 ");

        if (search != null) {
            sql.append("AND (po.po_code LIKE ? OR s.display_name LIKE ? ) ");
            params.add(search);
            params.add(search);
        }

        if (status != null) {
            sql.append("AND po.status = ? ");
            params.add(status);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    items = rs.getInt("total_items");
                }
            }

            ps.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public Response_POHeaderDTO po_header(int po_id) {
        Response_POHeaderDTO line = null;
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT\n"
                + "	po.po_id,\n"
                + "	po.po_code,\n"
                + "	s.supplier_name,\n"
                + "	po.created_at,\n"
                + "	u.fullname,\n"
                + "	po.status,\n"
                + "	po.note,\n"
                + "     po.total_amount\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Employees e ON po.created_by = e.employee_id\n"
                + "LEFT JOIN Users u ON e.user_id = u.user_id\n"
                + "WHERE 1 = 1 AND po.po_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    line = new Response_POHeaderDTO(
                            rs.getInt("po_id"),
                            rs.getString("po_code"),
                            rs.getString("supplier_name"),
                            rs.getTimestamp("created_at").toLocalDateTime(),
                            rs.getString("fullname"),
                            rs.getString("status"),
                            rs.getString("note"),
                            rs.getFloat("total_amount"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }

    public List<Response_POLineDTO> po_lines(int po_id) {
        List<Response_POLineDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT \n"
                + "    p.name AS product_name,\n"
                + "    p.sku_code,\n"
                + "    pol.unit_price,\n"
                + "    pol.qty AS qty_ordered,\n"
                + "    COALESCE(SUM(rl.qty_received), 0) AS qty_received,\n"
                + "    pol.qty - COALESCE(SUM(rl.qty_received), 0) AS qty_remaining,\n"
                + "    pol.qty * pol.unit_price AS total_line\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Purchase_order_lines pol\n"
                + "    ON pol.po_id = po.po_id\n"
                + "LEFT JOIN Receipts r\n"
                + "    ON r.po_id = po.po_id AND r.status = 'RECEIVED'\n"
                + "LEFT JOIN Receipt_lines rl\n"
                + "    ON rl.receipt_id = r.receipts_id\n"
                + "    AND rl.product_id = pol.product_id\n"
                + "LEFT JOIN Products p\n"
                + "    ON p.product_id = pol.product_id\n"
                + "WHERE po.po_id = ?\n"
                + "GROUP BY \n"
                + "	pol.po_line_id,\n"
                + "    p.name, p.sku_code,\n"
                + "    pol.unit_price, pol.qty\n"
                + "ORDER BY pol.po_line_id;");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_POLineDTO line = new Response_POLineDTO(
                            rs.getString("product_name"),
                            rs.getString("sku_code"),
                            rs.getFloat("unit_price"),
                            rs.getInt("qty_ordered"),
                            rs.getInt("qty_received"),
                            rs.getInt("qty_remaining"),
                            rs.getFloat("total_line"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public int add_purchase_order(Purchase_orders object) {
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
            e.printStackTrace();
        }
        return po_id;
    }

    public void add_po_line(List<Purchase_order_lines> list) {
        StringBuilder sql = new StringBuilder();
        sql.append("INSERT INTO Purchase_order_lines (po_id, product_id, unit_price, qty)\n"
                + "VALUES(?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (Purchase_order_lines line : list) {
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

    public void save_token(int po_id, String token) {
        String sql = "INSERT INTO PO_Token (po_id, token) VALUES (?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, po_id);
            ps.setString(2, token);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean check_tokens(int po_id, String token) {
        String sql = "SELECT 1 FROM PO_Token WHERE po_id = ? AND token = ?";
        boolean isValid = false;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, po_id);
            ps.setString(2, token);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    isValid = true;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return isValid;
    }

    public void remove_token(int po_id, String token) {
        String sql = "DELETE FROM PO_Token WHERE po_id = ? AND token = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, po_id);
            ps.setString(2, token);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean confirm_po(int po_id) {
        String sql = "UPDATE Purchase_orders SET status = 'CONFIRM' WHERE po_id = ? AND status = 'PENDING'";
        boolean existed = false;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, po_id);
            int affectedRows = ps.executeUpdate();
            existed = affectedRows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return existed;
    }

    public void cancel(int po_id) {
        String sql = "UPDATE Purchase_orders SET status = 'CANCELLED' WHERE po_id = ? AND status = 'PENDING'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, po_id);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void update_status(int po_id, String status) {
        String sql = "UPDATE Purchase_orders SET status = ? WHERE po_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, po_id);

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Cập nhật trạng thái thành công cho PO ID: " + po_id);
            } else {
                System.out.println("Không tìm thấy PO ID: " + po_id + " để cập nhật.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
