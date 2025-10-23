/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.ProductDAO;
import dal.PurchaseOrderDAO;
import dal.SupplierDAO;
import dto.POLineRequestDTO;
import dto.ProductResponseDTO;
import dto.PurchaseOrderRequestDTO;
import dto.SupplierResponseDTO;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ManagePOService {

    private static final SupplierDAO supplier_dao = new SupplierDAO();
    private static final ProductDAO product_dao = new ProductDAO();
    private static final PurchaseOrderDAO po_dao = new PurchaseOrderDAO();

    public List<SupplierResponseDTO> get_list_supplier() {
        List<SupplierResponseDTO> list = supplier_dao.list_supplier();
        return list;
    }

    public List<ProductResponseDTO> get_list_product() {
        List<ProductResponseDTO> list = product_dao.list_product();
        return list;
    }

    public void add_purchase_order(int supplier_id, Date date, String note, int[] product_id, int[] qty, float[] unit_price) {
        float total_po = 0;
        for (int i = 0; i < product_id.length; i++) {
            total_po += qty[i] * unit_price[i];
        }

        PurchaseOrderRequestDTO order = new PurchaseOrderRequestDTO("PO-20252310-1", supplier_id, 6, date, total_po, null, note);
        int po_id = po_dao.add_purchase_order(order);

        List<POLineRequestDTO> list = new ArrayList();
        for (int i = 0; i < product_id.length; i++) {
            POLineRequestDTO line = new POLineRequestDTO(po_id, product_id[i], unit_price[i], qty[i]);
            list.add(line);
        }
        
        
    }
}
