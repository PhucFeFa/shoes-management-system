// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "ManageProductServlet", urlPatterns = {"/admin/manage-products"})
public class ManageProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDAO productDAO = new ProductDAO();
            List<Product> allProducts = productDAO.getAllProducts();
            
            // Basic search functionality
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String q = searchQuery.toLowerCase().trim();
                allProducts = allProducts.stream()
                        .filter(p -> p.getName().toLowerCase().contains(q) || 
                                     (p.getCategory() != null && p.getCategory().getName().toLowerCase().contains(q)) ||
                                     (p.getBrand() != null && p.getBrand().getName().toLowerCase().contains(q)))
                        .collect(Collectors.toList());
            }
            
            request.setAttribute("products", allProducts);
            request.setAttribute("categories", productDAO.getAllCategories());
            request.setAttribute("brands", productDAO.getAllBrands());
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("activePage", "manage-products");
            request.getRequestDispatcher("/views/admin/manage-products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
