package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class TransactionDTO {

    private int tx_id;
    private String product_name;
    private int qty;
    private String unit_name, tx_type, from_code, to_code, employee_code;
    private Date tx_date;

    public TransactionDTO() {
    }

    public TransactionDTO(int tx_id, String product_name, int qty, String unit_name, String tx_type, String from_code, String to_code, String employee_code, Date tx_date) {
        this.tx_id = tx_id;
        this.product_name = product_name;
        this.qty = qty;
        this.unit_name = unit_name;
        this.tx_type = tx_type;
        this.from_code = from_code;
        this.to_code = to_code;
        this.employee_code = employee_code;
        this.tx_date = tx_date;
    }

    public int getTx_id() {
        return tx_id;
    }

    public void setTx_id(int tx_id) {
        this.tx_id = tx_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getUnit_name() {
        return unit_name;
    }

    public void setUnit_name(String unit_name) {
        this.unit_name = unit_name;
    }

    public String getTx_type() {
        return tx_type;
    }

    public void setTx_type(String tx_type) {
        this.tx_type = tx_type;
    }

    public String getFrom_code() {
        return from_code;
    }

    public void setFrom_code(String from_code) {
        this.from_code = from_code;
    }

    public String getTo_code() {
        return to_code;
    }

    public void setTo_code(String to_code) {
        this.to_code = to_code;
    }

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public Date getTx_date() {
        return tx_date;
    }

    public void setTx_date(Date tx_date) {
        this.tx_date = tx_date;
    }

}
