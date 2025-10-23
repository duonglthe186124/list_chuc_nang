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

    public List<TransactionDTO> get_transactions(String search_name, String status, int page, int page_size) {
        if (search_name == null || search_name.trim().isEmpty()) {
            search_name = null;
        } else {
            search_name = "%" + search_name + "%";
        }

        if (status == null || status.isEmpty()) {
            status = null;
        }

        int offset = (page - 1) * page_size;

        return dao.transactions(search_name, status, offset, page_size);
    }

    public int get_total_lines(String search_name, String status) {
        if (search_name == null || search_name.trim().isEmpty()) {
            search_name = null;
        } else {
            search_name = "%" + search_name + "%";
        }

        if (status == null || status.isEmpty()) {
            status = null;
        }

        return dao.total_lines(search_name, status);
    }

    public static void main(String[] args) {
        List<TransactionDTO> a = dao.transactions(null, null, 0, 20);
        int page = dao.total_lines(null, null);
        if (!a.isEmpty()) {
            System.out.println(a.get(0).getReceipt_no() + " " + a.get(0).getTotal());
        }
    }
}
