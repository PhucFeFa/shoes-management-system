/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "UpdateVoucherServlet", urlPatterns = {"/manage-voucher/edit"})
public class UpdateVoucherServlet extends HttpServlet {

    private static final String UPDATE_FORM_JSP = "/views/admin/update-voucher.jsp";

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
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
        String formattedStart = voucher.getStartDate() != null ? dateFormat.format(voucher.getStartDate()) : "";
        String formattedEnd = voucher.getEndDate() != null ? dateFormat.format(voucher.getEndDate()) : "";

        // Gửi dữ liệu gốc sang JSP điền vào form
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
        String discountPercentStr = request.getParameter("discountPercent");
        String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String quantityStr = request.getParameter("quantity");

        String error = "";
        VoucherDAO voucherDAO = new VoucherDAO();

        if (id == null || id.trim().isEmpty()
                || code == null || code.trim().isEmpty()
                || discountPercentStr == null || discountPercentStr.trim().isEmpty()
                || maxDiscountAmountStr == null || maxDiscountAmountStr.trim().isEmpty()
                || startDateStr == null || startDateStr.trim().isEmpty()
                || endDateStr == null || endDateStr.trim().isEmpty()
                || quantityStr == null || quantityStr.trim().isEmpty()) {

            error = "All fields are required!";
        } else {
            try {
                code = code.trim().toUpperCase();
                double discountPercent = Double.parseDouble(discountPercentStr);
                double maxDiscountAmount = Double.parseDouble(maxDiscountAmountStr);
                int quantity = Integer.parseInt(quantityStr);

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                Timestamp startDate = new Timestamp(dateFormat.parse(startDateStr).getTime());
                Timestamp endDate = new Timestamp(dateFormat.parse(endDateStr).getTime());

                // Sử dụng hàm kiểm tra trùng mã loại trừ chính ID này
                if (voucherDAO.isCodeExistForUpdate(code, id)) {
                    error = "Voucher code already exists!";
                } else if (discountPercent <= 0 || discountPercent > 100) {
                    error = "Discount percent must be between 0.1% and 100%!";
                } else if (maxDiscountAmount < 0) {
                    error = "Max discount amount cannot be negative!";
                } else if (quantity <= 0) {
                    error = "Quantity must be greater than 0!";
                } else if (!endDate.after(startDate)) {
                    error = "End date must be after start date!";
                }

                if (error.isEmpty()) {
                    VoucherDTO updatedVoucher = new VoucherDTO();
                    updatedVoucher.setId(id);
                    updatedVoucher.setCode(code);
                    updatedVoucher.setDiscountPercent(discountPercent);
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
        request.setAttribute("oldPercent", discountPercentStr);
        request.setAttribute("oldMax", maxDiscountAmountStr);
        request.setAttribute("formattedStart", startDateStr);
        request.setAttribute("formattedEnd", endDateStr);
        request.setAttribute("oldQty", quantityStr);

        request.getRequestDispatcher(UPDATE_FORM_JSP).forward(request, response);
    }
}
