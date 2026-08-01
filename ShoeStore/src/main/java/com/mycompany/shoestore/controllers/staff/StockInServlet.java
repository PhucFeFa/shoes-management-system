package com.mycompany.shoestore.controllers.staff;

import com.mycompany.shoestore.dao.ImportDAO;
import com.mycompany.shoestore.dto.ImportDTO;
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
        if (importIDStr == null || importIDStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        try {
            int importID = Integer.parseInt(importIDStr);
            ImportDAO dao = new ImportDAO();
            ImportDTO importDTO = dao.getImportByID(importID);

            if (importDTO == null || !importDTO.getStaffID().equals(user.getId())) {
                response.sendRedirect(request.getContextPath() + "/staff/view-request");
                return;
            }

            if (!"ACCEPTED".equals(importDTO.getStatus())) {
                request.setAttribute("error", "Only ACCEPTED requests can be stocked in.");
                request.setAttribute("importDetail", importDTO);
                request.getRequestDispatcher("/views/staff/detail-request.jsp").forward(request, response);
                return;
            }

            if (dao.completeStockIn(importID)) {
                response.sendRedirect(request.getContextPath() + "/staff/view-request?msg=stockin_success");
            } else {
                request.setAttribute("error", "System error: Could not complete stock-in.");
                request.setAttribute("importDetail", importDTO);
                request.getRequestDispatcher("/views/staff/detail-request.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        }
    }
}
