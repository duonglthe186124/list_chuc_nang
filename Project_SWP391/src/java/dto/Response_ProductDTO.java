package dto;

/**
 *
 * @author ASUS
 */
public class Response_ProductDTO {

    private int product_id;
    private String sku_code;

    public Response_ProductDTO() {
    }

    public Response_ProductDTO(int product_id, String sku_code) {
        this.product_id = product_id;
        this.sku_code = sku_code;
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

}
