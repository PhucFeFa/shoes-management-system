<<<<<<< Updated upstream
=======
// Author: PhucLHCE191132
>>>>>>> Stashed changes
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

<<<<<<< Updated upstream
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;
import java.util.Collection;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/product/create"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
=======
import java.io.IOException;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/product/create"})
>>>>>>> Stashed changes
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryName = request.getParameter("categoryName");
        String brandName = request.getParameter("brandName");

<<<<<<< Updated upstream
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

        ProductDAO dao = new ProductDAO();
        String finalName = name;
        boolean exists = dao.getAllProducts().stream().anyMatch(p -> p.getName().equalsIgnoreCase(finalName));
        if (exists) {
            request.getSession().setAttribute("errorMsg", "This product already exists in the system.");
            response.sendRedirect(request.getContextPath() + "/admin/manage-products");
            return;
        }

        try {
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
            
=======
        try {
            double price = Double.parseDouble(priceStr);
            
            ProductDAO dao = new ProductDAO();
            
            // Get or create Category and Brand
>>>>>>> Stashed changes
            String categoryId = dao.getOrCreateCategory(categoryName);
            String brandId = dao.getOrCreateBrand(brandName);
            
            Product p = new Product();
            p.setName(name);
            p.setDescription(description);
            p.setPrice(price);
            p.setCategoryId(categoryId);
            p.setBrandId(brandId);
            
<<<<<<< Updated upstream
            // Insert product without images first, to get the generated product ID
            String productId = dao.insertProduct(p, null); // null image URL since we handle it below

            if (productId != null) {
                // Process File Uploads
                String uploadPath = "D:\\Upload_ShoesStore";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                Collection<Part> parts = request.getParts();
                int sortOrder = 1;
                for (Part part : parts) {
                    if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
                        part.write(uploadPath + File.separator + fileName);
                        
                        // Use /uploads/ path for the database URL so Tomcat can map it
                        String dbUrl = request.getContextPath() + "/uploads/" + fileName;
                        dao.insertProductImage(productId, dbUrl, sortOrder++);
                    }
                }
                request.getSession().setAttribute("successMsg", "Product created successfully!");
            } else {
                request.getSession().setAttribute("errorMsg", "Cannot create product, please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Data format or image upload error: " + e.getMessage());
=======
            // Pass null for imageUrl since we will add images later
            boolean success = dao.insertProduct(p, null);
            
            if (success) {
                request.getSession().setAttribute("successMsg", "Tạo sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMsg", "Không thể tạo sản phẩm, vui lòng thử lại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Lỗi định dạng dữ liệu đầu vào!");
>>>>>>> Stashed changes
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-products");
    }
<<<<<<< Updated upstream
    
    private String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown.jpg";
    }
=======
>>>>>>> Stashed changes
}
