/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package OutboundDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Outbound_inventory;
import util.DBContext;

/**
 *
 * @author tuan
 */
public class outbound {
     public List<Outbound_inventory> getAllOutBoundIn() {
        List<Outbound_inventory> inventorys = new ArrayList<>();
        String sql = "select * from Outbound_inventory";
        try (Connection conn = DBContext.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Outbound_inventory inventory = new Outbound_inventory();
                inventory.setOutbound_id(rs.getInt("outbound_id"));
                inventory.setOutbound_code(rs.getString("outbound_code"));
                inventory.setUser_id(rs.getInt("user_id"));
                inventory.setCreated_by(rs.getInt("created_by"));
                inventory.setCreated_at(rs.getDate("created_at"));
                inventorys.add(inventory);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return inventorys;
    }
      public int getTotalOutBoundIn() {
        String sql = "SELECT COUNT(*) FROM Outbound_inventory";
        try (Connection conn = DBContext.getConnection(); PreparedStatement st = conn.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int total = rs.getInt(1);
                System.out.println("outbound.getTotalOutBoundIn: total=" + total);
                return total;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

 public List<Outbound_inventory> pagingOBInventory(int i, int offset, int limit) {
    List<Outbound_inventory> list = new ArrayList<>();
    // FIX: query the correct table and order by outbound_id
    String sql = "SELECT * FROM Outbound_inventory ORDER BY outbound_id LIMIT ? OFFSET ?";
    try (Connection conn = DBContext.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setInt(1, limit);
        pstmt.setInt(2, offset);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Outbound_inventory inventory = new Outbound_inventory();
            inventory.setOutbound_id(rs.getInt("outbound_id"));
            inventory.setOutbound_code(rs.getString("outbound_code"));
            inventory.setUser_id(rs.getInt("user_id"));
            inventory.setCreated_by(rs.getInt("created_by"));
            inventory.setCreated_at(rs.getDate("created_at"));
            // optional: set note if column exists
            try { inventory.setNote(rs.getString("note")); } catch (Exception ex) { /* ignore if absent */ }
            list.add(inventory);
        }
        System.out.println("outbound.pagingOBInventory: offset=" + offset + ", limit=" + limit + ", returned=" + list.size());
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return list;
}
}