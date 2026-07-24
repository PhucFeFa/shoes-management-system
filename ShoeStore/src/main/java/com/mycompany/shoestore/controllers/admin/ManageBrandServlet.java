package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Brand;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageBrandServlet", urlPatterns = {"/admin/manage-brands"})
public class ManageBrandServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDAO dao = new ProductDAO();
            List<Brand> brands = dao.getAllBrands();
            
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String q = searchQuery.toLowerCase().trim();
                brands = brands.stream()
                        .filter(b -> b.getName().toLowerCase().contains(q))
                        .collect(java.util.stream.Collectors.toList());
            }
            
            int pageSize = 10;
            int totalBrands = brands.size();
            int totalPages = (int) Math.ceil((double) totalBrands / pageSize);
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
            int endIndex = Math.min(startIndex + pageSize, totalBrands);
            List<Brand> paginatedBrands = brands.subList(startIndex, endIndex);
            
            request.setAttribute("brands", paginatedBrands);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalBrands", totalBrands);
            request.setAttribute("rangeStart", totalBrands == 0 ? 0 : startIndex + 1);
            request.setAttribute("rangeEnd", endIndex);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("activePage", "manage-brands");
            request.getRequestDispatcher("/views/admin/manage-brands.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        ProductDAO dao = new ProductDAO();
        
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                if (name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMsg", "Brand name cannot be empty.");
                } else {
                    name = name.trim();
                    if (name.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Brand name cannot consist only of numbers.");
                    } else {
                        String finalName = name;
                        boolean exists = dao.getAllBrands().stream().anyMatch(b -> b.getName().equalsIgnoreCase(finalName));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This brand already exists in the system.");
                        } else {
                            dao.getOrCreateBrand(finalName);
                            request.getSession().setAttribute("successMsg", "Successfully added new brand: " + finalName);
                        }
                    }
                }
            } else if ("edit".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                if (id == null || name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMsg", "Brand name cannot be empty.");
                } else {
                    name = name.trim();
                    if (name.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Brand name cannot consist only of numbers.");
                    } else {
                        String finalName = name;
                        String finalId = id;
                        boolean exists = dao.getAllBrands().stream().anyMatch(b -> b.getName().equalsIgnoreCase(finalName) && !b.getId().equals(finalId));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This brand name conflicts with an existing brand.");
                        } else {
                            boolean success = dao.updateBrand(id, name);
                            if (success) {
                                request.getSession().setAttribute("successMsg", "Brand updated successfully.");
                            } else {
                                request.getSession().setAttribute("errorMsg", "Failed to update brand.");
                            }
                        }
                    }
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                boolean success = dao.deleteBrand(id);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Brand deleted successfully.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Cannot delete. This brand contains products!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-brands");
    }
}
