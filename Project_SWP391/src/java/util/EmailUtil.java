package util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // **THAY THẾ BẰNG THÔNG TIN THẬT CỦA BẠN**
    private static final String SENDER_EMAIL = "rgfl7405@gmail.com"; // Email Gmail 
    private static final String APP_PASSWORD = "whel izyb njee iiov"; // Mật khẩu ứng dụng 

    public static boolean sendResetCode(String recipientEmail, String resetCode) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(SENDER_EMAIL));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            msg.setSubject("Your WMS Pro Password Reset Code");
            
            String emailContent = "<h1>Password Reset Request</h1>"
                                + "<p>Hi there,</p>"
                                + "<p>We received a request to reset your password. Use the 6-digit code below to proceed.</p>"
                                + "<h2 style='color: #000; font-size: 36px; letter-spacing: 2px;'>"
                                + "<strong>" + resetCode + "</strong>"
                                + "</h2>"
                                + "<p>This code will expire in 2 minutes.</p>"
                                + "<p>If you did not request this, please ignore this email.</p>";
            
            msg.setContent(emailContent, "text/html");

            Transport.send(msg);
            System.out.println("Reset email sent successfully to " + recipientEmail);
            return true;
        } catch (Exception e) {
            System.err.println("Failed to send reset email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}