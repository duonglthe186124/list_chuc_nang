package service;

import dal.TransactionDAO;
import dto.TransactionDTO;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class transactionService {

    private static final TransactionDAO dao = new TransactionDAO();

    public List<TransactionDTO> get_transactions(String search_name, String tx_type, int page, int page_size) {
        if (search_name == null || search_name.trim().isEmpty()) {
            search_name = null;
        } else {
            search_name = "%" + search_name + "%";
        }

        if (tx_type == null || tx_type.isEmpty()) {
            tx_type = null;
        }

        int offset = (page - 1) * page_size;

        return dao.transactions(search_name, tx_type, offset, page_size);
    }

    public int get_total_lines(String search_name, String tx_type) {
        if (search_name == null || search_name.trim().isEmpty()) {
            search_name = null;
        } else {
            search_name = "%" + search_name + "%";
        }

        if (tx_type == null || tx_type.isEmpty()) {
            tx_type = null;
        }

        return dao.total_lines(search_name, tx_type);
    }

    public static void main(String[] args) {
        List<TransactionDTO> a = dao.transactions(null, null, 0, 20);
        int page = dao.total_lines(null, null);
        if (!a.isEmpty()) {
            System.out.println(page);
        }
    }
}
