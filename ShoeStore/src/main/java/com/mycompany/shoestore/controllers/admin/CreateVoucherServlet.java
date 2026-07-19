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
        String code = request.getParameter("code");
        String discountValueStr = request.getParameter("discountValue");
        String minOrderAmountStr = request.getParameter("minOrderAmount");
        String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String quantityStr = request.getParameter("quantity");

        String error = "";
        VoucherDAO voucherDAO = new VoucherDAO();

        if (code == null || code.trim().isEmpty()
                || discountValueStr == null || discountValueStr.trim().isEmpty()
                || minOrderAmountStr == null || minOrderAmountStr.trim().isEmpty()
                || startDateStr == null || startDateStr.trim().isEmpty()
                || endDateStr == null || endDateStr.trim().isEmpty()
                || quantityStr == null || quantityStr.trim().isEmpty()) {

            error = "All fields are required!";
        } else {
            try {
                code = code.trim().toUpperCase();
                BigDecimal discountValue = new BigDecimal(discountValueStr);
                BigDecimal minOrderAmount = new BigDecimal(minOrderAmountStr);
                
                BigDecimal maxDiscountAmount = null;
                if (maxDiscountAmountStr != null && !maxDiscountAmountStr.trim().isEmpty()) {
                    maxDiscountAmount = new BigDecimal(maxDiscountAmountStr);
                }
                
                int quantity = Integer.parseInt(quantityStr);

                OffsetDateTime startDate = LocalDateTime.parse(startDateStr, FORMATTER).atOffset(ZoneOffset.UTC);
                OffsetDateTime endDate = LocalDateTime.parse(endDateStr, FORMATTER).atOffset(ZoneOffset.UTC);

                if (code.length() < 6) {
                    error = "Voucher code must be at least 6 characters long!";
                } else if (voucherDAO.isCodeExist(code)) {
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

                if (error.isEmpty()) {
                    VoucherDTO newVoucher = new VoucherDTO();
                    newVoucher.setCode(code);
                    newVoucher.setDiscountValue(discountValue);
                    newVoucher.setMinOrderAmount(minOrderAmount);
                    newVoucher.setMaxDiscountAmount(maxDiscountAmount);
                    newVoucher.setStartDate(startDate);
                    newVoucher.setEndDate(endDate);
                    newVoucher.setQuantity(quantity);

                    boolean success = voucherDAO.createVoucher(newVoucher);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/manage-voucher");
                        return;
                    } else {
                        error = "System error. Failed to save voucher!";
                    }
                }

            } catch (Exception e) {
                error = "Invalid format data entry! Please re-check numbers and dates.";
            }
        }

        request.setAttribute("ERROR", error);
        request.setAttribute("oldCode", code);
        request.setAttribute("oldValue", discountValueStr);
        request.setAttribute("oldMin", minOrderAmountStr);
        request.setAttribute("oldMax", maxDiscountAmountStr);
        request.setAttribute("oldStart", startDateStr);
        request.setAttribute("oldEnd", endDateStr);
        request.setAttribute("oldQty", quantityStr);

        request.getRequestDispatcher(VOUCHER_FORM_JSP).forward(request, response);
    }
}
