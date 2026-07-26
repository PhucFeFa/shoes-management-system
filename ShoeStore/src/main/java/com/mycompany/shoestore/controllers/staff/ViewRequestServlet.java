package com.mycompany.shoestore.controllers.staff;

import com.mycompany.shoestore.dao.ImportDAO;
import com.mycompany.shoestore.dto.ImportDTO;
import com.mycompany.shoestore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewRequestServlet", urlPatterns = {"/staff/view-request"})
public class ViewRequestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null || !"Staff".equalsIgnoreCase(user.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        ImportDAO importDAO = new ImportDAO();
        List<ImportDTO> requests = importDAO.ViewRequset(user.getId());

        String search = request.getParameter("search");
        if (search != null && !search.trim().isEmpty()) {
            String q = search.trim().toLowerCase();
            requests = requests.stream()
                    .filter(r -> (r.getSupplier() != null && r.getSupplier().toLowerCase().contains(q)) ||
                                 (r.getStatus() != null && r.getStatus().toLowerCase().contains(q)) ||
                                 String.valueOf(r.getImportID()).contains(q))
                    .collect(java.util.stream.Collectors.toList());
        }

        int pageSize = 10;
        int totalImportRequests = requests.size();
        int totalPages = (int) Math.ceil((double) totalImportRequests / pageSize);
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
        int endIndex = Math.min(startIndex + pageSize, totalImportRequests);
        List<ImportDTO> paginatedRequests = requests.subList(startIndex, endIndex);

        request.setAttribute("importRequests", paginatedRequests);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalImportRequests", totalImportRequests);
        request.setAttribute("rangeStart", totalImportRequests == 0 ? 0 : startIndex + 1);
        request.setAttribute("rangeEnd", endIndex);
        request.setAttribute("searchQuery", search);
        request.getRequestDispatcher("/views/staff/view-request.jsp").forward(request, response);
    }
}
