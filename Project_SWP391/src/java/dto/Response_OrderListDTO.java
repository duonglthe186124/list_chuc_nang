package dto;

/**
 *
 * @author ASUS
 */
public class Response_OrderListDTO {

    private int product_id;
    private String sku_code, name;
    private Float unit_price;
    private int qty_line;
    private Float total_line;

    public Response_OrderListDTO() {
    }

    public Response_OrderListDTO(int product_id, String sku_code, String name, Float unit_price, int qty_line, Float total_line) {
        this.product_id = product_id;
        this.sku_code = sku_code;
        this.name = name;
        this.unit_price = unit_price;
        this.qty_line = qty_line;
        this.total_line = total_line;
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

    public Float getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(Float unit_price) {
        this.unit_price = unit_price;
    }

    public int getQty_line() {
        return qty_line;
    }

    public void setQty_line(int qty_line) {
        this.qty_line = qty_line;
    }

    public Float getTotal_line() {
        return total_line;
    }

    public void setTotal_line(Float total_line) {
        this.total_line = total_line;
    }

}
