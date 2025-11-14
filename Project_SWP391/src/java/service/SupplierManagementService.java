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

    public int get_total_lines(String search_input) {
        if (search_input == null || search_input.trim().isEmpty()) {
            search_input = "";
        } else {
            search_input = "%" + search_input + "%";
        }

        return sup_dao.total_lines(search_input);
    }

    public Suppliers getSupplierDetails(int id) {
        return sup_dao.supplier(id);
    }

    public int create_supplier(Suppliers supplier) {
        if (supplier == null || supplier.getSupplier_name().isEmpty() || supplier.getPhone().isEmpty()) {
            return -1;
        }

        return sup_dao.insert_supplier(supplier);
    }

    public boolean update_supplier_info(Suppliers supplier) {
        if (supplier == null || supplier.getSupplier_id() <= 0) {
            return false;
        }

        return sup_dao.update_supplier(supplier);
    }

    public boolean remove_supplier(int supplier_id) {
        if (supplier_id <= 0) {
            return false;
        }

        return sup_dao.delete_supplier(supplier_id);
    }
}
