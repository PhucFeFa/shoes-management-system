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

@WebServlet(name = "ManageVoucherServlet", urlPatterns = {"/manage-voucher"})
public class ManageVoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        VoucherDAO dao = new VoucherDAO();
        List<VoucherDTO> list = dao.getAllVouchers();
        
        request.setAttribute("VOUCHER_LIST", list);
        request.setAttribute("activePage", "voucher");
        
        request.getRequestDispatcher("/views/admin/voucher-list.jsp").forward(request, response);
    }
}
