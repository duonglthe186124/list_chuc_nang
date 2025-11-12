package service;

import dal.ShipmentDAO;
import dto.Response_ShipmentDTO;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class ManageShipmentService {

    private static final String[] STATUS_NAMES = new String[]{"PENDING", "PICKED", "SHIPPED", "CANCELLED"};

    private static final ShipmentDAO shipment_dao = new ShipmentDAO();

    public List<Response_ShipmentDTO> get_shipment_list(String search, String status, int page_size, int page_no) throws IllegalArgumentException {
        if (search != null) {
            search = search + '%';
        }

        if (status != null && !Arrays.asList(STATUS_NAMES).contains(status.toUpperCase())) {
            throw new IllegalArgumentException("404");
        }

        int offset = (page_no - 1) * page_size;

        return shipment_dao.shipment_list(search, status, page_size, offset);
    }

    public int get_total_items(String search, String status) {
        if (search != null) {
            search = search + '%';
        }

        if (status != null && !Arrays.asList(STATUS_NAMES).contains(status.toUpperCase())) {
            throw new IllegalArgumentException("404");
        }

        return shipment_dao.total_items(search, status);
    }

}