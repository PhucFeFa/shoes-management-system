package com.mycompany.shoestore.controllers.staff;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "StaffDashboardServlet", urlPatterns = {"/staff/dashboard"})
public class StaffDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // For now, redirect to staff orders as the main dashboard for staff
        response.sendRedirect(request.getContextPath() + "/staff/orders");
    }
}
