/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.math.BigDecimal;
import java.util.Date;

public class AuditDTO {
    private long audit_id;
    private Date event_time;
    private String user_fullname;
    private String event_type;
    private String reference_table;
    private long reference_id;
    private BigDecimal monetary_value;
    private String detail;
    private String note;

    public long getAudit_id() { return audit_id; }
    public void setAudit_id(long audit_id) { this.audit_id = audit_id; }

    public Date getEvent_time() { return event_time; }
    public void setEvent_time(Date event_time) { this.event_time = event_time; }

    public String getUser_fullname() { return user_fullname; }
    public void setUser_fullname(String user_fullname) { this.user_fullname = user_fullname; }

    public String getEvent_type() { return event_type; }
    public void setEvent_type(String event_type) { this.event_type = event_type; }

    public String getReference_table() { return reference_table; }
    public void setReference_table(String reference_table) { this.reference_table = reference_table; }

    public long getReference_id() { return reference_id; }
    public void setReference_id(long reference_id) { this.reference_id = reference_id; }

    public BigDecimal getMonetary_value() { return monetary_value; }
    public void setMonetary_value(BigDecimal monetary_value) { this.monetary_value = monetary_value; }

    public String getDetail() { return detail; }
    public void setDetail(String detail) { this.detail = detail; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
