package dto;

import java.util.Date;

public class ShiftAssignmentDTO {
    private int assign_id;
    private int shift_id;
    private String shift_name;
    private String start_time;
    private String end_time;
    private int employee_id;
    private String employee_code;
    private String employee_name;
    private Date assign_date;
    private int location_id;
    private String location_code;
    private String role_in_shift;

    public ShiftAssignmentDTO() {
    }

    public ShiftAssignmentDTO(int assign_id, int shift_id, String shift_name, String start_time, 
                             String end_time, int employee_id, String employee_code, String employee_name,
                             Date assign_date, int location_id, String location_code, String role_in_shift) {
        this.assign_id = assign_id;
        this.shift_id = shift_id;
        this.shift_name = shift_name;
        this.start_time = start_time;
        this.end_time = end_time;
        this.employee_id = employee_id;
        this.employee_code = employee_code;
        this.employee_name = employee_name;
        this.assign_date = assign_date;
        this.location_id = location_id;
        this.location_code = location_code;
        this.role_in_shift = role_in_shift;
    }

    public int getAssign_id() {
        return assign_id;
    }

    public void setAssign_id(int assign_id) {
        this.assign_id = assign_id;
    }

    public int getShift_id() {
        return shift_id;
    }

    public void setShift_id(int shift_id) {
        this.shift_id = shift_id;
    }

    public String getShift_name() {
        return shift_name;
    }

    public void setShift_name(String shift_name) {
        this.shift_name = shift_name;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
    }

    public String getEmployee_code() {
        return employee_code;
    }

    public void setEmployee_code(String employee_code) {
        this.employee_code = employee_code;
    }

    public String getEmployee_name() {
        return employee_name;
    }

    public void setEmployee_name(String employee_name) {
        this.employee_name = employee_name;
    }

    public Date getAssign_date() {
        return assign_date;
    }

    public void setAssign_date(Date assign_date) {
        this.assign_date = assign_date;
    }

    public int getLocation_id() {
        return location_id;
    }

    public void setLocation_id(int location_id) {
        this.location_id = location_id;
    }

    public String getLocation_code() {
        return location_code;
    }

    public void setLocation_code(String location_code) {
        this.location_code = location_code;
    }

    public String getRole_in_shift() {
        return role_in_shift;
    }

    public void setRole_in_shift(String role_in_shift) {
        this.role_in_shift = role_in_shift;
    }
}

