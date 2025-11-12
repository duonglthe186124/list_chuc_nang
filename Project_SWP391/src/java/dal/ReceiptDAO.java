package dal;

import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import util.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Receipt_lines;
import model.Receipts;

/**
 *
 * @author ASUS
 */
public class ReceiptDAO extends DBContext {

    public List<Response_ReceiptOrderDTO> PO_list() {
        List<Response_ReceiptOrderDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	po.po_id,\n"
                + "	po.po_code\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "WHERE po.status = 'CONFIRM' OR po.status = 'PARTIAL'");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ReceiptOrderDTO line = new Response_ReceiptOrderDTO(
                            rs.getInt("po_id"),
                            rs.getString("po_code"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Response_ReceiptHeaderDTO po_header(int po_id) {
        Response_ReceiptHeaderDTO line = null;

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT\n"
                + "	s.display_name,\n"
                + "	po.created_at,\n"
                + "	po.note\n"
                + "FROM Purchase_orders po\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Purchase_order_lines pol ON po.po_id = pol.po_id\n"
                + "WHERE (po.status = 'CONFIRM' OR po.status = 'PARTIAL') AND po.po_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    line = new Response_ReceiptHeaderDTO(
                            rs.getString("display_name"),
                            rs.getDate("created_at"),
                            rs.getString("note"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }

    public List<Response_ReceiptLineDTO> po_line(int po_id) {
        List<Response_ReceiptLineDTO> list = new ArrayList();

        StringBuilder sql = new StringBuilder();
        sql.append("WITH ReceiptSummary AS (\n"
                + "    SELECT\n"
                + "        R.po_id,\n"
                + "        RL.product_id,\n"
                + "        SUM(RL.qty_received) AS qty_received_total\n"
                + "    FROM\n"
                + "        Receipts R\n"
                + "    JOIN\n"
                + "        Receipt_lines RL ON R.receipts_id = RL.receipt_id\n"
                + "    GROUP BY\n"
                + "        R.po_id,\n"
                + "        RL.product_id\n"
                + ")\n"
                + "SELECT\n"
                + "    p.product_id,\n"
                + "    p.sku_code,\n"
                + "    p.name AS product_name,\n"
                + "    pol.unit_price,\n"
                + "    (pol.qty - ISNULL(RS.qty_received_total, 0)) AS qty_remaining\n"
                + "FROM\n"
                + "    Purchase_orders PO\n"
                + "JOIN\n"
                + "    Purchase_order_lines POL ON PO.po_id = POL.po_id\n"
                + "LEFT JOIN\n"
                + "    Products p ON pol.product_id = p.product_id\n"
                + "LEFT JOIN\n"
                + "    ReceiptSummary RS ON PO.po_id = RS.po_id AND POL.product_id = RS.product_id\n"
                + "WHERE 1 = 1 AND PO.po_id = ?\n"
                + "ORDER BY\n"
                + "    PO.po_id,\n"
                + "    POL.product_id");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, po_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_ReceiptLineDTO line = new Response_ReceiptLineDTO(
                            rs.getInt("product_id"),
                            rs.getString("sku_code"),
                            rs.getString("product_name"),
                            rs.getFloat("unit_price"),
                            rs.getInt("qty_remaining"));
                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int add_receipt(Receipts object) {
        int receipt_id = 0;
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO Receipts(receipts_no, po_id, received_by, status)\n"
                + "VALUES(?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, object.getReceipts_no());
            ps.setInt(2, object.getPo_id());
            ps.setInt(3, object.getReceived_by());
            ps.setString(4, object.getStatus());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        receipt_id = rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework
        }
        return receipt_id;
    }

    public int add_receipt_line(Receipt_lines line) {
        int line_id = -1;
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO Receipt_lines(receipt_id, product_id, qty_expected, qty_received, unit_price, note)\n"
                + "VALUES(?, ?, ?, ?, ?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString(), Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, line.getReceipt_id());
            ps.setInt(2, line.getProduct_id());
            ps.setInt(3, line.getQty_expected());
            ps.setInt(4, line.getQty_received());
            ps.setFloat(5, line.getUnit_price());
            ps.setString(6, line.getNote());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        line_id = rs.getInt(1);
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework
        }
        return line_id;
    }

    public void add_receipt_unit(int line_id, int unit_id) {
        StringBuilder sql = new StringBuilder();

        sql.append("INSERT INTO Receipt_units(line_id, unit_id)\n"
                + "VALUES(?, ?)");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, line_id);
            ps.setInt(2, unit_id);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); // Consider using a logging framework
        }
    }
}
