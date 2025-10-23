package dto;

/**
 *
 * @author ASUS
 */
public class POLineRequestDTO {

    private int po_id, product_id;
    private float unit_price;
    private int qty;

    public POLineRequestDTO() {
    }

    public POLineRequestDTO(int po_id, int product_id, float unit_price, int qty) {
        this.po_id = po_id;
        this.product_id = product_id;
        this.unit_price = unit_price;
        this.qty = qty;
    }

    public int getPo_id() {
        return po_id;
    }

    public void setPo_id(int po_id) {
        this.po_id = po_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
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
