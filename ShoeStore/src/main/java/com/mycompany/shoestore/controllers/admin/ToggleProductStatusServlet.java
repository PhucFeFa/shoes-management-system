package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleProductStatusServlet", urlPatterns = {"/admin/product/toggle-status"})
public class ToggleProductStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String productId = request.getParameter("id");

        try {
            ProductDAO dao = new ProductDAO();
            boolean success = dao.toggleProductStatus(productId);
            
            if (success) {
                request.getSession().setAttribute("successMsg", "Cập nhật trạng thái sản phẩm thành công!");
            } else {
                request.getSession().setAttribute("errorMsg", "Không thể cập nhật trạng thái.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "Lỗi xử lý hệ thống!");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-products");
    }
}
