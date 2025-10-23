package dto;

import java.util.Date;

/**
 *
 * @author ASUS
 */
public class SerialTransactionResponseDTO {

    private String imei, serial_number;
    private Date warranty_start, warranty_end;

    public SerialTransactionResponseDTO(String imei, String serial_number, Date warranty_start, Date warranty_end) {
        this.imei = imei;
        this.serial_number = serial_number;
        this.warranty_start = warranty_start;
        this.warranty_end = warranty_end;
    }

    public SerialTransactionResponseDTO() {
    }

    public String getImei() {
        return imei;
    }

    public void setImei(String imei) {
        this.imei = imei;
    }

    public String getSerial_number() {
        return serial_number;
    }

    public void setSerial_number(String serial_number) {
        this.serial_number = serial_number;
    }

    public Date getWarranty_start() {
        return warranty_start;
    }

    public void setWarranty_start(Date warranty_start) {
        this.warranty_start = warranty_start;
    }

    public Date getWarranty_end() {
        return warranty_end;
    }

    public void setWarranty_end(Date warranty_end) {
        this.warranty_end = warranty_end;
    }

}
