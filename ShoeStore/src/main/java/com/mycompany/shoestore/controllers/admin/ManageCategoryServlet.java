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
                if (name != null && !name.trim().isEmpty()) {
                    dao.getOrCreateCategory(name.trim());
                    request.getSession().setAttribute("successMsg", "Đã thêm danh mục mới: " + name);
                } else {
                    request.getSession().setAttribute("errorMsg", "Tên danh mục không hợp lệ.");
                }
            } else if ("edit".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                if (id != null && name != null && !name.trim().isEmpty()) {
                    boolean success = dao.updateCategory(id, name.trim());
                    if (success) {
                        request.getSession().setAttribute("successMsg", "Đã cập nhật danh mục thành công.");
                    } else {
                        request.getSession().setAttribute("errorMsg", "Cập nhật thất bại.");
                    }
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                boolean success = dao.deleteCategory(id);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Đã xóa danh mục thành công.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Không thể xóa. Danh mục này đang chứa sản phẩm!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Lỗi hệ thống.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-categories");
    }
}
