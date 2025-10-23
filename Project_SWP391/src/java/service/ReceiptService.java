package service;

import dal.ProductDAO;
import dal.ReceiptDAO;
import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ReceiptService {

    private static final ReceiptDAO receipt_dao = new ReceiptDAO();
    private static final ProductDAO product_dao = new ProductDAO();

    public List<Response_ReceiptOrderDTO> get_purchase_order_list() {
        return receipt_dao.PO_list();
    }

    public List<Response_ReceiptLineDTO> get_po_line(int po_id) {
        return receipt_dao.po_line(po_id);
    }
    
    public Response_ReceiptHeaderDTO get_receipt_header(int po_id)
    {
        return receipt_dao.po_header(po_id);
    }
}
