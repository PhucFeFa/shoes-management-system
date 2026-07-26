/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author default
 */
@WebServlet(name="ChangeStatusAccountServlet", urlPatterns={"/status-account"})
public class ChangeStatusAccountServlet extends HttpServlet {
   
    /** * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy ID tài khoản và trạng thái hiện tại truyền từ nút bấm trên giao diện JSP
        String userId = request.getParameter("id");
        String currentStatus = request.getParameter("currentStatus");

        if (userId != null && currentStatus != null) {
            UserDAO userDAO = new UserDAO();
            
            // Thực hiện thay đổi trạng thái dưới Database thông qua UserDAO
            boolean isUpdated = userDAO.changeStatus(userId, currentStatus);
            
            if (isUpdated) {
                request.getSession().setAttribute("successMsg", "Account status updated successfully!");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to update account status.");
            }
        }

        // Sau khi xử lý xong xuôi, chuyển hướng thẳng về trang danh sách tài khoản
        response.sendRedirect(request.getContextPath() + "/manage-account");
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}