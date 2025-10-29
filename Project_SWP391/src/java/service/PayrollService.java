package service;

import dal.PayrollDAO;
import dal.SalaryComponentDAO;
import dto.PayrollDTO;
import dto.SalaryComponentDTO;
import java.math.BigDecimal;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

public class PayrollService {
    
    private PayrollDAO payrollDAO;
    private SalaryComponentDAO componentDAO;
    
    public PayrollService() {
        payrollDAO = new PayrollDAO();
        componentDAO = new SalaryComponentDAO();
    }
    
    // Lấy tất cả payrolls
    public List<PayrollDTO> getAllPayrolls() {
        List<PayrollDTO> payrolls = payrollDAO.getAllPayrolls();
        
        // Load components cho mỗi payroll
        for (PayrollDTO payroll : payrolls) {
            List<SalaryComponentDTO> components = componentDAO.getComponentsByPayroll(payroll.getPayroll_id());
            payroll.setComponents(components);
        }
        
        return payrolls;
    }
    
    // Lấy payroll theo ID
    public PayrollDTO getPayrollById(int payroll_id) {
        PayrollDTO payroll = payrollDAO.getPayrollById(payroll_id);
        
        if (payroll != null) {
            List<SalaryComponentDTO> components = componentDAO.getComponentsByPayroll(payroll_id);
            payroll.setComponents(components);
        }
        
        return payroll;
    }
    
    // Thêm payroll với components
    public int addPayroll(int employee_id, String period_start, String period_end,
                         List<ComponentInput> components) {
        Date startDate = parseDate(period_start);
        Date endDate = parseDate(period_end);
        
        if (startDate == null || endDate == null) {
            return -1;
        }
        
        // Tính gross và net
        BigDecimal grossAmount = BigDecimal.ZERO;
        BigDecimal netAmount = BigDecimal.ZERO;
        
        for (ComponentInput comp : components) {
            if (comp.getAmount() != null) {
                grossAmount = grossAmount.add(comp.getAmount());
                // Nếu là phụ cấp/thưởng thì cộng vào net, nếu là khấu trừ thì trừ
                if (comp.getType().contains("Lương") || comp.getType().contains("Phụ cấp") || 
                    comp.getType().contains("Thưởng")) {
                    netAmount = netAmount.add(comp.getAmount());
                } else {
                    netAmount = netAmount.subtract(comp.getAmount());
                }
            }
        }
        
        // Tạo payroll
        int payrollId = payrollDAO.addPayroll(employee_id, startDate, endDate, grossAmount, netAmount);
        
        if (payrollId > 0) {
            // Thêm components
            for (ComponentInput comp : components) {
                if (comp.getAmount() != null && comp.getAmount().compareTo(BigDecimal.ZERO) > 0) {
                    componentDAO.addComponent(payrollId, comp.getType(), comp.getAmount());
                }
            }
        }
        
        return payrollId;
    }
    
    // Xóa payroll
    public boolean deletePayroll(int payroll_id) {
        // Xóa components trước
        componentDAO.deleteComponentsByPayroll(payroll_id);
        // Sau đó xóa payroll
        return payrollDAO.deletePayroll(payroll_id);
    }
    
    // Parse date
    private Date parseDate(String dateStr) {
        if (dateStr == null || dateStr.isEmpty()) {
            return null;
        }
        
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilDate = sdf.parse(dateStr);
            return new Date(utilDate.getTime());
        } catch (ParseException e) {
            return null;
        }
    }
    
    // Inner class để nhận input từ form
    public static class ComponentInput {
        private String type;
        private BigDecimal amount;
        
        public ComponentInput(String type, BigDecimal amount) {
            this.type = type;
            this.amount = amount;
        }
        
        public String getType() {
            return type;
        }
        
        public BigDecimal getAmount() {
            return amount;
        }
    }
}
