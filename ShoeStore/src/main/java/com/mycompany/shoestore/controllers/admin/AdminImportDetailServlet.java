// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

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

@WebServlet(name = "AdminImportDetailServlet", urlPatterns = {"/admin/import-detail"})
public class AdminImportDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Admin".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/import"); // Assuming /import lists all imports
            return;
        }

        try {
            int importID = Integer.parseInt(idParam);
            ImportDAO importDAO = new ImportDAO();
            ImportDTO importDetail = importDAO.getImportByID(importID);

            if (importDetail == null) {
                response.sendRedirect(request.getContextPath() + "/import");
                return;
            }

            request.setAttribute("importDetail", importDetail);
            request.getRequestDispatcher("/views/admin/import-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/import");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Admin".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        String action = request.getParameter("action"); // "approve" or "cancel"
        String note = request.getParameter("note");

        if (idParam == null || idParam.isEmpty() || action == null || action.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/import");
            return;
        }

        if ("cancel".equalsIgnoreCase(action) && (note == null || note.trim().isEmpty())) {
            request.setAttribute("error", "Admin Note is strictly required when rejecting a request.");
            doGet(request, response);
            return;
        }

        try {
            int importID = Integer.parseInt(idParam);
            String status = "REQUESTING"; // fallback
            
            if ("approve".equalsIgnoreCase(action)) {
                status = "APPROVED";
            } else if ("accept".equalsIgnoreCase(action)) {
                status = "ACCEPTED";
            } else if ("cancel".equalsIgnoreCase(action)) {
                status = "CANCELLED";
            }

            ImportDAO importDAO = new ImportDAO();
            boolean success = importDAO.updateImportStatus(importID, status, note);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/import?msg=success");
            } else {
                request.setAttribute("error", "Update failed.");
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/import");
        }
    }
}
