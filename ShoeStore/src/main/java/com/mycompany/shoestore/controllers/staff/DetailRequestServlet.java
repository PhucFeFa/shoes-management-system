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

            // Ensure staff can only view their own requests
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
        
        if ("report".equals(action) && importIDStr != null) {
            try {
                int importID = Integer.parseInt(importIDStr);
                String[] detailIDs = request.getParameterValues("detailIDs");
                String[] receivedQuantities = request.getParameterValues("receivedQuantities");

                if (detailIDs == null || receivedQuantities == null || detailIDs.length != receivedQuantities.length) {
                    request.setAttribute("error", "Invalid data submitted.");
                    doGet(request, response);
                    return;
                }

                ImportDAO dao = new ImportDAO();
                ImportDTO importDTO = dao.getImportByID(importID);

            
                if (importDTO == null || !"APPROVED".equals(importDTO.getStatus())) {
                    request.setAttribute("error", "Only APPROVED requests can be reported.");
                    doGet(request, response);
                    return;
                }

                for (int i = 0; i < receivedQuantities.length; i++) {
                    int received = Integer.parseInt(receivedQuantities[i]);
                
                    int originalQty = 0;
                    for (ImportDetailDTO d : importDTO.getDetails()) {
                        if (d.getImportDetailID() == Integer.parseInt(detailIDs[i])) {
                            originalQty = d.getImportQuantity();
                            break;
                        }
                    }
                    
                    if (received < 0) throw new IllegalArgumentException("Quantity cannot be negative.");
                    if (received > originalQty) throw new IllegalArgumentException("Received quantity cannot exceed requested quantity.");
                }

                if (dao.reportReceivedQuantities(importID, detailIDs, receivedQuantities)) {
                    response.sendRedirect(request.getContextPath() + "/staff/view-request?msg=report_success");
                } else {
                    request.setAttribute("error", "System error: Could not submit report.");
                    doGet(request, response);
                }
            } catch (Exception e) {
                request.setAttribute("error", "Error: " + e.getMessage());
                doGet(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/view-request");
        }
    }
}
