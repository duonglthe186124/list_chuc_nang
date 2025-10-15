package service;

import dal.ViewTransactionDAO;
import dto.ViewTransactionDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class viewTransactionService {

    private static final ViewTransactionDAO dao = new ViewTransactionDAO();

    public ViewTransactionDTO get_transaction_view(int tx_id) {
        if (!dao.check_exists_transaction(tx_id)) {
            return null;
        }

        return dao.view_transaction(tx_id);
    }

    public static void main(String[] args) {
        ViewTransactionDTO a = dao.view_transaction(1);
        if (a != null) {
            System.out.println(a.getName());
        }
    }
}
