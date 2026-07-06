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
        
        request.setAttribute("logs", logs);
        request.setAttribute("searchQuery", searchQuery);
        request.getRequestDispatcher("/views/admin/audit-log.jsp").forward(request, response);
    }
}
