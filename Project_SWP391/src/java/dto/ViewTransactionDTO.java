package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class ViewTransactionDTO {

    private String tx_type;
    private Date tx_date;
    private String ref_code;
    private String employee_code, fullname, product_name, status, description;
    private int qty;
    private String from_code, to_code;
    private String tx_code, tx_name;
    private Date date;
    private String name, color, memory, unit;
    private float price;

    public ViewTransactionDTO() {
    }

    public ViewTransactionDTO(String tx_type, Date tx_date, String ref_code, String employee_code, String fullname, String product_name, String status, String description, int qty, String from_code, String to_code, String tx_code, String tx_name, Date date, String name, String color, String memory, String unit, float price) {
        this.tx_type = tx_type;
        this.tx_date = tx_date;
        this.ref_code = ref_code;
        this.employee_code = employee_code;
        this.fullname = fullname;
        this.product_name = product_name;
        this.status = status;
        this.description = description;
        this.qty = qty;
        this.from_code = from_code;
        this.to_code = to_code;
        this.tx_code = tx_code;
        this.tx_name = tx_name;
        this.date = date;
        this.name = name;
        this.color = color;
        this.memory = memory;
        this.unit = unit;
        this.price = price;
    }

    public String getTx_type() {
        return tx_type;
    }

    public void setTx_type(String tx_type) {
        this.tx_type = tx_type;
    }

    public Date getTx_date() {
        return tx_date;
    }

    public void setTx_date(Date tx_date) {
        this.tx_date = tx_date;
    }

    public String getRef_code() {
        return ref_code;
    }

    public void setRef_code(String ref_code) {
        this.ref_code = ref_code;
    }

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
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

    public String getTx_code() {
        return tx_code;
    }

    public void setTx_code(String tx_code) {
        this.tx_code = tx_code;
    }

    public String getTx_name() {
        return tx_name;
    }

    public void setTx_name(String tx_name) {
        this.tx_name = tx_name;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getMemory() {
        return memory;
    }

    public void setMemory(String memory) {
        this.memory = memory;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

}
