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
    
    public static void sendNewStaffAccountEmail(String toEmail, String defaultPassword) {
    
        final String fromEmail = "rgfl7405@gmail.com"; 
        final String password = "whel izyb njee iiov"; // Mật khẩu ứng dụng

        // Cấu hình properties (giống hệt hàm sendResetCode)
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Welcome to WMS Pro - Your Account Details"); // Tiêu đề email

            // Nội dung email
            String emailBody = "Hello,\n\n"
                             + "An account has been created for you on the WMS Pro system.\n\n"
                             + "Your login email: " + toEmail + "\n"
                             + "Your default password is: " + defaultPassword + "\n\n"
                             + "Please log in using this password and change it at your earliest convenience.\n\n"
                             + "Thank you,\n"
                             + "WMS Pro Administrator";

            msg.setText(emailBody);
            Transport.send(msg);
            System.out.println("New account email sent successfully to " + toEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
