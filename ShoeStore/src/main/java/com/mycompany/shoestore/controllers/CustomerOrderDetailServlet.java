package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.dto.OrderDetailDTO;
import com.mycompany.shoestore.dto.OrderSummaryDTO;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/profile/order/details")
public class CustomerOrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String orderId = request.getParameter("id");
        if (orderId == null || orderId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/profile/orders");
            return;
        }

        OrderDAO dao = new OrderDAO();
        OrderSummaryDTO orderSummary = dao.getOrderSummaryById(orderId);

        // Security check: ensure the order belongs to the current user
        if (orderSummary == null || !orderSummary.getUserId().equals(currentUser.getId())) {
            response.sendRedirect(request.getContextPath() + "/profile/orders");
            return;
        }

        List<OrderDetailDTO> orderItems = dao.getOrderItemsByOrderId(orderId);
        int cancellationCount = dao.getCustomerCancellationCountLast30Days(currentUser.getId());

        request.setAttribute("orderSummary", orderSummary);
        request.setAttribute("orderItems", orderItems);
        request.setAttribute("cancellationCount", cancellationCount);

        request.getRequestDispatcher("/views/customer/customer-order-details.jsp").forward(request, response);
    }
}
