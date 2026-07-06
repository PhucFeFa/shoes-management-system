// Author: PhucLHCE191132
package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "ToggleStaffStatusServlet", urlPatterns = {"/admin/staff/toggle-status"})
public class ToggleStaffStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String currentStatus = request.getParameter("currentStatus");
        
        if (id != null && currentStatus != null) {
            String newStatus = "Active".equalsIgnoreCase(currentStatus) ? "Inactive" : "Active";
            
            try {
                StaffDAO staffDAO = new StaffDAO();
                if (staffDAO.updateStatus(id, newStatus)) {
                    request.getSession().setAttribute("successMsg", "Staff status updated to " + newStatus);
                } else {
                    request.getSession().setAttribute("errorMsg", "Failed to update status.");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("errorMsg", "An unexpected error occurred.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/manage-staff");
    }
}
