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

@WebServlet(name = "ChangePasswordServlet", urlPatterns = {"/profile/change-password"})
public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (oldPassword == null || oldPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            session.setAttribute("profileErrorMessage", "All fields are required.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("profileErrorMessage", "New password and confirmation do not match.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        if (newPassword.startsWith(" ") || newPassword.endsWith(" ")) {
            session.setAttribute("profileErrorMessage", "New password cannot start or end with a space.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        if (newPassword.equals(oldPassword)) {
            session.setAttribute("profileErrorMessage", "New password cannot be the same as your current password.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        if (newPassword.length() < 6) {
            session.setAttribute("profileErrorMessage", "New password must be at least 6 characters long.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        if (!newPassword.matches(".*[A-Z].*") || !newPassword.matches(".*\\d.*")) {
            session.setAttribute("profileErrorMessage", "New password must contain at least one uppercase letter and one number.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        UserDAO userDAO = new UserDAO();
        User verifyUser = userDAO.login(currentUser.getEmail(), oldPassword);
        if (verifyUser == null) {
            session.setAttribute("profileErrorMessage", "Incorrect old password.");
            response.sendRedirect(request.getContextPath() + "/profile");
            return;
        }

        // Update password
        boolean isUpdated = userDAO.updatePassword(currentUser.getEmail(), newPassword);
        if (isUpdated) {
            session.setAttribute("profileSuccessMessage", "Password changed successfully.");
            currentUser.setPasswordHash(org.mindrot.jbcrypt.BCrypt.hashpw(newPassword, org.mindrot.jbcrypt.BCrypt.gensalt()));
            session.setAttribute("currentUser", currentUser);
        } else {
            session.setAttribute("profileErrorMessage", "Failed to change password. Please try again.");
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }
}
