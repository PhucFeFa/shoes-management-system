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

@WebServlet(name = "ManageProductDetailsServlet", urlPatterns = { "/admin/product/details" })
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

            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                String q = search.trim().toLowerCase();
                variants = variants.stream()
                        .filter(v -> (v.getColor() != null && v.getColor().toLowerCase().contains(q)) ||
                                (v.getSize() != null && v.getSize().toLowerCase().contains(q)))
                        .collect(java.util.stream.Collectors.toList());
            }

            int pageSize = 10;
            int totalDetails = variants.size();
            int totalPages = (int) Math.ceil((double) totalDetails / pageSize);
            if (totalPages < 1)
                totalPages = 1;

            int currentPage = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                try {
                    currentPage = Integer.parseInt(pageParam);
                } catch (NumberFormatException e) {
                    currentPage = 1;
                }
            }
            if (currentPage > totalPages)
                currentPage = totalPages;
            if (currentPage < 1)
                currentPage = 1;

            int startIndex = (currentPage - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, totalDetails);
            List<ProductVariant> paginatedDetails = variants.subList(startIndex, endIndex);

            request.setAttribute("variants", paginatedDetails);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalDetails", totalDetails);
            request.setAttribute("rangeStart", totalDetails == 0 ? 0 : startIndex + 1);
            request.setAttribute("rangeEnd", endIndex);
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
                                .anyMatch(vr -> vr.getSize().equalsIgnoreCase(finalSize)
                                        && vr.getColor().equalsIgnoreCase(finalColor));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg",
                                    "This variant (Size + Color) already exists.");
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
                            request.getSession().setAttribute("errorMsg",
                                    "This variant (Size + Color) conflicts with an existing one.");
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
                    request.getSession().setAttribute("errorMsg",
                            "Cannot delete. This variant exists in orders, carts, or import history.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error.");
        }

        response.sendRedirect(request.getContextPath() + "/admin/product/details?id=" + productId);
    }
}
