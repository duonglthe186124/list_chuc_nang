package dal;

import model.Shifts;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import util.DBContext;

public class ShiftDAO extends DBContext {

    // Lấy tất cả ca làm việc
    public List<Shifts> getAllShifts() {
        List<Shifts> list = new ArrayList<>();
        String sql = "SELECT shift_id, name, start_time, end_time, note FROM Shifts ORDER BY start_time";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Time startTime = rs.getTime("start_time");
                    Time endTime = rs.getTime("end_time");
                    
                    Shifts shift = new Shifts(
                            rs.getInt("shift_id"),
                            rs.getString("name"),
                            startTime.toLocalTime(),
                            endTime.toLocalTime(),
                            rs.getString("note")
                    );
                    list.add(shift);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy ca làm việc theo ID
    public Shifts getShiftById(int shift_id) {
        String sql = "SELECT shift_id, name, start_time, end_time, note FROM Shifts WHERE shift_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, shift_id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Time startTime = rs.getTime("start_time");
                    Time endTime = rs.getTime("end_time");
                    
                    return new Shifts(
                            rs.getInt("shift_id"),
                            rs.getString("name"),
                            startTime.toLocalTime(),
                            endTime.toLocalTime(),
                            rs.getString("note")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

