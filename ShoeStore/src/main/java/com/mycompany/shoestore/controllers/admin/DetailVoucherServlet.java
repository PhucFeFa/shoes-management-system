/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "DetailVoucherServlet", urlPatterns = {"/manage-voucher/view"})
public class DetailVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        VoucherDTO detailVoucher = null;

        if (id != null && !id.trim().isEmpty()) {
            VoucherDAO dao = new VoucherDAO();
            List<VoucherDTO> list = dao.getAllVouchers();
            
            // Tìm kiếm phần tử có ID trùng khớp trong danh sách mà không cần sửa DAO
            for (VoucherDTO v : list) {
                if (v.getId().equals(id)) {
                    detailVoucher = v;
                    break;
                }
            }
        }

        // Đẩy đối tượng chi tiết sang trang JSP
        request.setAttribute("VOUCHER_DETAIL", detailVoucher);
        request.setAttribute("activePage", "voucher");
        
        request.getRequestDispatcher("/views/admin/detail-voucher.jsp").forward(request, response);
    }
}