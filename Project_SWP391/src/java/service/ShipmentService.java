package service;

import dal.OrderInfoDAO;
import dal.OrderListDAO;
import dal.ProductUnitDAO;
import dal.ShipmentDAO;
import dto.Response_OrderInfoDTO;
import dto.Response_OrderListDTO;
import dto.ShipmentDTO;
import dto.ShipmentLineDTO;
import dto.ShipmentUnitDTO;
import java.util.ArrayList;
import java.util.List;
import model.Shipment_lines;
import model.Shipments;

/**
 *
 * @author ASUS
 */
public class ShipmentService {

    private OrderInfoDAO od_inf_dao = new OrderInfoDAO();
    private OrderListDAO od_list_dao = new OrderListDAO();
    private ShipmentDAO ship_dao = new ShipmentDAO();
    private ProductUnitDAO pu_dao = new ProductUnitDAO();

    public List<Integer> get_order_id() {
        return od_inf_dao.get_order_id();
    }

    public Response_OrderInfoDTO get_order_info(int order_id) {
        return od_inf_dao.get_order_info(order_id);
    }

    public List<Response_OrderListDTO> get_order_details(int order_id) {
        return od_list_dao.get_order_details(order_id);
    }

    public void add_shipment(int order_id, int user_id,int[] out_qty, String note) {
        Shipments head = new Shipments(-1, "SHP" + String.valueOf((int)(Math.random() * 51) + 100), order_id, user_id, null, null, note);

        int shipment_id = ship_dao.add_shipment_head(head);

        List<Response_OrderListDTO> lists = get_order_details(order_id);
        List<Integer> line_id = new ArrayList();
        List<Integer> product_id = new ArrayList();
        for (int i = 0; i < lists.size(); i++) {
            Shipment_lines object = new Shipment_lines(-1, shipment_id, lists.get(i).getProduct_id(), out_qty[i]);
            line_id.add(ship_dao.add_shipment_line(object));
            product_id.add(lists.get(i).getProduct_id());
        }
        add_shipment_unit(line_id, product_id, out_qty);
    }

    private void add_shipment_unit(List<Integer> line_id, List<Integer> product_id, int[] out_qty) {
        for (int i = 0; i < line_id.size(); i++) {
            List<Integer> unit_id = pu_dao.get_n_unit_id(product_id.get(i), out_qty[i]);
            System.out.println(line_id.get(i) + " " + unit_id.get(i));
            pu_dao.add_shipment_unit(line_id.get(i), unit_id);

        }
    }

    private ShipmentDAO shipmentDAO = new ShipmentDAO();

    public ShipmentDTO getShipmentById(int id) {
        return shipmentDAO.getShipment(id);
    }

    public List<ShipmentLineDTO> getShipmentLines(int shipmentId) {
        return shipmentDAO.getShipmentLines(shipmentId);
    }

    public List<ShipmentUnitDTO> getShipmentUnits(int shipmentId) {
        return shipmentDAO.getShipmentUnits(shipmentId);
    }

    public double getTotalShipmentValue(int shipmentId) {
        return shipmentDAO.calculateTotalValue(shipmentId);
    }
}
