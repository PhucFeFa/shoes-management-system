// Author: PhucLHCE191132
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

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Render login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and Password cannot be empty or just spaces.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email, password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            try {
                com.mycompany.shoestore.dao.CartDAO cartDao = new com.mycompany.shoestore.dao.CartDAO();
                int totalItems = cartDao.getCartTotalQuantity(user.getId().toString());
                session.setAttribute("cartCount", totalItems);
            } catch (Exception e) {
                session.setAttribute("cartCount", 0);
            }

            // Phân quyền điều hướng 
            String roleName = user.getRoleName();
            if ("Admin".equalsIgnoreCase(roleName)) {
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else if ("Staff".equalsIgnoreCase(roleName)) {
                response.sendRedirect(request.getContextPath() + "/import");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}
