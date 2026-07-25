package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.dao.ProductVariantDAO;
import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.models.CartItem;
import com.mycompany.shoestore.models.User;
import com.mycompany.shoestore.models.Voucher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser =
                (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {

            CartDAO cartDAO = new CartDAO();
            ProductVariantDAO variantDAO = new ProductVariantDAO();
            OrderDAO orderDAO = new OrderDAO();
            VoucherDAO voucherDAO = new VoucherDAO();

            @SuppressWarnings("unchecked")
            List<CartItem> checkoutItems =
                    (List<CartItem>) session.getAttribute("checkoutItems");

            if (checkoutItems == null || checkoutItems.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() + "/Cart");

                return;
            }

            // ===================== ADDRESS =====================

            String addressId =
                    request.getParameter("addressId");

            if (addressId == null || addressId.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Please select a shipping address.");

                request.getRequestDispatcher("/checkout.jsp")
                        .forward(request, response);

                return;
            }

            // ===================== VOUCHER =====================

            String voucherId =
                    request.getParameter("voucherId");

            if (voucherId != null
                    && voucherId.trim().isEmpty()) {

                voucherId = null;
            }

            // ===================== CHECK STOCK =====================

            for (CartItem item : checkoutItems) {

                int currentStock =
                        variantDAO.getStockByVariant(
                                item.getProductVariantId());

                if (currentStock < item.getQuantity()) {

                    request.setAttribute(
                            "error",
                            item.getProductName()
                            + " only has "
                            + currentStock
                            + " items left in stock.");

                    request.getRequestDispatcher("/checkout.jsp")
                            .forward(request, response);

                    return;
                }
            }

            // ===================== CALCULATE TOTAL =====================

            double subTotal = 0;

            for (CartItem item : checkoutItems) {

                subTotal +=
                        item.getPrice()
                        * item.getQuantity();
            }

            double totalAmount =
                    subTotal;

            // Áp dụng voucher nếu có
            if (voucherId != null) {

                Voucher voucher =
                        voucherDAO.getVoucherById(voucherId);

                if (voucher != null) {
                    // Schema only has discount_value as a fixed amount (no discount_type column)
                    double discount = voucher.getDiscountValue();
                    // Apply max_discount_amount cap if set
                    if (voucher.getMaxDiscountAmount() != null && discount > voucher.getMaxDiscountAmount()) {
                        discount = voucher.getMaxDiscountAmount();
                    }
                    totalAmount -= discount;
                }
            }

            if (totalAmount < 0) {
                totalAmount = 0;
            }

            // ===================== CREATE ORDER =====================

            String orderId =
                    orderDAO.createOrder(
                            currentUser.getId(),
                            addressId,
                            totalAmount,
                            voucherId,
                            "cod");

            if (orderId == null) {

                throw new Exception(
                        "Không thể tạo đơn hàng");
            }

            // ===================== DECREASE VOUCHER =====================

            if (voucherId != null) {

                voucherDAO.decreaseVoucherQuantity(
                        voucherId);
            }

            // ===================== ORDER ITEMS =====================

            for (CartItem item : checkoutItems) {

                orderDAO.addOrderItem(
                        orderId,
                        item.getProductVariantId(),
                        item.getQuantity(),
                        item.getPrice());

                variantDAO.updateProductStock(
                        item.getProductVariantId(),
                        item.getQuantity());

                cartDAO.removeCartItem(
                        currentUser.getId(),
                        item.getProductVariantId());
            }



            // ===================== CLEAR SESSION =====================

            session.removeAttribute("checkoutItems");

            response.sendRedirect(
                    request.getContextPath()
                    + "/order-success?orderId="
                    + orderId);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Failed to place order: "
                    + e.getMessage());

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);
        }
    }
}