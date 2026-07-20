package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import com.mycompany.shoestore.models.Category;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageCategoryServlet", urlPatterns = {"/admin/manage-categories"})
public class ManageCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ProductDAO dao = new ProductDAO();
            List<Category> categories = dao.getAllCategories();
            
            request.setAttribute("categories", categories);
            request.setAttribute("activePage", "manage-categories");
            request.getRequestDispatcher("/views/admin/manage-categories.jsp").forward(request, response);
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
                    request.getSession().setAttribute("errorMsg", "Category name cannot be empty.");
                } else {
                    name = name.trim();
                    if (name.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Category name cannot consist only of numbers.");
                    } else {
                        String finalName = name;
                        boolean exists = dao.getAllCategories().stream().anyMatch(c -> c.getName().equalsIgnoreCase(finalName));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This category already exists in the system.");
                        } else {
                            dao.getOrCreateCategory(finalName);
                            request.getSession().setAttribute("successMsg", "Successfully added new category: " + finalName);
                        }
                    }
                }
            } else if ("edit".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                if (id == null || name == null || name.trim().isEmpty()) {
                    request.getSession().setAttribute("errorMsg", "Category name cannot be empty.");
                } else {
                    name = name.trim();
                    if (name.matches("\\d+")) {
                        request.getSession().setAttribute("errorMsg", "Category name cannot consist only of numbers.");
                    } else {
                        String finalName = name;
                        String finalId = id;
                        boolean exists = dao.getAllCategories().stream().anyMatch(c -> c.getName().equalsIgnoreCase(finalName) && !c.getId().equals(finalId));
                        if (exists) {
                            request.getSession().setAttribute("errorMsg", "This category name conflicts with an existing category.");
                        } else {
                            boolean success = dao.updateCategory(id, name);
                            if (success) {
                                request.getSession().setAttribute("successMsg", "Category updated successfully.");
                            } else {
                                request.getSession().setAttribute("errorMsg", "Failed to update category.");
                            }
                        }
                    }
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                boolean success = dao.deleteCategory(id);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Category deleted successfully.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Cannot delete. This category contains products!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "System error.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
    }
}
