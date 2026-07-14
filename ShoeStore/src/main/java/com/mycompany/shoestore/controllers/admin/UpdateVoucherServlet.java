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
        String id = request.getParameter("id");
        String code = request.getParameter("code");
        String discountType = request.getParameter("discountType");
        String discountValueStr = request.getParameter("discountValue");
        String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String quantityStr = request.getParameter("quantity");

        String error = "";
        VoucherDAO voucherDAO = new VoucherDAO();

        if (id == null || id.trim().isEmpty()
                || code == null || code.trim().isEmpty()
                || discountType == null || discountType.trim().isEmpty()
                || discountValueStr == null || discountValueStr.trim().isEmpty()
                || startDateStr == null || startDateStr.trim().isEmpty()
                || endDateStr == null || endDateStr.trim().isEmpty()
                || quantityStr == null || quantityStr.trim().isEmpty()) {

            error = "All fields are required!";
        } else {
            try {
                code = code.trim().toUpperCase();
                BigDecimal discountValue = new BigDecimal(discountValueStr);
                
                BigDecimal maxDiscountAmount = null;
                if (maxDiscountAmountStr != null && !maxDiscountAmountStr.trim().isEmpty()) {
                    maxDiscountAmount = new BigDecimal(maxDiscountAmountStr);
                }
                
                int quantity = Integer.parseInt(quantityStr);

                OffsetDateTime startDate = LocalDateTime.parse(startDateStr, FORMATTER).atOffset(ZoneOffset.UTC);
                OffsetDateTime endDate = LocalDateTime.parse(endDateStr, FORMATTER).atOffset(ZoneOffset.UTC);

                if (voucherDAO.isCodeExistForUpdate(code, id)) {
                    error = "Voucher code already exists!";
                } else if ("PERCENTAGE".equals(discountType) && (discountValue.compareTo(BigDecimal.ZERO) <= 0 || discountValue.compareTo(new BigDecimal("100")) > 0)) {
                    error = "Discount percent must be between 0.1% and 100%!";
                } else if ("FIXED_AMOUNT".equals(discountType) && discountValue.compareTo(BigDecimal.ZERO) <= 0) {
                    error = "Discount amount must be greater than 0!";
                } else if (maxDiscountAmount != null && maxDiscountAmount.compareTo(BigDecimal.ZERO) < 0) {
                    error = "Max discount amount cannot be negative!";
                } else if (maxDiscountAmount != null && "FIXED_AMOUNT".equals(discountType) && maxDiscountAmount.compareTo(discountValue) < 0) {
                    error = "Max discount amount must be greater than or equal to discount value!";
                } else if (quantity <= 0) {
                    error = "Quantity must be greater than 0!";
                } else if (!endDate.isAfter(startDate)) {
                    error = "End date must be after start date!";
                }

                if (error.isEmpty()) {
                    VoucherDTO updatedVoucher = new VoucherDTO();
                    updatedVoucher.setId(id);
                    updatedVoucher.setCode(code);
                    updatedVoucher.setDiscountType(discountType);
                    updatedVoucher.setDiscountValue(discountValue);
                    updatedVoucher.setMaxDiscountAmount(maxDiscountAmount);
                    updatedVoucher.setStartDate(startDate);
                    updatedVoucher.setEndDate(endDate);
                    updatedVoucher.setQuantity(quantity);

                    boolean success = voucherDAO.updateVoucher(updatedVoucher);
                    if (success) {
                        response.sendRedirect(request.getContextPath() + "/manage-voucher");
                        return;
                    } else {
                        error = "System error. Failed to update voucher!";
                    }
                }

            } catch (Exception e) {
                error = "Invalid format data entry! Please re-check numbers and dates.";
            }
        }

        // Nếu có lỗi, giữ lại dữ liệu đang nhập lỗi trên giao diện để người dùng sửa lại
        VoucherDTO fallbackVoucher = new VoucherDTO();
        fallbackVoucher.setId(id);
        fallbackVoucher.setCode(code);
        
        request.setAttribute("ERROR", error);
        request.setAttribute("voucher", fallbackVoucher);
        request.setAttribute("oldType", discountType);
        request.setAttribute("oldValue", discountValueStr);
        request.setAttribute("oldMax", maxDiscountAmountStr);
        request.setAttribute("formattedStart", startDateStr);
        request.setAttribute("formattedEnd", endDateStr);
        request.setAttribute("oldQty", quantityStr);

        request.getRequestDispatcher(UPDATE_FORM_JSP).forward(request, response);
    }
}
