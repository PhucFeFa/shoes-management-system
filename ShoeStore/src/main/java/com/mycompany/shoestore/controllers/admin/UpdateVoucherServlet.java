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

@WebServlet(name = "UpdateVoucherServlet", urlPatterns = {"/manage-voucher/edit"})
public class UpdateVoucherServlet extends HttpServlet {

    private static final String UPDATE_FORM_JSP = "/views/admin/update-voucher.jsp";
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        
        if (id == null || id.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/manage-voucher");
            return;
        }

        VoucherDAO voucherDAO = new VoucherDAO();
        VoucherDTO voucher = voucherDAO.getVoucherDTOById(id);

        if (voucher == null) {
            response.sendRedirect(request.getContextPath() + "/manage-voucher");
            return;
        }

        // Định dạng ngày giờ để hiển thị khớp thẻ input datetime-local (yyyy-MM-ddTHH:mm)
        String formattedStart = voucher.getStartDate() != null ? voucher.getStartDate().format(FORMATTER) : "";
        String formattedEnd = voucher.getEndDate() != null ? voucher.getEndDate().format(FORMATTER) : "";

        request.setAttribute("voucher", voucher);
        request.setAttribute("formattedStart", formattedStart);
        request.setAttribute("formattedEnd", formattedEnd);

        request.getRequestDispatcher(UPDATE_FORM_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id             = request.getParameter("id");
        String code           = request.getParameter("code");
        String discountStr    = request.getParameter("discountValue");
        String minOrderStr    = request.getParameter("minOrderAmount");
        String maxDiscountStr = request.getParameter("maxDiscountAmount");
        String startDateStr   = request.getParameter("startDate");
        String endDateStr     = request.getParameter("endDate");
        String quantityStr    = request.getParameter("quantity");

        String error = "";
        VoucherDAO dao = new VoucherDAO();

 
        if (isBlank(id) || isBlank(code) || isBlank(discountStr) || isBlank(minOrderStr)
                || isBlank(startDateStr) || isBlank(endDateStr) || isBlank(quantityStr)) {
            error = "All fields are required!";
        } else {
   
            BigDecimal discountValue    = null;
            BigDecimal minOrderAmount   = null;
            BigDecimal maxDiscountAmount = null;
            OffsetDateTime startDate    = null;
            OffsetDateTime endDate      = null;
            int quantity                = 0;

            try { 
                discountValue = new BigDecimal(discountStr.trim()); 
                if (discountValue.scale() > 0 && discountValue.stripTrailingZeros().scale() > 0) {
                    error = "Discount percentage must be an integer number (no decimals)!";
                }
            } catch (Exception e) { 
                error = "Discount percentage is not a valid number!"; 
            }

            // Parse minOrder
            if (error.isEmpty()) {
                try { minOrderAmount = new BigDecimal(minOrderStr.trim()); }
                catch (Exception e) { error = "Min order amount is not a valid number!"; }
            }

          
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
                try { startDate = LocalDateTime.parse(startDateStr, FORMATTER).atOffset(java.time.ZoneOffset.ofHours(7)); }
                catch (Exception e) { error = "Start date format is invalid!"; }
            }
            if (error.isEmpty()) {
                try { endDate = LocalDateTime.parse(endDateStr, FORMATTER).atOffset(java.time.ZoneOffset.ofHours(7)); }
                catch (Exception e) { error = "End date format is invalid!"; }
            }

            // ── 3. Validate logic ──────────────────────────────────────────
            if (error.isEmpty()) {
                code = code.trim().toUpperCase();
                if (code.length() < 6) {
                    error = "Voucher code must be at least 6 characters long!";
                } else if (dao.isCodeExistForUpdate(code, id)) {
                    error = "Voucher code already exists!";
                } else if (discountValue.compareTo(BigDecimal.ONE) < 0 || discountValue.compareTo(new BigDecimal("100")) > 0) {
                    error = "Discount percentage must be between 1% and 100%!";
                } else if (minOrderAmount.compareTo(BigDecimal.ZERO) < 0) {
                    error = "Minimum order amount cannot be negative!";
                } else if (maxDiscountAmount != null && maxDiscountAmount.compareTo(BigDecimal.ZERO) < 0) {
                    error = "Max discount amount cannot be negative!";
                } else if (maxDiscountAmount != null && minOrderAmount.compareTo(maxDiscountAmount) > 0) {
                    error = "Minimum order amount cannot be greater than maximum discount amount!";
                } else if (quantity <= 0) {
                    error = "Quantity must be greater than 0!";
                } else {
                    VoucherDTO existingVoucher = dao.getVoucherDTOById(id);
                    if (existingVoucher != null && quantity < existingVoucher.getUsedQuantity()) {
                        error = "Quantity cannot be less than already used quantity (" + existingVoucher.getUsedQuantity() + ")!";
                    }
                }
                
                if (error.isEmpty() && !endDate.isAfter(startDate)) {
                    error = "End date must be after start date!";
                }
            }

            // ── 4. Lưu DB ─────────────────────────────────────────────────
            if (error.isEmpty()) {
                VoucherDTO updatedVoucher = new VoucherDTO();
                updatedVoucher.setId(id);
                updatedVoucher.setCode(code);
                updatedVoucher.setDiscountValue(discountValue);
                updatedVoucher.setMinOrderAmount(minOrderAmount);
                updatedVoucher.setMaxDiscountAmount(maxDiscountAmount);
                updatedVoucher.setStartDate(startDate);
                updatedVoucher.setEndDate(endDate);
                updatedVoucher.setQuantity(quantity);

                try {
                    boolean success = dao.updateVoucher(updatedVoucher);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/manage-voucher");
                        return;
                    } else {
                        error = "System error. Failed to update voucher!";
                    }
                } catch (Exception dbEx) {
                    dbEx.printStackTrace();
                    error = "Database error: " + dbEx.getMessage();
                }
            }
        }

        // Trả về form kèm thông báo lỗi và giữ dữ liệu đã nhập
        VoucherDTO fallbackVoucher = new VoucherDTO();
        fallbackVoucher.setId(id);
        fallbackVoucher.setCode(code);
        try { fallbackVoucher.setDiscountValue(discountStr != null && !discountStr.isEmpty() ? new BigDecimal(discountStr.trim()) : null); } catch (Exception ignored) {}
        try { fallbackVoucher.setMinOrderAmount(minOrderStr != null && !minOrderStr.isEmpty() ? new BigDecimal(minOrderStr.trim()) : null); } catch (Exception ignored) {}
        if (maxDiscountStr != null && !maxDiscountStr.trim().isEmpty()) {
            try { fallbackVoucher.setMaxDiscountAmount(new BigDecimal(maxDiscountStr.trim())); } catch (Exception ignored) {}
        }
        try { fallbackVoucher.setQuantity(quantityStr != null && !quantityStr.isEmpty() ? new BigDecimal(quantityStr.trim()).intValue() : 0); } catch (Exception ignored) {}

        request.setAttribute("ERROR", error);
        request.setAttribute("voucher", fallbackVoucher);
        request.setAttribute("formattedStart", startDateStr);
        request.setAttribute("formattedEnd", endDateStr);

        request.getRequestDispatcher(UPDATE_FORM_JSP).forward(request, response);
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}
