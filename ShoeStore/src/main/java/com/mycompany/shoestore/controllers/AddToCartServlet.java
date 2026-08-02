package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.ProductVariantDAO;
import com.mycompany.shoestore.models.CartItem;
import com.mycompany.shoestore.models.ProductVariant;
import com.mycompany.shoestore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AddToCart", urlPatterns = {"/AddToCart"})
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("currentUser");
        String variantId = request.getParameter("variantId");

        if (variantId == null || variantId.trim().isEmpty()) {
            session.setAttribute("cartError", "Please select Size and Color!");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }

        try {
            ProductVariantDAO variantDAO = new ProductVariantDAO();
            ProductVariant variant = variantDAO.getVariantById(variantId);

            if (variant == null || variant.getStockQuantity() <= 0) {
                session.setAttribute("cartError", "Product is out of stock!");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            CartDAO cartDAO = new CartDAO();
            CartItem currentItem = cartDAO.getCartItemByVariant(user.getId().toString(), variantId);
            int currentQty = (currentItem != null) ? currentItem.getQuantity() : 0;
            
            if (currentQty + 1 > variant.getStockQuantity()) {
                session.setAttribute("cartError", "Cannot add more! Exceeds available stock.");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            cartDAO.addToCart(user.getId().toString(), variantId, 1);

            session.setAttribute("cartMessage", "Product added to cart successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cartError", "An error occurred!");
        }

        response.sendRedirect(request.getHeader("Referer"));
    }
}