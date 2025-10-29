package dal;

import dto.PayrollDTO;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Statement;
import java.sql.Timestamp;
import java.math.BigDecimal;
import util.DBContext;

public class PayrollDAO extends DBContext {

    // Lấy tất cả payrolls
    public List<PayrollDTO> getAllPayrolls() {
        List<PayrollDTO> list = new ArrayList<>();
        String sql = "SELECT "
                + "p.payroll_id, "
                + "p.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "p.period_start, "
                + "p.period_end, "
                + "p.gross_amount, "
                + "p.net_amount, "
                + "p.created_at "
                + "FROM Payrolls p "
                + "INNER JOIN Employees e ON p.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "ORDER BY p.period_start DESC, p.created_at DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    PayrollDTO payroll = new PayrollDTO(
                            rs.getInt("payroll_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getDate("period_start"),
                            rs.getDate("period_end"),
                            rs.getBigDecimal("gross_amount"),
                            rs.getBigDecimal("net_amount"),
                            rs.getTimestamp("created_at")
                    );
                    list.add(payroll);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy payroll theo ID
    public PayrollDTO getPayrollById(int payroll_id) {
        String sql = "SELECT "
                + "p.payroll_id, "
                + "p.employee_id, "
                + "e.employee_code, "
                + "u.fullname as employee_name, "
                + "p.period_start, "
                + "p.period_end, "
                + "p.gross_amount, "
                + "p.net_amount, "
                + "p.created_at "
                + "FROM Payrolls p "
                + "INNER JOIN Employees e ON p.employee_id = e.employee_id "
                + "INNER JOIN Users u ON e.user_id = u.user_id "
                + "WHERE p.payroll_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new PayrollDTO(
                            rs.getInt("payroll_id"),
                            rs.getInt("employee_id"),
                            rs.getString("employee_code"),
                            rs.getString("employee_name"),
                            rs.getDate("period_start"),
                            rs.getDate("period_end"),
                            rs.getBigDecimal("gross_amount"),
                            rs.getBigDecimal("net_amount"),
                            rs.getTimestamp("created_at")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm payroll mới
    public int addPayroll(int employee_id, Date period_start, Date period_end, 
                         BigDecimal gross_amount, BigDecimal net_amount) {
        String sql = "INSERT INTO Payrolls (employee_id, period_start, period_end, gross_amount, net_amount) "
                + "VALUES (?, ?, ?, ?, ?)";
        
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, employee_id);
            ps.setDate(2, period_start);
            ps.setDate(3, period_end);
            ps.setBigDecimal(4, gross_amount);
            ps.setBigDecimal(5, net_amount);
            
            ps.executeUpdate();
            
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Xóa payroll
    public boolean deletePayroll(int payroll_id) {
        String sql = "DELETE FROM Payrolls WHERE payroll_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, payroll_id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}

