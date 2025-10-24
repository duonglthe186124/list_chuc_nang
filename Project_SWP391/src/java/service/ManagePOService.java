/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.ProductDAO;
import dal.PurchaseOrderDAO;
import dal.SupplierDAO;
import dto.Request_POLineDTO;
import dto.Response_ProductDTO;
import dto.Request_PurchaseOrderDTO;
import dto.Response_SupplierDTO;
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

    public List<Response_SupplierDTO> get_list_supplier() {
        List<Response_SupplierDTO> list = supplier_dao.list_supplier();
        return list;
    }

    public List<Response_ProductDTO> get_list_product() {
        List<Response_ProductDTO> list = product_dao.list_product();
        return list;
    }

    public void add_purchase_order(int supplier_id, Date date, String note, int[] product_id, int[] qty, float[] unit_price) {
        float total_po = 0;
        for (int i = 0; i < product_id.length; i++) {
            total_po += qty[i] * unit_price[i];
        }

        Request_PurchaseOrderDTO order = new Request_PurchaseOrderDTO("PO-20252310-1", supplier_id, 6, date, total_po, null, note);
        int po_id = po_dao.add_purchase_order(order);

        List<Request_POLineDTO> list = new ArrayList();
        for (int i = 0; i < product_id.length; i++) {
            System.out.println(product_id[i]);
            Request_POLineDTO line = new Request_POLineDTO(po_id, product_id[i], unit_price[i], qty[i]);
            list.add(line);
        }
        po_dao.add_po_line(list);
    }
}
