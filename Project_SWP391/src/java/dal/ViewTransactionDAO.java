package dal;

import dto.Response_LineTransactionDTO;
import dto.Response_SerialTransactionDTO;
import dto.Response_ViewTransactionDTO;
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

    public boolean check_exists_transaction(int receipt_id) {
        int count = 0;
        boolean check = false;

        String sql = "SELECT COUNT(r.receipts_id) AS total\n"
                + "FROM Receipts r\n"
                + "WHERE r.receipts_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, receipt_id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                count = rs.getInt("total");
                if (count > 0) {
                    check = true;
                }
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return check;
    }

    public Response_ViewTransactionDTO view_transaction(int receipt_id) {
        Response_ViewTransactionDTO line = null;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "	r.receipts_no,\n"
                + "	po.po_code,\n"
                + "	po.created_at,\n"
                + "	r.status,\n"
                + "	r.received_at,\n"
                + "	e.employee_code,\n"
                + "	u.fullname,	\n"
                + "	s.supplier_name,\n"
                + "	po.note \n"
                + "FROM Receipts r\n"
                + "LEFT JOIN Purchase_orders po ON r.po_id = po.po_id\n"
                + "LEFT JOIN Employees e ON r.received_by = e.employee_id\n"
                + "LEFT JOIN Suppliers s ON po.supplier_id = s.supplier_id\n"
                + "LEFT JOIN Users u ON e.user_id = u.user_id\n"
                + "WHERE 1 = 1 ");

        if (check_exists_transaction(receipt_id)) {
            sql.append(" AND r.receipts_id = ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, receipt_id);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                line = new Response_ViewTransactionDTO(
                        rs.getString("receipts_no"),
                        rs.getString("po_code"),
                        rs.getDate("created_at"),
                        rs.getString("status"),
                        rs.getDate("received_at"),
                        rs.getString("employee_code"),
                        rs.getString("fullname"),
                        rs.getString("supplier_name"),
                        rs.getString("note"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return line;
    }

    public List<Response_LineTransactionDTO> transaction_line(int receipt_id) {
        List<Response_LineTransactionDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("WITH Location_Ranked AS (\n"
                + "    SELECT\n"
                + "        ru.line_id,\n"
                + "        wl.aisle,\n"
                + "        wl.area,\n"
                + "        wl.slot,\n"
                + "        ROW_NUMBER() OVER (\n"
                + "            PARTITION BY ru.line_id \n"
                + "            ORDER BY wl.aisle, wl.area, wl.slot\n"
                + "        ) as rn\n"
                + "    FROM\n"
                + "        Receipt_units ru\n"
                + "    JOIN\n"
                + "        Product_units pu ON ru.unit_id = pu.unit_id\n"
                + "    JOIN\n"
                + "        Containers c ON pu.container_id = c.container_id\n"
                + "    JOIN\n"
                + "        Warehouse_locations wl ON c.location_id = wl.location_id\n"
                + ")\n"
                + "SELECT\n"
                + "    rl.line_id,\n"
                + "    p.product_id,\n"
                + "    p.sku_code,\n"
                + "    p.name,\n"
                + "    rl.qty_expected,\n"
                + "    rl.qty_received,\n"
                + "    rl.unit_price,\n"
                + "    rl.note,\n"
                + "    lr.aisle,\n"
                + "    lr.area,\n"
                + "    lr.slot\n"
                + "FROM\n"
                + "    Receipt_lines rl\n"
                + "LEFT JOIN\n"
                + "    Products p ON rl.product_id = p.product_id\n"
                + "LEFT JOIN\n"
                + "    Location_Ranked lr ON rl.line_id = lr.line_id AND lr.rn = 1\n"
                + "WHERE 1 = 1 AND rl.receipt_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, receipt_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String location = "";

                    Response_LineTransactionDTO line = new Response_LineTransactionDTO(
                            rs.getInt("line_id"),
                            rs.getInt("product_id"),
                            rs.getString("sku_code"),
                            rs.getString("name"),
                            rs.getInt("qty_expected"),
                            rs.getInt("qty_received"),
                            rs.getFloat("unit_price"),
                            rs.getString("note"),
                            location += rs.getString("area") + "-" + rs.getString("aisle") + "-" + rs.getString("slot"));
                    list.add(line);
                }
                rs.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Response_SerialTransactionDTO> transaction_units(int receipt_id, int product_id) {
        List<Response_SerialTransactionDTO> list = new ArrayList();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT \n"
                + "	pu.imei,\n"
                + "	pu.serial_number,\n"
                + "	pu.warranty_start,\n"
                + "	pu.warranty_end\n"
                + "FROM Receipt_lines rl\n"
                + "LEFT JOIN Receipt_units ru ON rl.line_id = ru.line_id\n"
                + "LEFT JOIN Product_units pu ON ru.unit_id = pu.unit_id\n"
                + "WHERE rl.receipt_id = ? AND pu.product_id = ?");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            ps.setInt(1, receipt_id);
            ps.setInt(2, product_id);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Response_SerialTransactionDTO line = new Response_SerialTransactionDTO(
                            rs.getString("imei"),
                            rs.getString("serial_number"),
                            rs.getDate("warranty_start"),
                            rs.getDate("warranty_end"));

                    list.add(line);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ViewTransactionDAO dao = new ViewTransactionDAO();
        List<Response_LineTransactionDTO> l = dao.transaction_line(1);

        if (l != null) {
            System.out.println(l.get(0).getLocation());
        }
    }
}
