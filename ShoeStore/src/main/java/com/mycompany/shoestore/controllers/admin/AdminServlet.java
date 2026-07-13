package com.mycompany.shoestore.controllers.admin;

import com.mycompany.shoestore.dao.StatisticsDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin"})
public class AdminServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        StatisticsDAO statsDAO = new StatisticsDAO();
        
        // Fetch monthly stats
        double monthlyRevenue = statsDAO.getMonthlyRevenue();
        double monthlyCost = statsDAO.getMonthlyCost();
        double successRate = statsDAO.getMonthlySuccessRate();
        
        // Fetch chart data
        List<Map<String, Object>> chartData = statsDAO.getRevenueAndCostByMonth();
        
        // Fetch top selling items
        List<Map<String, Object>> topSellingItems = statsDAO.getTopSellingItems();
        
        // Set attributes for JSP
        request.setAttribute("monthlyRevenue", monthlyRevenue);
        request.setAttribute("monthlyCost", monthlyCost);
        request.setAttribute("successRate", successRate);
        request.setAttribute("chartData", chartData);
        request.setAttribute("topSellingItems", topSellingItems);
        
        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
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
