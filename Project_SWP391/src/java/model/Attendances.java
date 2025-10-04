package model;

import java.util.Date;

public class Attendances {

    private int attendance_id, assign_id, employee_id;
    private Date check_in, check_out;
    private float work_hours;
    private String note;

    public Attendances() {
    }

    public Attendances(int attendance_id, int assign_id, int employee_id, Date check_in, Date check_out, float work_hours, String note) {
        this.attendance_id = attendance_id;
        this.assign_id = assign_id;
        this.employee_id = employee_id;
        this.check_in = check_in;
        this.check_out = check_out;
        this.work_hours = work_hours;
        this.note = note;
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

    public float getWork_hours() {
        return work_hours;
    }

    public void setWork_hours(float work_hours) {
        this.work_hours = work_hours;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
