/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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

@WebServlet(name = "DetailAccountServlet", urlPatterns = {"/manage-account/view"})
public class DetailAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        UserDTO detailUser = null;

        if (id != null && !id.trim().isEmpty()) {
            UserDAO dao = new UserDAO();
            List<UserDTO> list = dao.getAllCustomers();
            
         
            for (UserDTO u : list) {
                if (u.getId().equals(id)) {
                    detailUser = u;
                    break;
                }
            }
        }

       
        request.setAttribute("USER_DETAIL", detailUser);
        request.setAttribute("activePage", "user"); // Giúp sidebar giữ trạng thái active menu quản lý user
        
        request.getRequestDispatcher("/views/admin/detail-account.jsp").forward(request, response);
    }
}