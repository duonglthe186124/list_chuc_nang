/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;
import model.PriceRange;
import model.SpecsOptions;

/**
 *
 * @author hoang
 */
public class ProductSpecsDBContext extends DBContext {

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
                c.setScreenSize(rs.getFloat("screen_size"));
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
        String sql = "SELECT MIN(unit_price) AS min_price, MAX(unit_price) AS max_price FROM Product_units";
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
        if(min.compareTo(max)>0){
            BigDecimal t = min;
            min = max;
            max = t;
        }
        if(min.compareTo(max)==0){
            String label = formatMoney(min, scale);
            PriceRange p = new PriceRange(min.setScale(scale, RoundingMode.HALF_UP), null, label);
            list.add(p);
            return list;
        }
        
        BigDecimal rawRange = max.subtract(min);
        
        BigDecimal rawStep = rawRange.divide(BigDecimal.valueOf(segments), 10, RoundingMode.HALF_UP);
        
        // convert to double for magnitude calculation (ok vì chỉ cho step)
        double stepD = rawStep.doubleValue();
        if (stepD <= 0) stepD = 1.0;
        
         // nice step algorithm: choose 1,2,5,10 * 10^k
        double mag = Math.pow(10, Math.floor(Math.log10(stepD)));
        double normalized = stepD / mag;
        double niceNormalized;
        if (normalized <= 1.0) niceNormalized = 1.0;
        else if (normalized <= 2.0) niceNormalized = 2.0;
        else if (normalized <= 5.0) niceNormalized = 5.0;
        else niceNormalized = 10.0;

        double niceStepDouble = niceNormalized * mag;
        BigDecimal niceStep = new BigDecimal(niceStepDouble).setScale(scale, RoundingMode.CEILING);


        // Align start to a multiple of niceStep (floor)
        BigDecimal firstStart = min.divide(niceStep, 0, RoundingMode.FLOOR).multiply(niceStep);

        // if firstStart > min then reduce one step
        if (firstStart.compareTo(min) > 0) {
            firstStart = firstStart.subtract(niceStep);
        }
        // create ranges
        BigDecimal start = firstStart;
        for (int i = 0; i < segments; i++) {
            BigDecimal end = start.add(niceStep);
            // If end <= min, skip (safety)
            if (end.compareTo(min) <= 0) { 
                start = end; continue; 
            }
            BigDecimal displayStart = start.max(min).setScale(scale, RoundingMode.HALF_UP);
            BigDecimal displayEnd = end.min(max).setScale(scale, RoundingMode.HALF_UP);
            String label;
            if (i == segments - 1 || end.compareTo(max) >= 0) {
                // last bucket: open-ended from displayStart
                label = formatMoney(displayStart, scale) + "+";
                list.add(new model.PriceRange(displayStart, null, label));
                break;
            } else {
                label = formatMoney(displayStart, scale) + " - " + formatMoney(displayEnd, scale);
                list.add(new model.PriceRange(displayStart, displayEnd, label));
            }
            start = end;
        }
        
         // safety: if list empty, fallback single bucket
        if (list.isEmpty()) {
            list.add(new model.PriceRange(min.setScale(scale, RoundingMode.HALF_UP), null, formatMoney(min, scale) + "+"));
        }
        return list;
    }
    
     private static String formatMoney(BigDecimal value, int scale) {
        // đơn giản: no grouping; bạn có thể dùng NumberFormat để format với dấu phẩy
        BigDecimal v = value.setScale(scale, RoundingMode.HALF_UP);
        return v.stripTrailingZeros().toPlainString();
    }
}


