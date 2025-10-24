package dto;

/**
 *
 * @author ASUS
 */
public class Response_ProductDTO {

    private int product_id;
    private String name;

    public Response_ProductDTO(int product_id, String name) {
        this.product_id = product_id;
        this.name = name;
    }

    public Response_ProductDTO() {
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
