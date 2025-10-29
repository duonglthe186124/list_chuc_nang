package service;

import dal.ContainerDAO;
import dal.ProductDAO;
import dal.ProductUnitDAO;
import dal.ReceiptCacheDAO;
import dal.ReceiptDAO;
import dal.WarehouseLocationsDAO;
import dto.Response_LocationDTO;
import dto.Response_ReceiptLineDTO;
import dto.Response_ReceiptHeaderDTO;
import dto.Response_ReceiptOrderDTO;
import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Product_units;
import model.Receipt_lines;
import model.Receipts;

/**
 *
 * @author ASUS
 */
public class ReceiptService {

    private static final ReceiptDAO receipt_dao = new ReceiptDAO();
    private static final ProductDAO product_dao = new ProductDAO();
    private static final ReceiptCacheDAO cache = new ReceiptCacheDAO();
    private static final WarehouseLocationsDAO loc_dao = new WarehouseLocationsDAO();
    private static final ContainerDAO container_dao = new ContainerDAO();
    private static final ProductUnitDAO unit_dao = new ProductUnitDAO();

    public List<Response_ReceiptOrderDTO> get_purchase_order_list() {
        return receipt_dao.PO_list();
    }

    public List<Response_ReceiptLineDTO> get_po_line(int po_id) {
        List<Response_ReceiptLineDTO> po = receipt_dao.po_line(po_id);

        return receipt_dao.po_line(po_id);
    }

    public Response_ReceiptHeaderDTO get_receipt_header(int po_id) {
        return receipt_dao.po_header(po_id);
    }

    public List<Response_LocationDTO> get_location() {
        return loc_dao.locations();
    }

    public String get_auto_receipt_code() {
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
        return "PNK-" + date_code + "-" + no;
    }

    private void update_receipt_code() {
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

    public void create_receipt(int po_id, String receipt_no, int received_by, int[] received_qty, String note,
            int[] location_id, String[] imei, String[] serial_number, Date[] warranty_start, Date[] warranty_end, String[] line_note) {
        String status = "RECEIVED";
        List<Response_ReceiptLineDTO> lists = get_po_line(po_id);

        for (int i = 0; i < lists.size(); i++) {
            if (lists.get(i).getQty() > received_qty[i]) {
                status = "PARTIAL";
            }
        }

        Receipts info = new Receipts(-1, receipt_no, po_id, received_by, status, note, null);
        update_receipt_code();

        int receipt_id = receipt_dao.add_receipt(info);
        
        List<Integer> line_id = new ArrayList(); 
        for (int i = 0; i < lists.size(); i++) {
            Receipt_lines object = new Receipt_lines(-1, receipt_id, lists.get(i).getProduct_id(), lists.get(i).getQty(), received_qty[i],
                    lists.get(i).getUnit_price(), line_note[i]);
            line_id.add(receipt_dao.add_receipt_line(object));
        }

        create_unit(line_id, lists, receipt_id, received_qty, location_id, imei, serial_number, warranty_start, warranty_end);

    }

    private void create_unit(List<Integer> line_id, List<Response_ReceiptLineDTO> lists, int receipt_id, int[] received_qty, int[] location_id,
            String[] imei, String[] serial_number, Date[] warranty_start, Date[] warranty_end) {
        int j = 0, count = 0;
        for (int i = 0; i < lists.size(); i++) {
            count = 0;
            int container_id = container_dao.create_new_container(lists.get(i).getSku_code()+ "-" + String.valueOf(receipt_id), location_id[i]);
            while(count < received_qty[i])
            {
                Product_units unit = new Product_units(-1, imei[j], serial_number[j], warranty_start[j], warranty_end[j],
                            lists.get(i).getProduct_id(), lists.get(i).getUnit_price(), null, container_id,
                            "AVAILABLE", null, null);
                int unit_id = unit_dao.create_new_unit(unit);
                receipt_dao.add_receipt_unit(line_id.get(i), unit_id);
                j++; count++;
                System.out.println(received_qty[i]);
            }
        }
    }
}
