package dto;

/**
 *
 * @author ASUS
 */
public class Response_LineTransactionDTO {

    private int line_id, product_id;
    private String sku_code, name;
    private int qty_expected, qty_received;
    private float unit_price;
    private String note, location;

    public Response_LineTransactionDTO() {
    }

    public Response_LineTransactionDTO(int line_id, int product_id, String sku_code, String name, int qty_expected, int qty_received, float unit_price, String note, String location) {
        this.line_id = line_id;
        this.product_id = product_id;
        this.sku_code = sku_code;
        this.name = name;
        this.qty_expected = qty_expected;
        this.qty_received = qty_received;
        this.unit_price = unit_price;
        this.note = note;
        this.location = location;
    }

    public int getLine_id() {
        return line_id;
    }

    public void setLine_id(int line_id) {
        this.line_id = line_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getSku_code() {
        return sku_code;
    }

    public void setSku_code(String sku_code) {
        this.sku_code = sku_code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQty_expected() {
        return qty_expected;
    }

    public void setQty_expected(int qty_expected) {
        this.qty_expected = qty_expected;
    }

    public int getQty_received() {
        return qty_received;
    }

    public void setQty_received(int qty_received) {
        this.qty_received = qty_received;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

}
