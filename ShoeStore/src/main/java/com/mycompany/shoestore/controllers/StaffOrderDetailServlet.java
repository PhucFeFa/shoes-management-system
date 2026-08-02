package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.dto.OrderDetailDTO;
import com.mycompany.shoestore.dto.OrderSummaryDTO;
import com.mycompany.shoestore.models.User;
import com.mycompany.shoestore.dao.ProductVariantDAO;
import com.mycompany.shoestore.models.ProductVariant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/staff/order/details")
public class StaffOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null || (!"Admin".equalsIgnoreCase(currentUser.getRoleName()) && !"Staff".equalsIgnoreCase(currentUser.getRoleName()))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId = request.getParameter("id");
        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/orders");
            return;
        }

        OrderDAO dao = new OrderDAO();
        OrderSummaryDTO orderSummary = dao.getOrderSummaryById(orderId);

        if (orderSummary == null) {
            response.sendRedirect(request.getContextPath() + "/staff/orders");
            return;
        }

        List<OrderDetailDTO> orderItems = dao.getOrderItemsByOrderId(orderId);

        if (orderSummary.getVoucherId() != null && !orderSummary.getVoucherId().isEmpty()) {
            try {
                com.mycompany.shoestore.dao.VoucherDAO voucherDAO = new com.mycompany.shoestore.dao.VoucherDAO();
                com.mycompany.shoestore.dto.VoucherDTO appliedVoucher = voucherDAO.getVoucherDTOById(orderSummary.getVoucherId());
                request.setAttribute("appliedVoucher", appliedVoucher);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        boolean hasBackorderItems = false;
        if ("PENDING".equalsIgnoreCase(orderSummary.getStatus())) {
            ProductVariantDAO variantDAO = new ProductVariantDAO();
            for (OrderDetailDTO item : orderItems) {
                try {
                    ProductVariant variant = variantDAO.getVariantById(item.getProductVariantId());
                    if (variant != null && item.getQuantity() > variant.getStockQuantity()) {
                        hasBackorderItems = true;
                        break;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        
        request.setAttribute("orderSummary", orderSummary);
        request.setAttribute("orderItems", orderItems);
        request.setAttribute("hasBackorderItems", hasBackorderItems);

        request.getRequestDispatcher("/views/staff/staff-order-details.jsp").forward(request, response);
    }
}
