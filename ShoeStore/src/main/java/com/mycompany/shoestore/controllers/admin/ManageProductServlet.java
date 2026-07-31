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
            
<<<<<<< Updated upstream
            int pageSize = 10;
            int totalProducts = allProducts.size();
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalPages < 1) totalPages = 1;
            
            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            if (currentPage > totalPages) currentPage = totalPages;
            if (currentPage < 1) currentPage = 1;
            
            int startIndex = (currentPage - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalProducts);
            List<Product> paginatedProducts = allProducts.subList(startIndex, endIndex);
            
            request.setAttribute("products", paginatedProducts);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("rangeStart", totalProducts == 0 ? 0 : startIndex + 1);
            request.setAttribute("rangeEnd", endIndex);
=======
            
            request.setAttribute("products", allProducts);
>>>>>>> Stashed changes
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
