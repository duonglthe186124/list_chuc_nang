package model;

import java.util.Date;

public class Attendances {

    private int attendances_id, assign_id, employee_id;
    private Date check_in, check_out;
    private float hour_worked;
    private String note;

    public Attendances() {
    }

    public Attendances(int attendances_id, int assign_id, int employee_id, Date check_in, Date check_out, float hour_worked, String note) {
        this.attendances_id = attendances_id;
        this.assign_id = assign_id;
        this.employee_id = employee_id;
        this.check_in = check_in;
        this.check_out = check_out;
        this.hour_worked = hour_worked;
        this.note = note;
    }

    public int getAttendances_id() {
        return attendances_id;
    }

    public void setAttendances_id(int attendances_id) {
        this.attendances_id = attendances_id;
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

    public float getHour_worked() {
        return hour_worked;
    }

    public void setHour_worked(float hour_worked) {
        this.hour_worked = hour_worked;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
