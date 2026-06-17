package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.UserDAO;
import com.mycompany.shoestore.models.User;
import com.mycompany.shoestore.util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Generate OTP
        String otpCode = EmailUtil.generateOTP();
        boolean emailSent = EmailUtil.sendOTPEmail(email, otpCode);

        if (emailSent) {
            User pendingUser = new User();
            pendingUser.setFullName(fullName);
            pendingUser.setEmail(email);
            pendingUser.setPasswordHash(password); // In a real app, hash this!

            HttpSession session = request.getSession();
            session.setAttribute("pendingUser", pendingUser);
            session.setAttribute("otpCode", otpCode);
            session.setAttribute("otpExpiry", System.currentTimeMillis() + (5 * 60 * 1000)); // 5 mins

            request.setAttribute("showOTP", true);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to send OTP email. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
