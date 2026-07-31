package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "CreateVoucherServlet", urlPatterns = {"/create-voucher"})
public class CreateVoucherServlet extends HttpServlet {

    private static final String VOUCHER_FORM_JSP = "/views/admin/voucher-form.jsp";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(VOUCHER_FORM_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String code           = request.getParameter("code");
        String discountStr    = request.getParameter("discountValue");
        String minOrderStr    = request.getParameter("minOrderAmount");
        String maxDiscountStr = request.getParameter("maxDiscountAmount");
        String startDateStr   = request.getParameter("startDate");
        String endDateStr     = request.getParameter("endDate");
        String quantityStr    = request.getParameter("quantity");

        String error = "";
        VoucherDAO dao = new VoucherDAO();

      
        if (isBlank(code) || isBlank(discountStr) || isBlank(minOrderStr)
                || isBlank(startDateStr) || isBlank(endDateStr) || isBlank(quantityStr)) {
            error = "All fields are required!";
        } else {

            BigDecimal discountValue    = null;
            BigDecimal minOrderAmount   = null;
            BigDecimal maxDiscountAmount = null;
            OffsetDateTime startDate    = null;
            OffsetDateTime endDate      = null;
            int quantity                = 0;

            
            try { discountValue = new BigDecimal(discountStr.trim()); }
            catch (Exception e) { error = "Discount percentage is not a valid number!"; }

            // Parse minOrder
            if (error.isEmpty()) {
                try { minOrderAmount = new BigDecimal(minOrderStr.trim()); }
                catch (Exception e) { error = "Min order amount is not a valid number!"; }
            }

            // Parse maxDiscount (tuỳ chọn)
            if (error.isEmpty() && !isBlank(maxDiscountStr)) {
                try { maxDiscountAmount = new BigDecimal(maxDiscountStr.trim()); }
                catch (Exception e) { error = "Max discount amount is not a valid number!"; }
            }

        
            if (error.isEmpty()) {
                try {
                    BigDecimal qtyDecimal = new BigDecimal(quantityStr.trim());
                    if (qtyDecimal.scale() > 0 && qtyDecimal.stripTrailingZeros().scale() > 0) {
                        error = "Quantity must be a whole number!";
                    } else {
                        quantity = qtyDecimal.intValueExact();
                    }
                } catch (ArithmeticException ae) {
                    error = "Quantity must be a whole number!";
                } catch (Exception e) {
                    error = "Quantity is not a valid number!";
                }
            }

            // Parse dates
            if (error.isEmpty()) {
                try { startDate = LocalDateTime.parse(startDateStr, FORMATTER).atOffset(OffsetDateTime.now().getOffset()); }
                catch (Exception e) { error = "Start date format is invalid!"; }
            }
            if (error.isEmpty()) {
                try { endDate = LocalDateTime.parse(endDateStr, FORMATTER).atOffset(OffsetDateTime.now().getOffset()); }
                catch (Exception e) { error = "End date format is invalid!"; }
            }

          
            if (error.isEmpty()) {
                code = code.trim().toUpperCase();
                if (code.length() < 6) {
                    error = "Voucher code must be at least 6 characters long!";
                } else if (dao.isCodeExist(code)) {
                    error = "Voucher code already exists!";
                } else if (discountValue.compareTo(BigDecimal.ZERO) <= 0 || discountValue.compareTo(new BigDecimal("100")) > 0) {
                    error = "Discount percentage must be between 0.1% and 100%!";
                } else if (minOrderAmount.compareTo(BigDecimal.ZERO) < 0) {
                    error = "Minimum order amount cannot be negative!";
                } else if (maxDiscountAmount != null && maxDiscountAmount.compareTo(BigDecimal.ZERO) < 0) {
                    error = "Max discount amount cannot be negative!";
                } else if (maxDiscountAmount != null && minOrderAmount.compareTo(maxDiscountAmount) > 0) {
                    error = "Minimum order amount cannot be greater than maximum discount amount!";
                } else if (quantity <= 0) {
                    error = "Quantity must be greater than 0!";
                } else if (!endDate.isAfter(startDate)) {
                    error = "End date must be after start date!";
                }
            }

            // ── 4. Lưu DB ─────────────────────────────────────────────────
            if (error.isEmpty()) {
                VoucherDTO newVoucher = new VoucherDTO();
                newVoucher.setCode(code);
                newVoucher.setDiscountValue(discountValue);
                newVoucher.setMinOrderAmount(minOrderAmount);
                newVoucher.setMaxDiscountAmount(maxDiscountAmount);
                newVoucher.setStartDate(startDate);
                newVoucher.setEndDate(endDate);
                newVoucher.setQuantity(quantity);

                try {
                    boolean success = dao.createVoucher(newVoucher);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/manage-voucher");
                        return;
                    } else {
                        error = "System error. Failed to save voucher!";
                    }
                } catch (Exception dbEx) {
                    dbEx.printStackTrace();
                    error = "Database error: " + dbEx.getMessage();
                }
            }
        }

      
        request.setAttribute("ERROR", error);
        request.setAttribute("oldCode",  code);
        request.setAttribute("oldValue", discountStr);
        request.setAttribute("oldMin",   minOrderStr);
        request.setAttribute("oldMax",   maxDiscountStr);
        request.setAttribute("oldStart", startDateStr);
        request.setAttribute("oldEnd",   endDateStr);
        request.setAttribute("oldQty",   quantityStr);
        request.getRequestDispatcher(VOUCHER_FORM_JSP).forward(request, response);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
