package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Brand;
import com.mycompany.shoestore.models.Category;
import com.mycompany.shoestore.models.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductCatalogServlet", urlPatterns = {"/products"})
public class ProductCatalogServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Get search and filter parameters
        String searchQuery = request.getParameter("search");
        String[] categoryIds = request.getParameterValues("category");
        String[] brandIds = request.getParameterValues("brand");
        
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        
        Double minPrice = null;
        Double maxPrice = null;
        
        try {
            if (minPriceParam != null && !minPriceParam.trim().isEmpty()) {
                minPrice = Double.parseDouble(minPriceParam);
            }
            if (maxPriceParam != null && !maxPriceParam.trim().isEmpty()) {
                maxPrice = Double.parseDouble(maxPriceParam);
            }
        } catch (NumberFormatException e) {
            // Log or ignore invalid numbers, keeping them null
        }

        // 2. Fetch data from DAO
        List<Category> categories = productDAO.getAllCategories();
        List<Brand> brands = productDAO.getAllBrands();
        List<Product> products = productDAO.searchAndFilterProducts(searchQuery, categoryIds, brandIds, minPrice, maxPrice);

        // 3. Set attributes for the view
        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.setAttribute("products", products);
        
        // Retain states for the form
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("selectedCategories", categoryIds != null ? java.util.Arrays.asList(categoryIds) : null);
        request.setAttribute("selectedBrands", brandIds != null ? java.util.Arrays.asList(brandIds) : null);
        request.setAttribute("minPrice", minPriceParam);
        request.setAttribute("maxPrice", maxPriceParam);

        // 4. Forward to view
        request.getRequestDispatcher("/shop.jsp").forward(request, response);
    }
}
