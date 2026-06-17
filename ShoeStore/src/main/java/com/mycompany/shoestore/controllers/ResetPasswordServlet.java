package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/reset-password"})
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        String email = (String) session.getAttribute("forgotEmail");
        
        if (otpVerified != null && otpVerified && email != null) {
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Boolean otpVerified = (Boolean) session.getAttribute("otpVerified");
        String email = (String) session.getAttribute("forgotEmail");

        if (otpVerified == null || !otpVerified || email == null) {
            response.sendRedirect(request.getContextPath() + "/forgot-password");
            return;
        }

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || !password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        boolean success = dao.updatePassword(email, password);

        if (success) {
            // Clean up session
            session.removeAttribute("forgotEmail");
            session.removeAttribute("forgotOtp");
            session.removeAttribute("forgotOtpTime");
            session.removeAttribute("otpVerified");

            // Redirect to login with success parameter
            response.sendRedirect(request.getContextPath() + "/login?message=Password reset successful. Please log in.");
        } else {
            request.setAttribute("error", "An error occurred while resetting your password. Please try again.");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        }
    }
}
