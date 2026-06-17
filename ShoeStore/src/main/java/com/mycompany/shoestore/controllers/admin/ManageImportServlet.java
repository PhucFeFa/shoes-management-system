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
        
        // Đẩy dữ liệu sang tầng hiển thị (JSP)
        request.setAttribute("importList", importList);
        
        // Điều hướng tới file import-list.jsp nằm trong thư mục /views/admin/
        request.getRequestDispatcher("/views/admin/import-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}