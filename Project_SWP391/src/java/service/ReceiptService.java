package service;

import dal.ProductDAO;
import dal.ReceiptDAO;
import dto.POLineResponseDTO;
import dto.ReceiptHeaderDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ReceiptService {

    private static final ReceiptDAO receipt_dao = new ReceiptDAO();
    private static final ProductDAO product_dao = new ProductDAO();

    public List<ReceiptHeaderDTO> get_purchase_order_list() {
        return receipt_dao.PO_list();
    }

    public List<POLineResponseDTO> get_po_line(int po_id) {
        return receipt_dao.po_line(po_id);
    }
}
