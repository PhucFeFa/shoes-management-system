package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.AddressDAO;
import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.models.Address;
import com.mycompany.shoestore.models.CartItem;
import com.mycompany.shoestore.models.User;
import com.mycompany.shoestore.dao.ProductVariantDAO;
import com.mycompany.shoestore.models.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("currentUser") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            List<CartItem> checkoutItems = (List<CartItem>) session.getAttribute("checkoutItems");
            if (checkoutItems == null || checkoutItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Cart");
                return;
            }

            ProductVariantDAO variantDAO = new ProductVariantDAO();
            for (CartItem item : checkoutItems) {
                ProductVariant variant = variantDAO.getVariantById(item.getProductVariantId());
                if (variant == null || item.getQuantity() > variant.getStockQuantity()) {
                    session.setAttribute("cartError", "Product '" + item.getProductName() + "' (Size: " + item.getSize() + ", Color: " + item.getColor() + ") does not have enough stock. Please adjust your cart.");
                    response.sendRedirect(request.getContextPath() + "/Cart");
                    return;
                }
            }

            prepareCheckoutData(request, checkoutItems, (User) session.getAttribute("currentUser"));
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error processing checkout", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String[] selectedItemsRaw = request.getParameterValues("selectedItems");
            if (selectedItemsRaw == null || selectedItemsRaw.length == 0) {
                response.sendRedirect(request.getContextPath() + "/Cart");
                return;
            }

            // Khử trùng lặp variantId (chặn lỗi duplicate nếu Cart.jsp render checkbox
            // trùng)
            Set<String> selectedSet = new LinkedHashSet<>(Arrays.asList(selectedItemsRaw));
            String[] selectedItems = selectedSet.toArray(new String[0]);

            CartDAO cartDAO = new CartDAO();
            ProductVariantDAO variantDAO = new ProductVariantDAO();
            List<CartItem> checkoutItems = new ArrayList<>();
            for (String variantId : selectedItems) {
                CartItem item = cartDAO.getCartItemByVariant(currentUser.getId().toString(), variantId);
                if (item != null) {
                    ProductVariant variant = variantDAO.getVariantById(variantId);
                    if (variant == null || item.getQuantity() > variant.getStockQuantity()) {
                        session.setAttribute("cartError", "Product '" + item.getProductName() + "' (Size: " + item.getSize() + ", Color: " + item.getColor() + ") does not have enough stock. Please adjust your cart.");
                        response.sendRedirect(request.getContextPath() + "/Cart");
                        return;
                    }
                    checkoutItems.add(item);
                }
            }

            if (checkoutItems.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/Cart");
                return;
            }

            // Lưu vào session để PlaceOrderServlet hoặc doGet sử dụng
            session.setAttribute("checkoutItems", checkoutItems);

            prepareCheckoutData(request, checkoutItems, currentUser);
            request.getRequestDispatcher("/checkout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Lỗi khi xử lý checkout", e);
        }
    }

    private void prepareCheckoutData(HttpServletRequest request, List<CartItem> checkoutItems, User currentUser)
            throws Exception {
        double subTotal = 0;
        boolean hasBackorderItems = false;
        ProductVariantDAO variantDAO = new ProductVariantDAO();

        for (CartItem item : checkoutItems) {
            subTotal += item.getPrice() * item.getQuantity();
            try {
                ProductVariant variant = variantDAO.getVariantById(item.getProductVariantId());
                if (variant != null && item.getQuantity() > variant.getStockQuantity()) {
                    hasBackorderItems = true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        double finalTotal = subTotal;

        // Set attributes cho JSP
        request.setAttribute("checkoutItems", checkoutItems);
        request.setAttribute("subTotal", subTotal);
        request.setAttribute("finalTotal", finalTotal);
        request.setAttribute("hasBackorderItems", hasBackorderItems);

        // Voucher
        VoucherDAO voucherDAO = new VoucherDAO();
        request.setAttribute("vouchers", voucherDAO.getAvailableVouchers());

        // Address
        AddressDAO addressDAO = new AddressDAO();
        List<Address> addresses = addressDAO.getAddressesByUser(currentUser.getId());
        Address defaultAddress = addressDAO.getDefaultAddress(currentUser.getId());
        request.setAttribute("addresses", addresses);
        request.setAttribute("defaultAddress", defaultAddress);
    }
}
