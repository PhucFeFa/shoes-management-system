// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.StaffDAO;
import com.mycompany.shoestore.models.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;

@WebServlet(name = "CreateStaffServlet", urlPatterns = {"/admin/staff/create"})
public class CreateStaffServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        
        // Basic backend validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.getSession().setAttribute("errorMsg", "Email and Password are required.");
            response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
            return;
        }

        try {
            StaffDAO staffDAO = new StaffDAO();
            
            // Check if email exists
            if (staffDAO.isEmailExist(email, null)) {
                request.getSession().setAttribute("errorMsg", "Email already exists.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
                return;
            }

            Staff staff = new Staff();
            staff.setEmail(email.trim());
            staff.setFullName(fullName.trim());
            staff.setPasswordHash(BCrypt.hashpw(password.trim(), BCrypt.gensalt()));
            staff.setStatus("Active");

            if (staffDAO.createStaff(staff)) {
                request.getSession().setAttribute("successMsg", "Staff added successfully.");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to add staff.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "An unexpected error occurred.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
    }
}
