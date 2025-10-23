package service;

import dal.ViewTransactionDAO;
import dto.Response_LineTransactionDTO;
import dto.Response_SerialTransactionDTO;
import dto.Response_ViewTransactionDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ViewTransactionService {

    private static final ViewTransactionDAO dao = new ViewTransactionDAO();

    public Response_ViewTransactionDTO get_transaction_view(int receipt_id) {
        if (!dao.check_exists_transaction(receipt_id)) {
            return null;
        }
        return dao.view_transaction(receipt_id);
    }

    public List<Response_LineTransactionDTO> get_transaction_line(int receipt_id) {

        return dao.transaction_line(receipt_id);
    }

    public List<Response_SerialTransactionDTO> get_transaction_unit(int receipt_id) {
        return dao.transaction_units(receipt_id);
    }

    public static void main(String[] args) {
        List<Response_LineTransactionDTO> a = dao.transaction_line(11);
        if (!a.isEmpty()) {
            System.out.println(a.get(1).getQty_expected());
        }
    }  
}
