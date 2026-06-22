package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.OrderDAO;
import com.mycompany.shoestore.dao.PaymentDAO;
import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.models.CartItem;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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

        User currentUser
                = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {

            CartDAO cartDAO = new CartDAO();

            List<CartItem> checkoutItems
                    = (List<CartItem>) session.getAttribute("checkoutItems");

            if (checkoutItems == null || checkoutItems.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() + "/Cart");
                return;
            }

            String addressId = request.getParameter("addressId");

            if (addressId == null || addressId.trim().isEmpty()) {

                request.setAttribute(
                        "error",
                        "Please select shipping address");

                request.getRequestDispatcher("/checkout.jsp")
                        .forward(request, response);
                return;
            }

            String voucherId = request.getParameter("voucherId");

            double totalAmount;

            try {
                totalAmount = Double.parseDouble(
                        request.getParameter("finalAmount"));
            } catch (Exception ex) {
                throw new Exception("Invalid order amount");
            }

            OrderDAO orderDAO = new OrderDAO();

            String orderId
                    = orderDAO.createOrder(
                            currentUser.getId(),
                            addressId,
                            totalAmount,
                            voucherId);

            if (orderId == null) {
                throw new Exception("Cannot create order");
            }
            if (voucherId != null
                    && !voucherId.trim().isEmpty()) {

                VoucherDAO voucherDAO = new VoucherDAO();

                voucherDAO.decreaseVoucherQuantity(voucherId);
            }

            for (CartItem item : checkoutItems) {

                orderDAO.addOrderItem(
                        orderId,
                        item.getProductVariantId(),
                        item.getQuantity(),
                        item.getPrice());
                orderDAO.updateProductStock(
                        item.getProductVariantId(),
                        item.getQuantity());
            }

            PaymentDAO paymentDAO = new PaymentDAO();

            paymentDAO.createCODPayment(
                    orderId,
                    totalAmount);

            for (CartItem item : checkoutItems) {

                cartDAO.removeCartItem(
                        currentUser.getId(),
                        item.getProductVariantId());
            }

            session.removeAttribute("checkoutItems");

            response.sendRedirect(
                    request.getContextPath()
                    + "/order-success?orderId="
                    + orderId);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "error",
                    "Order failed: " + e.getMessage());

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);
        }
    }
}
