package dal;

import dto.SalaryComponentDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.math.BigDecimal;
import util.DBContext;

public class SalaryComponentDAO extends DBContext {

    // Lấy tất cả components theo payroll_id
    public List<SalaryComponentDTO> getComponentsByPayroll(int payroll_id) {
        List<SalaryComponentDTO> list = new ArrayList<>();
        String sql = "SELECT comp_id, payroll_id, comp_type, amount FROM Salary_components WHERE payroll_id = ? ORDER BY comp_id";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    SalaryComponentDTO comp = new SalaryComponentDTO(
                            rs.getInt("comp_id"),
                            rs.getInt("payroll_id"),
                            rs.getString("comp_type"),
                            rs.getBigDecimal("amount")
                    );
                    list.add(comp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Thêm component
    public boolean addComponent(int payroll_id, String comp_type, BigDecimal amount) {
        String sql = "INSERT INTO Salary_components (payroll_id, comp_type, amount) VALUES (?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            ps.setString(2, comp_type);
            ps.setBigDecimal(3, amount);
            
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa components theo payroll_id
    public boolean deleteComponentsByPayroll(int payroll_id) {
        String sql = "DELETE FROM Salary_components WHERE payroll_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Tính tổng các components theo payroll_id
    public BigDecimal getTotalComponentsByPayroll(int payroll_id) {
        String sql = "SELECT SUM(amount) as total FROM Salary_components WHERE payroll_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next() && rs.getBigDecimal("total") != null) {
                    return rs.getBigDecimal("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}

