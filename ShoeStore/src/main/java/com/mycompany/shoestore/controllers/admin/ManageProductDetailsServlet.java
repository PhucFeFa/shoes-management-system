package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.dao.ProductVariantDAO;
import com.mycompany.shoestore.models.Product;
import com.mycompany.shoestore.models.ProductVariant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageProductDetailsServlet", urlPatterns = {"/admin/product/details"})
public class ManageProductDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("id");
        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-products");
            return;
        }

        try {
            ProductDAO pDao = new ProductDAO();
            Product product = pDao.getProductById(productId);

            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/manage-products");
                return;
            }

            ProductVariantDAO vDao = new ProductVariantDAO();
            List<ProductVariant> variants = vDao.getVariantsByProductId(productId);

            request.setAttribute("product", product);
            request.setAttribute("variants", variants);
            request.setAttribute("activePage", "manage-products"); // Keep sidebar highlight on Products
            
            request.getRequestDispatcher("/views/admin/manage-product-details.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/manage-products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String productId = request.getParameter("productId");
        
        if (productId == null || productId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/manage-products");
            return;
        }
        
        ProductVariantDAO vDao = new ProductVariantDAO();
        
        try {
            if ("add_variant".equals(action)) {
                String size = request.getParameter("size");
                String color = request.getParameter("color");
                
                if (size == null || size.trim().isEmpty() || color == null || color.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMsg", "Size and color cannot be empty.");
                } else {
                    size = size.trim();
                    color = color.trim();
                    if (!size.matches("^\\d+(\\.\\d+)?$")) {
                        request.getSession().setAttribute("errorMsg", "Size must be a valid number.");
                    } else if (color.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Color cannot consist only of numbers.");
                    } else {
                        String finalSize = size;
                        String finalColor = color;
                        boolean exists = vDao.getVariantsByProductId(productId).stream()
                                .anyMatch(vr -> vr.getSize().equalsIgnoreCase(finalSize) && vr.getColor().equalsIgnoreCase(finalColor));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This variant (Size + Color) already exists.");
                        } else {
                            ProductVariant v = new ProductVariant();
                            v.setProductId(productId);
                            v.setSize(size);
                            v.setColor(color);
                            v.setStockQuantity(0); // Admin only defines the variant, stock is added via Import process
                            
                            boolean success = vDao.addVariant(v);
                            if (success) {
                                request.getSession().setAttribute("successMsg", "Variant added successfully.");
                            } else {
                                request.getSession().setAttribute("errorMsg", "Failed to add variant.");
                            }
                        }
                    }
                }
                
            } else if ("edit_variant".equals(action)) {
                String variantId = request.getParameter("variantId");
                String size = request.getParameter("size");
                String color = request.getParameter("color");
                
                if (size == null || size.trim().isEmpty() || color == null || color.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMsg", "Size and color cannot be empty.");
                } else {
                    size = size.trim();
                    color = color.trim();
                    if (!size.matches("^\\d+(\\.\\d+)?$")) {
                        request.getSession().setAttribute("errorMsg", "Size must be a valid number.");
                    } else if (color.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Color cannot consist only of numbers.");
                    } else {
                        String finalSize = size;
                        String finalColor = color;
                        String finalVariantId = variantId;
                        boolean exists = vDao.getVariantsByProductId(productId).stream()
                                .anyMatch(vr -> vr.getSize().equalsIgnoreCase(finalSize) 
                                            && vr.getColor().equalsIgnoreCase(finalColor) 
                                            && !vr.getId().equals(finalVariantId));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This variant (Size + Color) conflicts with an existing one.");
                        } else {
                            ProductVariant existing = vDao.getVariantById(variantId);
                            int currentStock = existing != null ? existing.getStockQuantity() : 0;
                            
                            ProductVariant v = new ProductVariant();
                            v.setId(variantId);
                            v.setSize(size);
                            v.setColor(color);
                            v.setStockQuantity(currentStock); // Preserve existing stock
                            
                            boolean success = vDao.updateVariant(v);
                            if (success) {
                                request.getSession().setAttribute("successMsg", "Variant updated successfully.");
                            } else {
                                request.getSession().setAttribute("errorMsg", "Failed to update variant.");
                            }
                        }
                    }
                }
                
            } else if ("delete_variant".equals(action)) {
                String variantId = request.getParameter("variantId");
                boolean success = vDao.deleteVariant(variantId);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Variant deleted successfully.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Failed to delete. This variant might have been ordered.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/product/details?id=" + productId);
    }
}
