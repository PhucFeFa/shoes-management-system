package com.mycompany.shoestore.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class EmailUtil {

    private static final String SENDER_EMAIL = "shopbando3112@gmail.com";
    private static final String APP_PASSWORD = "ogsy kpmi wprb dgwl"; // 16-char app password

    public static String generateOTP() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static boolean sendOTPEmail(String recipientEmail, String otpCode) {
        Properties properties = new Properties();
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("SOLE_LAB - Your Registration OTP");
            
            String htmlContent = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>"
                    + "<h2 style='color: #000;'>SOLE_LAB Account Registration</h2>"
                    + "<p>Please use the following 6-digit OTP code to verify your email address:</p>"
                    + "<h1 style='background: #f4f4f4; padding: 10px; text-align: center; letter-spacing: 5px; color: #000;'>" + otpCode + "</h1>"
                    + "<p>This code will expire in 5 minutes.</p>"
                    + "<p>If you did not request this code, please ignore this email.</p>"
                    + "</div>";
            
            message.setContent(htmlContent, "text/html; charset=utf-8");
            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
