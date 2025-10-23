/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.AuditDAO;
import dto.AuditDTO;
import java.util.List;

public class AuditService {
    private final AuditDAO dao = new AuditDAO();

    public List<AuditDTO> getAll() {
        return dao.list();
    }
}
