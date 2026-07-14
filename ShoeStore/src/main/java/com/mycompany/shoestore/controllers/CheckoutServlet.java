//package com.mycompany.shoestore.controllers;
//
//import com.mycompany.shoestore.dao.AddressDAO;
//import com.mycompany.shoestore.dao.CartDAO;
//import com.mycompany.shoestore.dao.VoucherDAO;
//import com.mycompany.shoestore.models.Address;
//import com.mycompany.shoestore.models.CartItem;
//import com.mycompany.shoestore.models.User;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.LinkedHashSet;
//import java.util.List;
//import java.util.Set;
//
//@WebServlet("/checkout")
//public class CheckoutServlet extends HttpServlet {
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        try {
//            HttpSession session = request.getSession(false);
//            if (session == null) {
//                response.sendRedirect(request.getContextPath() + "/login");
//                return;
//            }
//
//            User currentUser = (User) session.getAttribute("currentUser");
//            if (currentUser == null) {
//                response.sendRedirect(request.getContextPath() + "/login");
//                return;
//            }
//
//            String[] selectedItemsRaw = request.getParameterValues("selectedItems");
//            if (selectedItemsRaw == null || selectedItemsRaw.length == 0) {
//                response.sendRedirect(request.getContextPath() + "/Cart");
//                return;
//            }
//
//            // Khử trùng lặp variantId (chặn lỗi duplicate nếu Cart.jsp render checkbox
//            // trùng)
//            Set<String> selectedSet = new LinkedHashSet<>(Arrays.asList(selectedItemsRaw));
//            String[] selectedItems = selectedSet.toArray(new String[0]);
//
//            CartDAO cartDAO = new CartDAO();
//
//            double subTotal = 0;
//            List<CartItem> checkoutItems = new ArrayList<>();
//            for (String variantId : selectedItems) {
//                CartItem item = cartDAO.getCartItemByVariant(currentUser.getId(), variantId);
//                if (item != null) {
//                    checkoutItems.add(item);
//                    subTotal += item.getPrice() * item.getQuantity();
//                }
//            }
//
//            if (checkoutItems.isEmpty()) {
//                response.sendRedirect(request.getContextPath() + "/Cart");
//                return;
//            }
//
//            double finalTotal = subTotal;
//
//            // Set attributes cho JSP
//            request.setAttribute("checkoutItems", checkoutItems);
//            request.setAttribute("subTotal", subTotal);
//            request.setAttribute("finalTotal", finalTotal);
//
//            // Voucher
//            VoucherDAO voucherDAO = new VoucherDAO();
//            request.setAttribute("vouchers", voucherDAO.getAvailableVouchers());
//
//            // Address
//            AddressDAO addressDAO = new AddressDAO();
//            List<Address> addresses = addressDAO.getAddressesByUser(currentUser.getId());
//            Address defaultAddress = addressDAO.getDefaultAddress(currentUser.getId());
//            request.setAttribute("addresses", addresses);
//            request.setAttribute("defaultAddress", defaultAddress);
//
//            // Lưu vào session để PlaceOrderServlet sử dụng
//            session.setAttribute("checkoutItems", checkoutItems);
//
//            request.getRequestDispatcher("/checkout.jsp").forward(request, response);
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            throw new ServletException("Lỗi khi xử lý checkout", e);
//        }
//    }
//}
