package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.AddressDAO;
import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.models.Address;
import com.mycompany.shoestore.models.CartItem;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession(false);

            if (session == null) {
                response.sendRedirect(
                        request.getContextPath() + "/login");
                return;
            }

            User currentUser
                    = (User) session.getAttribute("currentUser");

            if (currentUser == null) {
                response.sendRedirect(
                        request.getContextPath() + "/login");
                return;
            }

            String[] selectedItems
                    = request.getParameterValues("selectedItems");

            if (selectedItems == null
                    || selectedItems.length == 0) {

                response.sendRedirect(
                        request.getContextPath() + "/Cart");

                return;
            }

            CartDAO cartDAO = new CartDAO();

            List<CartItem> checkoutItems
                    = new ArrayList<>();

            double subTotal = 0;

            for (String variantId : selectedItems) {

                CartItem item
                        = cartDAO.getCartItemByVariant(
                                currentUser.getId(),
                                variantId);

                if (item != null) {

                    checkoutItems.add(item);

                    subTotal
                            += item.getPrice()
                            * item.getQuantity();
                }
            }
            double shippingFee = 30000;

            double finalTotal = subTotal + shippingFee;

            request.setAttribute("subTotal", subTotal);
            request.setAttribute("shippingFee", shippingFee);
            request.setAttribute("finalTotal", finalTotal);
            VoucherDAO voucherDAO = new VoucherDAO();

            request.setAttribute(
                    "vouchers",
                    voucherDAO.getAvailableVouchers());

            request.setAttribute(
                    "checkoutItems",
                    checkoutItems);

            session.setAttribute(
                    "checkoutItems",
                    checkoutItems);

            if (checkoutItems == null
                    || checkoutItems.isEmpty()) {

                response.sendRedirect(
                        request.getContextPath() + "/Cart");

                return;
            }

            AddressDAO addressDAO = new AddressDAO();

            List<Address> addresses
                    = addressDAO.getAddressesByUser(
                            currentUser.getId());

            Address defaultAddress
                    = addressDAO.getDefaultAddress(
                            currentUser.getId());

            request.setAttribute(
                    "checkoutItems",
                    checkoutItems);

            request.setAttribute(
                    "addresses",
                    addresses);

            request.setAttribute(
                    "defaultAddress",
                    defaultAddress);

            request.getRequestDispatcher(
                    "/checkout.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            throw new ServletException(e);
        }
    }
}
