/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dal.FilterDAO;
import dto.FilterDTO;
import java.util.List;

public class FilterService {
    private final FilterDAO dao = new FilterDAO();

    public List<FilterDTO> filterBy(String employee, String type) {
        return dao.filter(employee, type);
    }
}
