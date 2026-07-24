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
        
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String q = searchQuery.toLowerCase().trim();
            list = list.stream()
                    .filter(v -> v.getCode() != null && v.getCode().toLowerCase().contains(q))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        int pageSize = 10;
        int totalVouchers = list.size();
        int totalPages = (int) Math.ceil((double) totalVouchers / pageSize);
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
        int endIndex = Math.min(startIndex + pageSize, totalVouchers);
        List<VoucherDTO> paginatedVouchers = list.subList(startIndex, endIndex);
        
        request.setAttribute("VOUCHER_LIST", paginatedVouchers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalVouchers", totalVouchers);
        request.setAttribute("rangeStart", totalVouchers == 0 ? 0 : startIndex + 1);
        request.setAttribute("rangeEnd", endIndex);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("activePage", "voucher");
        
        request.getRequestDispatcher("/views/admin/voucher-list.jsp").forward(request, response);
    }
}
