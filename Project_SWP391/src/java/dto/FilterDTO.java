/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;

public class FilterDTO {
    private int tx_id;
    private String tx_type;
    private String product_name;
    private String employee_code;
    private String fullname;
    private Date tx_date;

    public int getTx_id() { return tx_id; }
    public void setTx_id(int tx_id) { this.tx_id = tx_id; }

    public String getTx_type() { return tx_type; }
    public void setTx_type(String tx_type) { this.tx_type = tx_type; }

    public String getProduct_name() { return product_name; }
    public void setProduct_name(String product_name) { this.product_name = product_name; }

    public String getEmployee_code() { return employee_code; }
    public void setEmployee_code(String employee_code) { this.employee_code = employee_code; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public Date getTx_date() { return tx_date; }
    public void setTx_date(Date tx_date) { this.tx_date = tx_date; }
}
