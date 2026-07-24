package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.UserDAO;
import com.mycompany.shoestore.dto.UserDTO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="ManageAccountServlet", urlPatterns={"/manage-account"})
public class ManageAccountServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        UserDAO userDao = new UserDAO();
        List<UserDTO> userList = userDao.getAllCustomers();
        
        String searchQuery = request.getParameter("search");
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            String q = searchQuery.toLowerCase().trim();
            userList = userList.stream()
                    .filter(u -> (u.getFullName() != null && u.getFullName().toLowerCase().contains(q)) || 
                                 (u.getEmail() != null && u.getEmail().toLowerCase().contains(q)))
                    .collect(java.util.stream.Collectors.toList());
        }
        
        int pageSize = 10;
        int totalUsers = userList.size();
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);
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
        int endIndex = Math.min(startIndex + pageSize, totalUsers);
        List<UserDTO> paginatedUsers = userList.subList(startIndex, endIndex);
        
        request.setAttribute("users", paginatedUsers);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("rangeStart", totalUsers == 0 ? 0 : startIndex + 1);
        request.setAttribute("rangeEnd", endIndex);
        request.setAttribute("searchQuery", searchQuery);
        // Thêm dấu gạch chéo hợp lệ ở đầu đường dẫn điều hướng
        request.getRequestDispatcher("/views/admin/user.jsp").forward(request, response);
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }
}