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

@WebServlet(name = "DetailRequestServlet", urlPatterns = {"/staff/import-detail"})
public class DetailRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Staff".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        try {
            int importID = Integer.parseInt(idParam);
            ImportDAO importDAO = new ImportDAO();
            ImportDTO importDetail = importDAO.getImportByID(importID);

            if (importDetail == null) {
                response.sendRedirect(request.getContextPath() + "/staff/view-request");
                return;
            }

            // Ensure staff can only view their own requests (optional but good practice)
            if (!importDetail.getStaffID().equals(user.getId())) {
                response.sendRedirect(request.getContextPath() + "/staff/view-request");
                return;
            }

            request.setAttribute("importDetail", importDetail);
            request.getRequestDispatcher("/views/staff/detail-request.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        }
    }
}
