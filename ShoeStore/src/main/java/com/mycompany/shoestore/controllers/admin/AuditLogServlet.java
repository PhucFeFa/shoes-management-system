// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.OrderStaffLogDAO;
import com.mycompany.shoestore.models.OrderStaffLog;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AuditLogServlet", urlPatterns = {"/admin/audit-log"})
public class AuditLogServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String searchQuery = request.getParameter("search");
        
        OrderStaffLogDAO dao = new OrderStaffLogDAO();
        List<OrderStaffLog> logs = dao.getLogs(searchQuery);
        
        int pageSize = 10;
        int totalLogs = logs.size();
        int totalPages = (int) Math.ceil((double) totalLogs / pageSize);
        if (totalPages < 1) totalPages = 1;
        
        int currentPage = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        if (currentPage > totalPages) currentPage = totalPages;
        if (currentPage < 1) currentPage = 1;
        
        int startIndex = (currentPage - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalLogs);
        List<OrderStaffLog> paginatedLogs = logs.subList(startIndex, endIndex);
        
        request.setAttribute("logs", paginatedLogs);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalLogs", totalLogs);
        request.setAttribute("rangeStart", totalLogs == 0 ? 0 : startIndex + 1);
        request.setAttribute("rangeEnd", endIndex);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/views/admin/audit-log.jsp").forward(request, response);
    }
}
