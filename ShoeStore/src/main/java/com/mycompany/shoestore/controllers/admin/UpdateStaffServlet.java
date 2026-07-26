// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.StaffDAO;
import com.mycompany.shoestore.models.Staff;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "UpdateStaffServlet", urlPatterns = {"/admin/staff/update"})
public class UpdateStaffServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        
        if (id == null || email == null || email.trim().isEmpty() || fullName == null || fullName.trim().isEmpty()) {
            request.getSession().setAttribute("errorMsg", "Full Name and Email are required and cannot be empty.");
            response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
            return;
        }

        try {
            StaffDAO staffDAO = new StaffDAO();
            
            // Check if email exists for other users
            if (staffDAO.isEmailExist(email.trim(), id)) {
                request.getSession().setAttribute("errorMsg", "Email already exists.");
                response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
                return;
            }

            Staff staff = new Staff();
            staff.setId(id);
            staff.setEmail(email.trim());
            staff.setFullName(fullName.trim());
            
            String password = request.getParameter("password");
            if (password != null && !password.trim().isEmpty()) {
                staff.setPasswordHash(org.mindrot.jbcrypt.BCrypt.hashpw(password.trim(), org.mindrot.jbcrypt.BCrypt.gensalt()));
            }
            if (staffDAO.updateStaff(staff)) {
                request.getSession().setAttribute("successMsg", "Staff updated successfully.");
            } else {
                request.getSession().setAttribute("errorMsg", "Failed to update staff.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMsg", "An unexpected error occurred.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
    }
}
