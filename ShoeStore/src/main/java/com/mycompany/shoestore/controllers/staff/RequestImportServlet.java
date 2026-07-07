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
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "RequestImportServlet", urlPatterns = {"/staff/create-import"})
public class RequestImportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        if (user == null || !"Staff".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ImportDAO importDAO = new ImportDAO();
        List<ImportDetailDTO> variants = importDAO.getAllVariantsForImport();
        request.setAttribute("variants", variants);
        request.getRequestDispatcher("/views/staff/form-request.jsp").forward(request, response);
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

        String supplier = request.getParameter("supplier");
        String[] variantIDs = request.getParameterValues("variantId[]");
        String[] quantities = request.getParameterValues("quantity[]");
        String[] prices = request.getParameterValues("unitPrice[]");

        // Validation
        if (supplier == null || supplier.trim().isEmpty()) {
            request.setAttribute("error", "Supplier name is required.");
            doGet(request, response);
            return;
        }

        if (variantIDs == null || variantIDs.length == 0) {
            request.setAttribute("error", "Please add at least one item to import.");
            doGet(request, response);
            return;
        }

        List<ImportDetailDTO> details = new ArrayList<>();
        BigDecimal totalAmount = BigDecimal.ZERO;
        BigDecimal minPrice = new BigDecimal("1000");

        try {
            for (int i = 0; i < variantIDs.length; i++) {
                if (variantIDs[i] == null || variantIDs[i].isEmpty()) continue;
                
                int qty = Integer.parseInt(quantities[i]);
                BigDecimal unitPrice = new BigDecimal(prices[i]);
                
                if (qty <= 0) throw new IllegalArgumentException("Quantity must be greater than 0");
                if (unitPrice.compareTo(minPrice) < 0) {
                    throw new IllegalArgumentException("Unit price must be at least 1,000đ");
                }

                ImportDetailDTO detail = new ImportDetailDTO();
                detail.setVariantID(variantIDs[i]);
                detail.setImportQuantity(qty);
                detail.setUnitPrice(unitPrice);
                details.add(detail);

                totalAmount = totalAmount.add(unitPrice.multiply(new BigDecimal(qty)));
            }
        } catch (Exception e) {
            request.setAttribute("error", "Invalid quantity or price: " + e.getMessage());
            doGet(request, response);
            return;
        }

        ImportDTO importDTO = new ImportDTO();
        importDTO.setSupplier(supplier);
        importDTO.setStaffID(user.getId());
        importDTO.setTotalAmount(totalAmount);
        importDTO.setNote(null);
        importDTO.setDetails(details);

        ImportDAO importDAO = new ImportDAO();
        if (importDAO.createImport(importDTO)) {
            response.sendRedirect(request.getContextPath() + "/staff/view-request?msg=success");
        } else {
            request.setAttribute("error", "System error: Could not save import request.");
            doGet(request, response);
        }
    }
}
