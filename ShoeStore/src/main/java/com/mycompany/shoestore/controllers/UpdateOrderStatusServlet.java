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

@WebServlet("/staff/order/update-status")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null || (!"Admin".equalsIgnoreCase(currentUser.getRoleName()) && !"Staff".equalsIgnoreCase(currentUser.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        String reason = request.getParameter("reason"); // For cancelled status

        if (orderId != null && !orderId.trim().isEmpty() && status != null && !status.trim().isEmpty()) {
            OrderDAO dao = new OrderDAO();
            boolean success = false;
            
            if ("cancelled".equalsIgnoreCase(status)) {
                success = dao.cancelOrderWithStockRestore(orderId);
                if (success) {
                    System.out.println("Order " + orderId + " cancelled by Admin/Staff " + currentUser.getId() + ". Reason: " + reason);
                }
            } else {
                success = dao.updateOrderStatus(orderId, status);
            }
            
            if (success) {
                session.setAttribute("successMessage", "Order status updated successfully.");
            } else {
                session.setAttribute("errorMessage", "Failed to update order status.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/staff/order-details?id=" + orderId);
    }
}
