package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.UserDAO;
import com.mycompany.shoestore.util.EmailUtil;
import java.io.IOException;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ForgotPasswordServlet", urlPatterns = {"/forgot-password"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        UserDAO dao = new UserDAO();

        if (!dao.isEmailExists(email)) {
            request.setAttribute("error", "Email address not found.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate OTP
        String otpCode = String.format("%06d", new Random().nextInt(999999));
        
        // Save in session
        HttpSession session = request.getSession();
        session.setAttribute("forgotEmail", email);
        session.setAttribute("forgotOtp", otpCode);
        session.setAttribute("forgotOtpTime", System.currentTimeMillis());

        // Send Email
        boolean sent = EmailUtil.sendOTPEmail(email, otpCode);
        if (sent) {
            request.setAttribute("showOTP", true);
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to send OTP email. Please try again later.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }
}
