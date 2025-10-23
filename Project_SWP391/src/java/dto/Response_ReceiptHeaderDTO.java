package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class Response_ReceiptHeaderDTO {

    private String display_name;
    private Date created_at;
    private String note;

    public Response_ReceiptHeaderDTO() {
    }

    public Response_ReceiptHeaderDTO(String display_name, Date created_at, String note) {
        this.display_name = display_name;
        this.created_at = created_at;
        this.note = note;
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
