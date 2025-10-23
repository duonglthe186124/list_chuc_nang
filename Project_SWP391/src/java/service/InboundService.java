/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.InboundDAO;
import dto.InboundDTO;
import java.util.List;

public class InboundService {
    private final InboundDAO dao = new InboundDAO();

    public List<InboundDTO> getAllReceipts() {
        return dao.list();
    }
}
