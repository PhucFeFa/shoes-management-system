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
import java.util.List;

@WebServlet(name = "ManageStaffServlet", urlPatterns = {"/admin/manage-staff"})
public class ManageStaffServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            StaffDAO staffDAO = new StaffDAO();
            List<Staff> staffs = staffDAO.getAllStaffs();
            request.setAttribute("staffs", staffs);
            request.setAttribute("activePage", "staff");
            request.getRequestDispatcher("/views/admin/manage-staff.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
