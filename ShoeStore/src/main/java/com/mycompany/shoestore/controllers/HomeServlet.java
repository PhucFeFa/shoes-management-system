// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        ProductDAO productDAO = new ProductDAO();
        
        // Fetch the 4 latest products
        List<Product> latestProducts = productDAO.getLatestProducts(4);
        
        // Pass to JSP
        request.setAttribute("latestProducts", latestProducts);
        
        // Forward to View
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
