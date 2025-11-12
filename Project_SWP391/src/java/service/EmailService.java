package service;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;
import jakarta.mail.internet.MimeUtility;
import jakarta.servlet.http.HttpServletRequest;

/**
 *
 * @author ASUS
 */
public class EmailService {

    // THAY THẾ CẤU HÌNH NÀY BẰNG THÔNG TIN SMTP CỦA BẠN (Dùng App Password nếu là Gmail)
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SENDER_EMAIL = "your-email@example.com";
    private static final String SENDER_PASSWORD = "your-app-password";

    public static void sendPurchaseOrderEmail(String recipientEmail, String poCode, String externalViewLink, HttpServletRequest request, int poId) throws MessagingException {

        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("nguyentiendat772005@gmail.com", "vemc wusy pmbt wuel");
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SENDER_EMAIL));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("Phiếu Mua Hàng Mới - Mã: " + poCode + " - Yêu cầu Xác nhận");

        String emailContent
                = "<p style='font-family: Arial, sans-serif;'>Kính gửi Nhà cung cấp,</p>"
                + "<p style='font-family: Arial, sans-serif;'>Chúng tôi đã tạo một Phiếu Mua Hàng mới có mã số: <strong>" + poCode + "</strong>. Vui lòng xem chi tiết đơn hàng và xác nhận.</p>"
                + "<div style='margin-top: 20px; text-align: center;'>"
                + "<a href=\"" + externalViewLink + "\" "
                + "style=\"background-color: #4F46E5; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; font-weight: bold; display: inline-block;\">"
                + "XEM ĐƠN HÀNG VÀ XÁC NHẬN"
                + "</a></div>"
                + "<p style='font-family: Arial, sans-serif; margin-top: 20px;'>Trân trọng,</p>"
                + "<p style='font-family: Arial, sans-serif;'>Đội ngũ WMS Pro</p>";

        message.setContent(emailContent, "text/html; charset=utf-8");

        Transport.send(message);
    }
}
