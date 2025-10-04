package model;

import java.util.Date;

public class Shifts {

    private int shift_id;
    private String name;
    private Date start_time, end_time;
    private String note;

    public Shifts() {
    }

    public Shifts(int shift_id, String name, Date start_time, Date end_time, String note) {
        this.shift_id = shift_id;
        this.name = name;
        this.start_time = start_time;
        this.end_time = end_time;
        this.note = note;
    }

    public int getShift_id() {
        return shift_id;
    }

    public void setShift_id(int shift_id) {
        this.shift_id = shift_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
