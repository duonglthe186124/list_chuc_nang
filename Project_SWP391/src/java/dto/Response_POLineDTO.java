package dto;

/**
 *
 * @author ASUS
 */
public class Response_POLineDTO {

    private String product_name, sku_code;
    private float unit_price;
    private int qty_ordered, qty_received, qty_remaining;
    private float total_line;

    public Response_POLineDTO() {
    }

    public Response_POLineDTO(String product_name, String sku_code, float unit_price, int qty_ordered, int qty_received, int qty_remaining, float total_line) {
        this.product_name = product_name;
        this.sku_code = sku_code;
        this.unit_price = unit_price;
        this.qty_ordered = qty_ordered;
        this.qty_received = qty_received;
        this.qty_remaining = qty_remaining;
        this.total_line = total_line;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public String getSku_code() {
        return sku_code;
    }

    public void setSku_code(String sku_code) {
        this.sku_code = sku_code;
    }

    public float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(float unit_price) {
        this.unit_price = unit_price;
    }

    public int getQty_ordered() {
        return qty_ordered;
    }

    public void setQty_ordered(int qty_ordered) {
        this.qty_ordered = qty_ordered;
    }

    public int getQty_received() {
        return qty_received;
    }

    public void setQty_received(int qty_received) {
        this.qty_received = qty_received;
    }

    public int getQty_remaining() {
        return qty_remaining;
    }

    public void setQty_remaining(int qty_remaining) {
        this.qty_remaining = qty_remaining;
    }

    public float getTotal_line() {
        return total_line;
    }

    public void setTotal_line(float total_line) {
        this.total_line = total_line;
    }

}
