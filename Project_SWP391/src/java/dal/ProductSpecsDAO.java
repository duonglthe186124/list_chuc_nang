/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import dto.PriceRange;
import dto.SpecsOptions;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import util.DBContext;

/**
 *
 * @author hoang
 */
public class ProductSpecsDAO extends DBContext{
    public ArrayList<SpecsOptions> getDistinctBrandOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT brand_name FROM Brands ORDER BY brand_name";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions b = new SpecsOptions();
                b.setBrandName(rs.getString("brand_name"));
                list.add(b);
            }
            return list;
        }

    }

    public ArrayList<SpecsOptions> getDistinctCpuOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT cpu FROM Product_specs ORDER BY cpu";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setCpu(rs.getString("cpu"));
                list.add(c);
            }
            return list;
        }

    }

    public ArrayList<SpecsOptions> getDistinctMemoryOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT memory FROM Product_specs ORDER BY memory";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setMemory(rs.getString("memory"));
                list.add(c);
            }
            return list;
        }
    }

    public ArrayList<SpecsOptions> getDistinctStorageOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT storage FROM Product_specs ORDER BY storage";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setStorage(rs.getString("storage"));
                list.add(c);
            }
            return list;
        }

    }

    public ArrayList<SpecsOptions> getDistinctColorOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT color FROM Product_specs ORDER BY color";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setColor(rs.getString("color"));
                list.add(c);
            }
            return list;
        }

    }

    public ArrayList<SpecsOptions> getDistinctBatteryOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT battery_capacity FROM Product_specs ORDER BY battery_capacity";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setBattery(rs.getInt("battery_capacity"));
                list.add(c);
            }
            return list;
        }

    }

    public ArrayList<SpecsOptions> getDistinctScreenSizeOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT screen_size FROM Product_specs ORDER BY screen_size";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setScreenSize(rs.getBigDecimal("screen_size"));
                list.add(c);
            }
            return list;
        }
    }
        
        

    public ArrayList<SpecsOptions> getDistinctScreenTypeOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT screen_type FROM Product_specs ORDER BY screen_type";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setScreenType(rs.getString("screen_type"));
                list.add(c);
            }
            return list;
        }

    }
    
    public ArrayList<SpecsOptions> getDistinctCameraOptions() throws SQLException {
        ArrayList<SpecsOptions> list = new ArrayList<>();
        String sql = "SELECT DISTINCT camera FROM Product_specs ORDER BY camera";
        try (PreparedStatement stm = connection.prepareStatement(sql); ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                SpecsOptions c = new SpecsOptions();
                c.setCamera(rs.getInt("camera"));
                list.add(c);
            }
            return list;
        }

    }
    
    public BigDecimal[] getMinMaxPrice() throws SQLException{
        String sql = "SELECT MIN(purchase_price) AS min_price, MAX(purchase_price) AS max_price FROM Product_units";
         try (PreparedStatement stm = connection.prepareStatement(sql);
             ResultSet rs = stm.executeQuery()) {
            if (rs.next()) {
                BigDecimal min = rs.getBigDecimal("min_price");
                BigDecimal max = rs.getBigDecimal("max_price");
                if (min == null || max == null) 
                    return null;
                return new BigDecimal[] { min, max };
            } else {
                return null;
            }
        }
    }
    
    public static List<PriceRange> generatePriceRanges(BigDecimal min, BigDecimal max, int segments, int scale){
           List<PriceRange> list = new ArrayList<>();
    if (min == null || max == null) return list;

    // Đảm bảo min <= max
    if (min.compareTo(max) > 0) {
        BigDecimal t = min;
        min = max;
        max = t;
    }

    // Nếu chỉ có 1 giá trị duy nhất
    if (min.compareTo(max) == 0) {
        String label = formatMoney(min, scale);
        list.add(new PriceRange(min.setScale(scale, RoundingMode.DOWN), null, label));
        return list;
    }

    // Tính khoảng chênh lệch
    BigDecimal rawRange = max.subtract(min);

    // Chia range thành các đoạn
    BigDecimal rawStep = rawRange.divide(BigDecimal.valueOf(segments), 10, RoundingMode.HALF_UP);

    // Tìm step “đẹp” (nice step)
    double stepD = rawStep.doubleValue();
    if (stepD <= 0) stepD = 1.0;

    double mag = Math.pow(10, Math.floor(Math.log10(stepD)));
    double normalized = stepD / mag;
    double niceNormalized;
    if (normalized <= 1.0) niceNormalized = 1.0;
    else if (normalized <= 2.0) niceNormalized = 2.0;
    else if (normalized <= 5.0) niceNormalized = 5.0;
    else niceNormalized = 10.0;

    double niceStepDouble = niceNormalized * mag;
    BigDecimal niceStep = new BigDecimal(niceStepDouble);

    // Căn start về bội số gần nhất của step (floor)
    BigDecimal firstStart = min.divide(niceStep, 0, RoundingMode.FLOOR).multiply(niceStep);
    if (firstStart.compareTo(min) > 0) {
        firstStart = firstStart.subtract(niceStep);
    }

    // Tạo các khoảng giá
    BigDecimal start = firstStart;
    for (int i = 0; i < segments; i++) {
        BigDecimal end = start.add(niceStep);

        if (end.compareTo(min) <= 0) {
            start = end;
            continue;
        }

        //️ Giữ đúng giá trị min và max thật, chỉ format khi hiển thị
        BigDecimal rangeStart = start.max(min);
        BigDecimal rangeEnd = end.min(max);

        // Hiển thị đẹp — không làm tròn min lên
        BigDecimal displayStart = rangeStart.setScale(scale, RoundingMode.DOWN);
        BigDecimal displayEnd = rangeEnd.setScale(scale, RoundingMode.UP);

        String label;
        if (i == segments - 1 || end.compareTo(max) >= 0) {
            // Range cuối cùng: mở rộng lên max+
            label = formatMoney(displayStart, scale) + "+";
            list.add(new PriceRange(rangeStart, null, label));
            break;
        } else {
            label = formatMoney(displayStart, scale) + " - " + formatMoney(displayEnd, scale);
            list.add(new PriceRange(rangeStart, rangeEnd, label));
        }

        start = end;
    }

    // fallback nếu không có range nào
    if (list.isEmpty()) {
        list.add(new PriceRange(min.setScale(scale, RoundingMode.DOWN), null, formatMoney(min, scale) + "+"));
    }

    return list;
    }
    
     private static String formatMoney(BigDecimal value, int scale) {
        BigDecimal v = value.setScale(scale, RoundingMode.DOWN);
        return v.stripTrailingZeros().toPlainString();
    } 
}
