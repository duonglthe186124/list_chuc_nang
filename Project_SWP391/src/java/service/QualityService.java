/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.QualityDAO;
import dto.QualityDTO;
import java.util.List;

public class QualityService {
    private final QualityDAO dao = new QualityDAO();

    public List<QualityDTO> getAll() {
        return dao.list();
    }
}
