package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.CartDAO;
import com.mycompany.shoestore.dao.ProductVariantDAO;
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
            session.setAttribute("cartMessage", "Please select Size and Color!");
            response.sendRedirect(request.getHeader("Referer"));
            return;
        }

        try {
            ProductVariantDAO variantDAO = new ProductVariantDAO();
            ProductVariant variant = variantDAO.getVariantById(variantId);

            if (variant == null || variant.getStockQuantity() <= 0) {
                session.setAttribute("cartMessage", "Product is out of stock!");
                response.sendRedirect(request.getHeader("Referer"));
                return;
            }

            CartDAO cartDAO = new CartDAO();
            cartDAO.addToCart(user.getId().toString(), variantId, 1);



            session.setAttribute("cartMessage", "Product added to cart successfully!");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cartMessage", "An error occurred!");
        }

        response.sendRedirect(request.getHeader("Referer"));
    }
}