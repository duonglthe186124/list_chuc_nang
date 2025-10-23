package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class ReceiptHeaderDTO {

    private int id;
    private String po_code, display_name;
    private Date created_at;
    private String note;

    public ReceiptHeaderDTO() {
    }

    public ReceiptHeaderDTO(int id, String po_code, String display_name, Date created_at, String note) {
        this.id = id;
        this.po_code = po_code;
        this.display_name = display_name;
        this.created_at = created_at;
        this.note = note;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPo_code() {
        return po_code;
    }

    public void setPo_code(String po_code) {
        this.po_code = po_code;
    }

    public String getDisplay_name() {
        return display_name;
    }

    public void setDisplay_name(String display_name) {
        this.display_name = display_name;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
