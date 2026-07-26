package com.mycompany.shoestore.controllers.staff;

import com.mycompany.shoestore.dao.ImportDAO;
import com.mycompany.shoestore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "StockInServlet", urlPatterns = {"/staff/stock-in"})
public class StockInServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Staff".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String importIDStr = request.getParameter("importID");
        if (importIDStr != null) {
            try {
                int importID = Integer.parseInt(importIDStr);
                ImportDAO dao = new ImportDAO();
                
         
                if (dao.completeStockIn(importID)) {
                    response.sendRedirect(request.getContextPath() + "/staff/view-request?msg=stockin_success");
                } else {
                    request.setAttribute("error", "System error: Could not complete stock-in.");
                    request.getRequestDispatcher("/staff/import-detail?id=" + importID).forward(request, response);
                }
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/staff/view-request");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        }
    }
}
