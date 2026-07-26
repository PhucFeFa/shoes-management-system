package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.UserDAO;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "VerifyOTPServlet", urlPatterns = {"/verify-otp"})
public class VerifyOTPServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String inputOtp = request.getParameter("otp");
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("pendingUser") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        String sessionOtp = (String) session.getAttribute("otpCode");
        Long expiry = (Long) session.getAttribute("otpExpiry");

        if (expiry != null && System.currentTimeMillis() > expiry) {
            request.setAttribute("error", "OTP has expired. Please register again.");
            session.removeAttribute("pendingUser");
            session.removeAttribute("otpCode");
            session.removeAttribute("otpExpiry");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (sessionOtp != null && sessionOtp.equals(inputOtp)) {
            User pendingUser = (User) session.getAttribute("pendingUser");
            UserDAO userDAO = new UserDAO();
            boolean success = userDAO.registerUser(pendingUser);

            if (success) {
                session.removeAttribute("pendingUser");
                session.removeAttribute("otpCode");
                session.removeAttribute("otpExpiry");
                // Set success message for login page
                session.setAttribute("successMessage", "Registration successful! Please login.");
                response.sendRedirect(request.getContextPath() + "/login");
            } else {
                request.setAttribute("error", "Database error. Registration failed.");
                request.setAttribute("showOTP", true);
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Invalid OTP code. Please try again.");
            request.setAttribute("showOTP", true);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
