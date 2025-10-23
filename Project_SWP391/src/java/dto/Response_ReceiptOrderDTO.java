package dto;

/**
 *
 * @author ASUS
 */
public class Response_ReceiptOrderDTO {

    private int po_id;
    private String po_code;

    public Response_ReceiptOrderDTO() {
    }

    public Response_ReceiptOrderDTO(int po_id, String po_code) {
        this.po_id = po_id;
        this.po_code = po_code;
    }

    public int getPo_id() {
        return po_id;
    }

    public void setPo_id(int po_id) {
        this.po_id = po_id;
    }

    public String getPo_code() {
        return po_code;
    }

    public void setPo_code(String po_code) {
        this.po_code = po_code;
    }

}
