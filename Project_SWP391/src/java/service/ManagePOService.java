/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.POCacheDAO;
import dal.ProductDAO;
import dal.PurchaseOrderDAO;
import dal.SupplierDAO;
import dto.Response_ProductDTO;
import dto.Response_SupplierDTO;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import model.Purchase_order_lines;
import model.Purchase_orders;

/**
 *
 * @author ASUS
 */
public class ManagePOService {

    private static final SupplierDAO supplier_dao = new SupplierDAO();
    private static final ProductDAO product_dao = new ProductDAO();
    private static final PurchaseOrderDAO po_dao = new PurchaseOrderDAO();
    private static final POCacheDAO cache = new POCacheDAO();

    public List<Response_SupplierDTO> get_list_supplier() {
        List<Response_SupplierDTO> list = supplier_dao.list_supplier();
        return list;
    }

    public List<Response_ProductDTO> get_list_product_sku() {
        List<Response_ProductDTO> list = product_dao.list_product_sku();
        return list;
    }

    public String get_auto_po_code() {
        String po_code;
        int no;

        LocalDate today = LocalDate.now();
        Date save_date = cache.date();
        LocalDate local_date = Instant.ofEpochMilli(save_date.getTime())
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

        if (local_date.isBefore(today)) {
            no = 1;
        } else {
            no = cache.no() + 1;
        }
        String date_code = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
        return "PO-" + date_code + "-" + no;
    }

    public void add_purchase_order(String po_code, int supplier_id, String note, int[] product_id, int[] qty, float[] unit_price) {
        float total_po = 0;
        for (int i = 0; i < product_id.length; i++) {
            total_po += qty[i] * unit_price[i];
        }
        
        int po_id = add_header(po_code, supplier_id, total_po, note);
        
        add_lines(po_id, product_id, qty, unit_price);
        update_po_code();
    }

    private int add_header(String po_code, int supplier_id, float total_po, String note) {
        Purchase_orders order = new Purchase_orders(-1, po_code, supplier_id, 6, null, null, total_po, note);
        return po_dao.add_purchase_order(order);
    }

    private void add_lines(int po_id, int[] product_id, int[] qty, float[] unit_price) {
        List<Purchase_order_lines> list = new ArrayList();
        for (int i = 0; i < product_id.length; i++) {
            Purchase_order_lines line = new Purchase_order_lines(-1, po_id, product_id[i], unit_price[i], qty[i]);
            list.add(line);
        }
        po_dao.add_po_line(list);
    }
    
    private void update_po_code()
    {
        int no;

        LocalDate today = LocalDate.now();
        Date save_date = cache.date();
        LocalDate local_date = Instant.ofEpochMilli(save_date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();

        if (local_date.isBefore(today)) {
            no = 0;
        } else {
            no = cache.no() + 1;
        }
        cache.update(no);
    }

    public static void main(String[] args) {
        ManagePOService a = new ManagePOService();
        System.out.println(a.get_auto_po_code());
        a.update_po_code();
    }
}
