package com.mycompany.shoestore.controllers.staff;

import com.mycompany.shoestore.dao.ImportDAO;
import com.mycompany.shoestore.dto.ImportDTO;
import com.mycompany.shoestore.dto.ImportDetailDTO;
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
            idParam = request.getParameter("importID");
        }

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        try {
            int importID = Integer.parseInt(idParam);
            renderDetailPage(request, response, importID, user);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Staff".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String importIDStr = request.getParameter("importID");

        if (!"report".equals(action) || importIDStr == null || importIDStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        int importID;
        try {
            importID = Integer.parseInt(importIDStr);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        ImportDAO dao = new ImportDAO();
        ImportDTO importDTO = dao.getImportByID(importID);

        if (importDTO == null || !importDTO.getStaffID().equals(user.getId())) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        if (!"APPROVED".equals(importDTO.getStatus())) {
            request.setAttribute("error", "Only APPROVED requests can be reported.");
            renderDetailPage(request, response, importID, user);
            return;
        }

        String[] detailIDs = request.getParameterValues("detailIDs");
        String[] receivedQuantities = request.getParameterValues("receivedQuantities");

        if (detailIDs == null || receivedQuantities == null || detailIDs.length != receivedQuantities.length) {
            request.setAttribute("error", "Invalid data submitted.");
            renderDetailPage(request, response, importID, user);
            return;
        }

        int[] detailIdInts = new int[detailIDs.length];
        int[] receivedQtyInts = new int[receivedQuantities.length];

        for (int i = 0; i < detailIDs.length; i++) {
            try {
                int detailID = Integer.parseInt(detailIDs[i]);
                int received = Integer.parseInt(receivedQuantities[i]);

                int originalQty = -1;
                for (ImportDetailDTO d : importDTO.getDetails()) {
                    if (d.getImportDetailID() == detailID) {
                        originalQty = d.getImportQuantity();
                        break;
                    }
                }

                if (originalQty == -1 || received < 0 || received > originalQty) {
                    request.setAttribute("error", "Please enter valid quantities (0 to requested amount).");
                    renderDetailPage(request, response, importID, user);
                    return;
                }

                detailIdInts[i] = detailID;
                receivedQtyInts[i] = received;
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Please enter valid quantities (0 to requested amount).");
                renderDetailPage(request, response, importID, user);
                return;
            }
        }

        if (dao.reportReceivedQuantities(importID, detailIdInts, receivedQtyInts)) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request?msg=report_success");
        } else {
            request.setAttribute("error", "System error: Could not submit report.");
            renderDetailPage(request, response, importID, user);
        }
    }

    private void renderDetailPage(HttpServletRequest request, HttpServletResponse response, int importID, User user)
            throws ServletException, IOException {
        ImportDAO importDAO = new ImportDAO();
        ImportDTO importDetail = importDAO.getImportByID(importID);

        if (importDetail == null || !importDetail.getStaffID().equals(user.getId())) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
            return;
        }

        request.setAttribute("importDetail", importDetail);
        request.getRequestDispatcher("/views/staff/detail-request.jsp").forward(request, response);
    }
}
