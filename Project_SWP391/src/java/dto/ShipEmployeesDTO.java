/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

/**
 *
 * @author hoang
 */
public class ShipEmployeesDTO {
    private String eCode,eName,eEmail,ePhone;
    private int eId;

    public ShipEmployeesDTO() {
    }

    public ShipEmployeesDTO(String eCode, String eName, String eEmail, String ePhone, int eId) {
        this.eCode = eCode;
        this.eName = eName;
        this.eEmail = eEmail;
        this.ePhone = ePhone;
        this.eId = eId;
    }

    public String geteCode() {
        return eCode;
    }

    public void seteCode(String eCode) {
        this.eCode = eCode;
    }

    public String geteName() {
        return eName;
    }

    public void seteName(String eName) {
        this.eName = eName;
    }

    public String geteEmail() {
        return eEmail;
    }

    public void seteEmail(String eEmail) {
        this.eEmail = eEmail;
    }

    public String getePhone() {
        return ePhone;
    }

    public void setePhone(String ePhone) {
        this.ePhone = ePhone;
    }

    public int geteId() {
        return eId;
    }

    public void seteId(int eId) {
        this.eId = eId;
    }
    
    
}
