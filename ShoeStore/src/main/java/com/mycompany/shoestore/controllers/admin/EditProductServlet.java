package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.util.Collection;
import java.util.UUID;
import java.io.IOException;

@WebServlet(name = "EditProductServlet", urlPatterns = {"/admin/product/edit"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize = 1024 * 1024 * 10,
    maxRequestSize = 1024 * 1024 * 50
)
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String priceStr = request.getParameter("price");
            String categoryName = request.getParameter("categoryName");
            String brandName = request.getParameter("brandName");

            if (name == null || name.trim().isEmpty()) {
                request.getSession().setAttribute("errorMsg", "Product name cannot be empty.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-products");
                return;
            }
            name = name.trim();
            if (name.matches("\\d+")) {
                request.getSession().setAttribute("errorMsg", "Product name cannot consist only of numbers.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-products");
                return;
            }

            ProductDAO productDAO = new ProductDAO();
            
            String finalName = name;
            String finalId = id;
            boolean exists = productDAO.getAllProducts().stream()
                    .anyMatch(p -> p.getName().equalsIgnoreCase(finalName) && !p.getId().equals(finalId));
            if (exists) {
                request.getSession().setAttribute("errorMsg", "This product name conflicts with an existing product.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-products");
                return;
            }

            double price;
            try {
                price = Double.parseDouble(priceStr);
                if (price <= 0) {
                    throw new Exception("Price must be > 0");
                }
            } catch (Exception ex) {
                request.getSession().setAttribute("errorMsg", "Product price must be a valid number and greater than 0.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-products");
                return;
            }

            String categoryId = productDAO.getOrCreateCategory(categoryName);
            String brandId = productDAO.getOrCreateBrand(brandName);

            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setDescription(description);
            product.setPrice(price);
            product.setCategoryId(categoryId);
            product.setBrandId(brandId);

            boolean success = productDAO.updateProduct(product);

            if (success) {
                // Process File Upload if a new image was provided
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "products";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                Collection<Part> parts = request.getParts();
                for (Part part : parts) {
                    if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
                        part.write(uploadPath + File.separator + fileName);
                        
                        String dbUrl = request.getContextPath() + "/assets/images/products/" + fileName;
                        
                        // Replace existing images since we only allow 1 image per product
                        productDAO.deleteProductImagesByProductId(id);
                        productDAO.insertProductImage(id, dbUrl, 1);
                    }
                }

                request.getSession().setAttribute("successMsg", "Product updated successfully!");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to update product. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/manage-products");
    }
    
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown.jpg";
    }
}
