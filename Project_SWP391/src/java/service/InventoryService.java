/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.InventoryDAO;
import dto.InventoryDTO;
import java.util.List;

public class InventoryService {
    private final InventoryDAO dao = new InventoryDAO();

    public List<InventoryDTO> getAll() {
        return dao.list();
    }
}
