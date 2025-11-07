package service;

import dal.SupplierDAO;
import java.util.List;
import model.Suppliers;

/**
 *
 * @author ASUS
 */
public class SupplierManagementService {

    private SupplierDAO sup_dao = new SupplierDAO();

    public List<Suppliers> get_supplier_list(String search_input, int page, int page_size) {
        if (search_input == null || search_input.trim().isEmpty()) {
            search_input = "";
        } else {
            search_input = "%" + search_input + "%";
        }
        int offset = (page - 1) * page_size;

        return sup_dao.suppliers(search_input, offset, page_size);
    }
    
    public int get_total_lines(String search_input)
    {
        if (search_input == null || search_input.trim().isEmpty()) {
            search_input = "";
        } else {
            search_input = "%" + search_input + "%";
        }

        return sup_dao.total_lines(search_input);
    }
}
