package service;

import dal.ViewTransactionDAO;
import dto.LineTransactionDTO;
import dto.ViewTransactionDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class viewTransactionService {

    private static final ViewTransactionDAO dao = new ViewTransactionDAO();

    public ViewTransactionDTO get_transaction_view(int receipt_id) {
        if (!dao.check_exists_transaction(receipt_id)) {
            return null;
        }
        return dao.view_transaction(receipt_id);
    }
    
    public List<LineTransactionDTO> get_transaction_line(int receipt_id)
    {
        
        return dao.transaction_line(receipt_id);
    }

    public static void main(String[] args) {
        List<LineTransactionDTO> a = dao.transaction_line(11);
        if (!a.isEmpty()) {
            System.out.println(a.get(1).getQty_expected());
        }
    }
}
