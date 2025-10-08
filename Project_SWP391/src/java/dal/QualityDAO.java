/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author Ha Trung KI
 */
import util.DBContext;
import java.sql.*;

public class QualityDAO extends DBContext {

    public void insertQualityCheck(int productId, int locationId, int unitId, String state, int inspectorId, String remark) throws SQLException {
        // If unit_id not used, pass null as unitId
        String txType = "QUALITY_UNKNOWN";
        if ("PASS".equalsIgnoreCase(state) || "GOOD".equalsIgnoreCase(state)) txType = "QUALITY_PASS";
        if ("FAIL".equalsIgnoreCase(state) || "BAD".equalsIgnoreCase(state)) txType = "QUALITY_FAIL";

        String sql = "INSERT INTO Inventory_transactions (tx_type, product_id, unit_id, qty, from_location, to_location, ref_code, related_inbound_id, related_outbound_id, employee_id, tx_date, note) VALUES (?, ?, ?, ?, ?, NULL, NULL, NULL, NULL, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, txType);
            ps.setInt(2, productId);
            if (unitId > 0) ps.setInt(3, unitId); else ps.setNull(3, Types.INTEGER);
            ps.setInt(4, 0); // qty not relevant for QC (or set if QC applied on units)
            ps.setInt(5, locationId);
            ps.setInt(6, inspectorId);
            ps.setString(7, remark);
            ps.executeUpdate();
        }
    }
}