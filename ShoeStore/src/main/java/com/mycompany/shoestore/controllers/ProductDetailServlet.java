package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Product;
import com.mycompany.shoestore.models.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Set;

@WebServlet(name = "ProductDetail", urlPatterns = {"/ProductDetail"})
public class ProductDetailServlet extends HttpServlet {

    private final ProductDAO dao = new ProductDAO();

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at "
                    + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String productId = request.getParameter("id");

        try {

            Product product = dao.getProductById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            List<ProductVariant> variants
                    = dao.getVariantsByProductId(productId);

            Set<String> sizes
                    = dao.getSizesByProduct(productId);

            Set<String> colors
                    = dao.getColorsByProduct(productId);

            request.setAttribute("product", product);
            request.setAttribute("variants", variants);
            request.setAttribute("sizes", sizes);
            request.setAttribute("colors", colors);

            request.getRequestDispatcher("/productDetail.jsp")
                    .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading product detail", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Product Detail Servlet";
    }
}