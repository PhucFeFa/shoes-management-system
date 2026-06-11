// Author: baolgce191178
package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.models.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Servlet for Staff Order List.
 * URL: /staff/orders
 * Access: staff and admin roles only (enforced by AuthFilter).
 */
@WebServlet(name = "StaffOrderServlet", urlPatterns = {"/staff/orders"})
public class StaffOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read filter & pagination params from query string
        String statusFilter = request.getParameter("status");
        String keyword      = request.getParameter("keyword");
        String pageParam    = request.getParameter("page");

        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        OrderDAO orderDAO = new OrderDAO();
        int pageSize   = orderDAO.getPageSize();
        int totalOrders = orderDAO.countAllOrders(statusFilter, keyword);
        int totalPages  = (int) Math.ceil((double) totalOrders / pageSize);
        if (totalPages < 1) totalPages = 1;
        if (currentPage > totalPages) currentPage = totalPages;

        List<Order> orders = orderDAO.getAllOrders(statusFilter, keyword, currentPage);

        // Calculate display range (e.g., "Showing 1-10 of 42 Orders")
        int rangeStart = totalOrders == 0 ? 0 : (currentPage - 1) * pageSize + 1;
        int rangeEnd   = Math.min(currentPage * pageSize, totalOrders);

        // Pass data to View
        request.setAttribute("orders",       orders);
        request.setAttribute("totalOrders",  totalOrders);
        request.setAttribute("totalPages",   totalPages);
        request.setAttribute("currentPage",  currentPage);
        request.setAttribute("rangeStart",   rangeStart);
        request.setAttribute("rangeEnd",     rangeEnd);
        request.setAttribute("statusFilter", statusFilter != null ? statusFilter : "");
        request.setAttribute("keyword",      keyword      != null ? keyword      : "");

        request.getRequestDispatcher("/views/staff/staff-orders.jsp").forward(request, response);
    }
}
