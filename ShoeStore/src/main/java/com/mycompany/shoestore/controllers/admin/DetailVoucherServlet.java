package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.VoucherDAO;
import com.mycompany.shoestore.dto.VoucherDTO;
import java.io.IOException;
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
        VoucherDAO dao = new VoucherDAO();
        VoucherDTO detailVoucher = null;

        if (id != null && !id.trim().isEmpty()) {
            detailVoucher = dao.getVoucherDTOById(id);
        }

        if (detailVoucher == null) {
            response.sendRedirect(request.getContextPath() + "/manage-voucher");
            return;
        }

        request.setAttribute("VOUCHER_DETAIL", detailVoucher);
        request.setAttribute("activePage", "voucher");
        
        request.getRequestDispatcher("/views/admin/detail-voucher.jsp").forward(request, response);
    }
}
