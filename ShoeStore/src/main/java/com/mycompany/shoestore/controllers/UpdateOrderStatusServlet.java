package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.dao.OrderStaffLogDAO;
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

        if (currentUser == null || (!"Admin".equalsIgnoreCase(currentUser.getRoleName())
                && !"Staff".equalsIgnoreCase(currentUser.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");
        String reason = request.getParameter("reason"); // For cancelled status

        if (orderId != null && !orderId.trim().isEmpty() && status != null && !status.trim().isEmpty()) {
            OrderDAO dao = new OrderDAO();
            var summary = dao.getOrderSummaryById(orderId);
            boolean success = false;

            if (summary != null) {
                String curStatus = summary.getStatus().toLowerCase();
                boolean validTransition = false;

                if ("cancelled".equalsIgnoreCase(status)) {
                    if (!"completed".equals(curStatus) && !"cancelled".equals(curStatus)) {
                        validTransition = true;
                    }
                } else if ("pending".equals(curStatus) && "confirmed".equalsIgnoreCase(status)) {
                    validTransition = true;
                } else if ("confirmed".equals(curStatus) && "shipping".equalsIgnoreCase(status)) {
                    validTransition = true;
                } else if ("shipping".equals(curStatus)
                        && ("completed".equalsIgnoreCase(status) || "delivered".equalsIgnoreCase(status))) {
                    validTransition = true;
                }

                if (validTransition) {
                    if ("confirmed".equalsIgnoreCase(status) && "pending".equalsIgnoreCase(curStatus)) {
                        com.mycompany.shoestore.dao.ProductVariantDAO variantDAO = new com.mycompany.shoestore.dao.ProductVariantDAO();
                        var items = dao.getOrderItemsByOrderId(orderId);
                        boolean hasStock = true;
                        try {
                            for (var item : items) {
                                var variant = variantDAO.getVariantById(item.getProductVariantId());
                                if (variant == null || variant.getStockQuantity() < item.getQuantity()) {
                                    hasStock = false;
                                    break;
                                }
                            }
                            if (hasStock) {
                                success = dao.updateOrderStatus(orderId, status);
                                if (success) {
                                    for (var item : items) {
                                        variantDAO.updateProductStock(item.getProductVariantId(), item.getQuantity());
                                    }
                                }
                            } else {
                                session.setAttribute("errorMessage", "Not enough stock to confirm this order.");
                                success = false;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            success = false;
                        }
                    } else if ("cancelled".equalsIgnoreCase(status)) {
                        success = dao.cancelOrderWithStockRestore(orderId);
                        if (success) {
                            System.out.println("Order " + orderId + " cancelled by Admin/Staff " + currentUser.getId()
                                    + ". Reason: " + reason);
                        }
                    } else {
                        success = dao.updateOrderStatus(orderId, status);
                    }

                    if (success) {
                        if ("Staff".equalsIgnoreCase(currentUser.getRoleName())) {
                            OrderStaffLogDAO logDAO = new OrderStaffLogDAO();
                            logDAO.insertLog(orderId, currentUser.getId(), "Updated status to " + status
                                    + (reason != null ? " (Reason: " + reason + ")" : ""));
                        }
                        session.setAttribute("successMessage", "Order status updated successfully.");
                    } else {
                        session.setAttribute("errorMessage", "Failed to update order status.");
                    }
                } else {
                    session.setAttribute("errorMessage", "Invalid status transition.");
                }
            } else {
                session.setAttribute("errorMessage", "Order not found.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/staff/order/details?id=" + orderId);
    }
}
