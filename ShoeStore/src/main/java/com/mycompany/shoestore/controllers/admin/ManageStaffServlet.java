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
            
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String q = searchQuery.toLowerCase().trim();
                staffs = staffs.stream()
                        .filter(s -> (s.getFullName() != null && s.getFullName().toLowerCase().contains(q)) || 
                                     (s.getEmail() != null && s.getEmail().toLowerCase().contains(q)))
                        .collect(java.util.stream.Collectors.toList());
            }
            
            int pageSize = 10;
            int totalStaffs = staffs.size();
            int totalPages = (int) Math.ceil((double) totalStaffs / pageSize);
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
            int endIndex = Math.min(startIndex + pageSize, totalStaffs);
            List<Staff> paginatedStaffs = staffs.subList(startIndex, endIndex);
            
            request.setAttribute("staffs", paginatedStaffs);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalStaffs", totalStaffs);
            request.setAttribute("rangeStart", totalStaffs == 0 ? 0 : startIndex + 1);
            request.setAttribute("rangeEnd", endIndex);
            request.setAttribute("searchQuery", searchQuery);
            request.setAttribute("activePage", "staff");
            request.getRequestDispatcher("/views/admin/manage-staff.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/dashboard");
        }
    }
}
