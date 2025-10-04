package model;

import java.util.Date;

public class Quality_controls {

    private int qc_id, unit_id, inbound_line_id, inspector_id;
    private Date qc_date;
    private String state, error, remarks;

    public Quality_controls() {
    }

    public Quality_controls(int qc_id, int unit_id, int inbound_line_id, int inspector_id, Date qc_date, String state, String error, String remarks) {
        this.qc_id = qc_id;
        this.unit_id = unit_id;
        this.inbound_line_id = inbound_line_id;
        this.inspector_id = inspector_id;
        this.qc_date = qc_date;
        this.state = state;
        this.error = error;
        this.remarks = remarks;
    }

    public int getQc_id() {
        return qc_id;
    }

    public void setQc_id(int qc_id) {
        this.qc_id = qc_id;
    }

    public int getUnit_id() {
        return unit_id;
    }

    public void setUnit_id(int unit_id) {
        this.unit_id = unit_id;
    }

    public int getInbound_line_id() {
        return inbound_line_id;
    }

    public void setInbound_line_id(int inbound_line_id) {
        this.inbound_line_id = inbound_line_id;
    }

    public int getInspector_id() {
        return inspector_id;
    }

    public void setInspector_id(int inspector_id) {
        this.inspector_id = inspector_id;
    }

    public Date getQc_date() {
        return qc_date;
    }

    public void setQc_date(Date qc_date) {
        this.qc_date = qc_date;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

}
