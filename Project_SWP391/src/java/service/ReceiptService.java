package service;

import dal.ProductDAO;
import dal.ReceiptDAO;
import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import java.util.ArrayList;
import java.util.List;
import model.Receipt_lines;
import model.Receipts;

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

    public Response_ReceiptHeaderDTO get_receipt_header(int po_id) {
        return receipt_dao.po_header(po_id);
    }

    public void create_receipt(int po_id, String receipt_no, int received_by, int[] received_qty) {
        String status = "RECEIVED";
        List<Response_ReceiptLineDTO> lists = get_po_line(po_id);

        for (int i = 0; i < lists.size(); i++) {
            if (lists.get(i).getQty() < received_qty[i]) {
                status = "PARTIAL";
            }
        }

        Receipts info = new Receipts(-1, receipt_no, po_id, received_by, status, null, null);
        int receipt_id = receipt_dao.add_receipt(info);

        List<Receipt_lines> r_list = new ArrayList();
        for (int i = 0; i < lists.size(); i++) {
            Receipt_lines object = new Receipt_lines(-1, receipt_id, lists.get(i).getProduct_id(), lists.get(i).getQty(), received_qty[i],
                    lists.get(i).getUnit_price(), null);
            r_list.add(object);
        }
        
        receipt_dao.add_receipt_line(r_list);
    }
}
