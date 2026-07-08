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
import java.io.IOException;
import java.util.UUID;
import java.util.Collection;

@WebServlet(name = "AddProductServlet", urlPatterns = {"/admin/product/create"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String categoryName = request.getParameter("categoryName");
        String brandName = request.getParameter("brandName");

        try {
            double price = Double.parseDouble(priceStr);
            
            ProductDAO dao = new ProductDAO();
            
            String categoryId = dao.getOrCreateCategory(categoryName);
            String brandId = dao.getOrCreateBrand(brandName);
            
            Product p = new Product();
            p.setName(name);
            p.setDescription(description);
            p.setPrice(price);
            p.setCategoryId(categoryId);
            p.setBrandId(brandId);
            
            // Insert product without images first, to get the generated product ID
            String productId = dao.insertProduct(p, null); // null image URL since we handle it below

            if (productId != null) {
                // Process File Uploads
                String uploadPath = request.getServletContext().getRealPath("") + File.separator + "assets" + File.separator + "images" + File.separator + "products";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                Collection<Part> parts = request.getParts();
                int sortOrder = 1;
                for (Part part : parts) {
                    if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                        String fileName = UUID.randomUUID().toString() + "_" + getFileName(part);
                        part.write(uploadPath + File.separator + fileName);
                        
                        String dbUrl = request.getContextPath() + "/assets/images/products/" + fileName;
                        dao.insertProductImage(productId, dbUrl, sortOrder++);
                    }
                }
                request.getSession().setAttribute("successMsg", "Tạo sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMsg", "Không thể tạo sản phẩm, vui lòng thử lại.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Lỗi định dạng dữ liệu đầu vào hoặc upload ảnh: " + e.getMessage());
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
