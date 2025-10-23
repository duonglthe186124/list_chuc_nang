package dto;

/**
 *
 * @author ASUS
 */
public class Response_ReceiptLineDTO {

    private int product_id;
    private String product_name;
    private float unit_price;
    private int qty;

    public Response_ReceiptLineDTO(int product_id, String product_name, float unit_price, int qty) {
        this.product_id = product_id;
        this.product_name = product_name;
        this.unit_price = unit_price;
        this.qty = qty;
    }

    public Response_ReceiptLineDTO() {
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

}
