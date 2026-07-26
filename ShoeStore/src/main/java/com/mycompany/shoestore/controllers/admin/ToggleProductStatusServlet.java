package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleProductStatusServlet", urlPatterns = {"/admin/product/toggle-status"})
public class ToggleProductStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productId = request.getParameter("id");

        try {
            ProductDAO dao = new ProductDAO();
            boolean success = dao.toggleProductStatus(productId);
            
            if (success) {
                request.getSession().setAttribute("successMsg", "Update status product completed!");
            } else {
                request.getSession().setAttribute("errorMsg", "Can not update product status!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-products");
    }
}
