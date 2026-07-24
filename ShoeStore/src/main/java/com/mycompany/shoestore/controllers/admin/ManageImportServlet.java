package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.ImportDAO;
import com.mycompany.shoestore.dto.ImportDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ManageImportServlet", urlPatterns = {"/import"})
public class ManageImportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Gọi DAO lấy dữ liệu
        ImportDAO importDAO = new ImportDAO();
        List<ImportDTO> importList = importDAO.getAllImports();
        
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String q = searchQuery.toLowerCase().trim();
            importList = importList.stream()
                    .filter(i -> (i.getSupplier() != null && i.getSupplier().toLowerCase().contains(q)) || 
                                 (i.getStaffName() != null && i.getStaffName().toLowerCase().contains(q)))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        int pageSize = 10;
        int totalImports = importList.size();
        int totalPages = (int) Math.ceil((double) totalImports / pageSize);
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
        int endIndex = Math.min(startIndex + pageSize, totalImports);
        List<ImportDTO> paginatedImports = importList.subList(startIndex, endIndex);
        
        request.setAttribute("importList", paginatedImports);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalImports", totalImports);
        request.setAttribute("rangeStart", totalImports == 0 ? 0 : startIndex + 1);
        request.setAttribute("rangeEnd", endIndex);
        request.setAttribute("searchQuery", searchQuery);
        
        // Điều hướng tới file import-list.jsp nằm trong thư mục /views/admin/
        request.getRequestDispatcher("/views/admin/import-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}