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
        
        request.setAttribute("users", userList);
        
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