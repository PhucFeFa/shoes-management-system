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
            
            request.setAttribute("brands", brands);
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
                if (name != null && !name.trim().isEmpty()) {
                    dao.getOrCreateBrand(name.trim());
                    request.getSession().setAttribute("successMsg", "Đã thêm thương hiệu mới: " + name);
                } else {
                    request.getSession().setAttribute("errorMsg", "Tên thương hiệu không hợp lệ.");
                }
            } else if ("edit".equals(action)) {
                String id = request.getParameter("id");
                String name = request.getParameter("name");
                if (id != null && name != null && !name.trim().isEmpty()) {
                    boolean success = dao.updateBrand(id, name.trim());
                    if (success) {
                        request.getSession().setAttribute("successMsg", "Đã cập nhật thương hiệu thành công.");
                    } else {
                        request.getSession().setAttribute("errorMsg", "Cập nhật thất bại.");
                    }
                }
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                boolean success = dao.deleteBrand(id);
                if (success) {
                    request.getSession().setAttribute("successMsg", "Đã xóa thương hiệu thành công.");
                } else {
                    request.getSession().setAttribute("errorMsg", "Không thể xóa. Thương hiệu này đang chứa sản phẩm!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Lỗi hệ thống.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-brands");
    }
}
