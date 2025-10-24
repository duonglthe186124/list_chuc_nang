package model;

public class Product_images {

    private int image_id, product_id;
    private String image_url, alt_text;

    public Product_images() {
    }

    public Product_images(int image_id, int product_id, String image_url, String alt_text) {
        this.image_id = image_id;
        this.product_id = product_id;
        this.image_url = image_url;
        this.alt_text = alt_text;
    }

    public int getImage_id() {
        return image_id;
    }

    public void setImage_id(int image_id) {
        this.image_id = image_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getAlt_text() {
        return alt_text;
    }

    public void setAlt_text(String alt_text) {
        this.alt_text = alt_text;
    }

}
