package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/customer/order/cancel")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId = request.getParameter("orderId");
        String reason = request.getParameter("reason");

        if (orderId != null && !orderId.trim().isEmpty()) {
            OrderDAO dao = new OrderDAO();
            // Perform security check - does this order belong to the current user?
            var orderSummary = dao.getOrderSummaryById(orderId);
            
            if (orderSummary != null && orderSummary.getUserId().equals(currentUser.getId())) {
                // Ensure order is actually pending and can be cancelled
                if ("pending".equalsIgnoreCase(orderSummary.getStatus())) {
                    boolean success = dao.updateOrderStatus(orderId, "cancelled");
                    if (success) {
                        System.out.println("Order " + orderId + " cancelled by user " + currentUser.getId() + ". Reason: " + reason);
                        session.setAttribute("successMessage", "Order cancelled successfully.");
                    } else {
                        session.setAttribute("errorMessage", "Failed to cancel order.");
                    }
                } else {
                    session.setAttribute("errorMessage", "Only pending orders can be cancelled.");
                }
            } else {
                session.setAttribute("errorMessage", "Invalid order.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/customer/order-details?id=" + orderId);
    }
}
