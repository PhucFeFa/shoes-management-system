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

@WebServlet(name = "CreateVoucherServlet", urlPatterns = {"/create-voucher"})
public class CreateVoucherServlet extends HttpServlet {


    private static final String VOUCHER_FORM_JSP = "/views/admin/voucher-form.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(VOUCHER_FORM_JSP).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String discountPercentStr = request.getParameter("discountPercent");
        String maxDiscountAmountStr = request.getParameter("maxDiscountAmount");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String quantityStr = request.getParameter("quantity");

        String error = "";
        VoucherDAO voucherDAO = new VoucherDAO();

        if (code == null || code.trim().isEmpty()
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

                if (voucherDAO.isCodeExist(code)) {
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
                    VoucherDTO newVoucher = new VoucherDTO();
                    newVoucher.setCode(code);
                    newVoucher.setDiscountPercent(discountPercent);
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
        request.setAttribute("oldPercent", discountPercentStr);
        request.setAttribute("oldMax", maxDiscountAmountStr);
        request.setAttribute("oldStart", startDateStr);
        request.setAttribute("oldEnd", endDateStr);
        request.setAttribute("oldQty", quantityStr);

        request.getRequestDispatcher(VOUCHER_FORM_JSP).forward(request, response);
    }
}