/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.util.Date;

public class QualityDTO {
    private int inspection_id;
    private String inspection_no;
    private String employee_code;
    private String fullname;
    private String status;
    private String result;
    private String note;
    private Date inspected_at;
    private String location_code;

    public int getInspection_id() { return inspection_id; }
    public void setInspection_id(int inspection_id) { this.inspection_id = inspection_id; }

    public String getInspection_no() { return inspection_no; }
    public void setInspection_no(String inspection_no) { this.inspection_no = inspection_no; }

    public String getEmployee_code() { return employee_code; }
    public void setEmployee_code(String employee_code) { this.employee_code = employee_code; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }

    public Date getInspected_at() { return inspected_at; }
    public void setInspected_at(Date inspected_at) { this.inspected_at = inspected_at; }

    public String getLocation_code() { return location_code; }
    public void setLocation_code(String location_code) { this.location_code = location_code; }
}
