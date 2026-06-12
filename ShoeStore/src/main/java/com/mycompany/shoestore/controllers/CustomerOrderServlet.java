// Author: baolgce191178
package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.models.Order;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/customer/orders")
public class CustomerOrderServlet extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        String statusFilter = request.getParameter("status");
        if (statusFilter == null) statusFilter = "";

        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) page = Integer.parseInt(pageParam);
        } catch (NumberFormatException ignored) {}

        String userId = (currentUser != null) ? currentUser.getId() : null;

        OrderDAO dao = new OrderDAO();
        List<Order> orders;
        int totalOrders;

        if (userId != null) {
            orders = dao.getOrdersByUser(userId, statusFilter, page);
            totalOrders = dao.countOrdersByUser(userId, statusFilter);
        } else {
            orders = new java.util.ArrayList<>();
            totalOrders = 0;
        }

        int totalPages = (int) Math.ceil((double) totalOrders / PAGE_SIZE);
        if (totalPages < 1) totalPages = 1;

        int startEntry = totalOrders == 0 ? 0 : (page - 1) * PAGE_SIZE + 1;
        int endEntry = Math.min(page * PAGE_SIZE, totalOrders);

        request.setAttribute("orders", orders);
        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("startEntry", startEntry);
        request.setAttribute("endEntry", endEntry);

        request.getRequestDispatcher("/views/customer/customer-orders.jsp").forward(request, response);
    }
}
