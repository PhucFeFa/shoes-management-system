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

        request.setAttribute("importRequests", requests);
        request.getRequestDispatcher("/views/staff/view-request.jsp").forward(request, response);
    }
}
