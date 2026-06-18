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

@WebServlet("/staff/order-details")
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

        request.setAttribute("orderSummary", orderSummary);
        request.setAttribute("orderItems", orderItems);

        request.getRequestDispatcher("/views/staff/staff-order-details.jsp").forward(request, response);
    }
}
