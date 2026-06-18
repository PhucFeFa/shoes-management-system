package com.mycompany.shoestore.controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "VerifyForgotOTPServlet", urlPatterns = {"/verify-forgot-otp"})
public class VerifyForgotOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        
        String savedOtp = (String) session.getAttribute("forgotOtp");
        Long otpTime = (Long) session.getAttribute("forgotOtpTime");
        String email = (String) session.getAttribute("forgotEmail");

        if (savedOtp == null || otpTime == null || email == null) {
            request.setAttribute("error", "Session expired. Please request a new OTP.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        long currentTime = System.currentTimeMillis();
        long fiveMinutesInMillis = 5 * 60 * 1000;

        if (currentTime - otpTime > fiveMinutesInMillis) {
            session.removeAttribute("forgotOtp");
            session.removeAttribute("forgotOtpTime");
            request.setAttribute("error", "OTP has expired. Please request a new one.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        if (enteredOtp != null && enteredOtp.equals(savedOtp)) {
            // Valid OTP
            session.setAttribute("otpVerified", true);
            response.sendRedirect(request.getContextPath() + "/reset-password");
        } else {
            // Invalid OTP
            request.setAttribute("error", "Invalid OTP code.");
            request.setAttribute("showOTP", true);
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
        }
    }
}
