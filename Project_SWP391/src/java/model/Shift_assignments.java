package model;

import java.util.Date;

public class Shift_assignments {

    private int assign_id, shift_id, employee_id;
    private Date assign_date;
    private int location_id;
    private String role_in_shift;

    public Shift_assignments() {
    }

    public Shift_assignments(int assign_id, int shift_id, int employee_id, Date assign_date, int location_id, String role_in_shift) {
        this.assign_id = assign_id;
        this.shift_id = shift_id;
        this.employee_id = employee_id;
        this.assign_date = assign_date;
        this.location_id = location_id;
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

    public int getEmployee_id() {
        return employee_id;
    }

    public void setEmployee_id(int employee_id) {
        this.employee_id = employee_id;
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

    public String getRole_in_shift() {
        return role_in_shift;
    }

    public void setRole_in_shift(String role_in_shift) {
        this.role_in_shift = role_in_shift;
    }

}
