package dto;

import java.util.Date;

public class AttendanceDTO {
    private int attendance_id;
    private int assign_id;
    private int employee_id;
    private String employee_code;
    private String employee_name;
    private String shift_name;
    private String start_time;
    private String end_time;
    private Date assign_date;
    private Date check_in;
    private Date check_out;
    private float hours_worked;
    private String note;
    private String location_code;
    private String role_in_shift;

    public AttendanceDTO() {
    }

    public AttendanceDTO(int attendance_id, int assign_id, int employee_id, String employee_code, 
                        String employee_name, String shift_name, String start_time, String end_time,
                        Date assign_date, Date check_in, Date check_out, float hours_worked, 
                        String note, String location_code, String role_in_shift) {
        this.attendance_id = attendance_id;
        this.assign_id = assign_id;
        this.employee_id = employee_id;
        this.employee_code = employee_code;
        this.employee_name = employee_name;
        this.shift_name = shift_name;
        this.start_time = start_time;
        this.end_time = end_time;
        this.assign_date = assign_date;
        this.check_in = check_in;
        this.check_out = check_out;
        this.hours_worked = hours_worked;
        this.note = note;
        this.location_code = location_code;
        this.role_in_shift = role_in_shift;
    }

    public int getAttendance_id() {
        return attendance_id;
    }

    public void setAttendance_id(int attendance_id) {
        this.attendance_id = attendance_id;
    }

    public int getAssign_id() {
        return assign_id;
    }

    public void setAssign_id(int assign_id) {
        this.assign_id = assign_id;
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

    public Date getAssign_date() {
        return assign_date;
    }

    public void setAssign_date(Date assign_date) {
        this.assign_date = assign_date;
    }

    public Date getCheck_in() {
        return check_in;
    }

    public void setCheck_in(Date check_in) {
        this.check_in = check_in;
    }

    public Date getCheck_out() {
        return check_out;
    }

    public void setCheck_out(Date check_out) {
        this.check_out = check_out;
    }

    public float getHours_worked() {
        return hours_worked;
    }

    public void setHours_worked(float hours_worked) {
        this.hours_worked = hours_worked;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
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

