package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.AddressDAO;
import com.mycompany.shoestore.models.Address;
import com.mycompany.shoestore.models.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AddAddress", urlPatterns = {"/AddAddress"})
public class AddAddressServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        
    HttpSession session = request.getSession(false);

    User currentUser = (User) session.getAttribute("currentUser");

    AddressDAO dao = new AddressDAO();
    List<Address> addresses =
            dao.getAddressesByUserId(currentUser.getId());

    request.setAttribute("addresses", addresses);
    request.getRequestDispatcher("/addAddress.jsp")
            .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String city = request.getParameter("city");
        String district = request.getParameter("district");
        String ward = request.getParameter("ward");
        String addressLine = request.getParameter("addressLine");

        // Validation
        if (city == null || city.trim().isEmpty()
                || district == null || district.trim().isEmpty()
                || ward == null || ward.trim().isEmpty()
                || addressLine == null || addressLine.trim().isEmpty()) {

            request.setAttribute("error",
                    "Address information is invalid");

            request.getRequestDispatcher("/addAddress.jsp")
                    .forward(request, response);
            return;
        }

        // Lấy user từ session
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Lấy userId từ user đăng nhập
        String userId = currentUser.getId();

        Address address = new Address(
                userId,
                city,
                district,
                ward,
                addressLine
        );

        AddressDAO dao = new AddressDAO();

        boolean success = dao.addAddress(address);

        if (success) {
            request.setAttribute("message",
                    "Address added successfully");
        } else {
            request.setAttribute("error",
                    "Failed to add address");
        }

        request.getRequestDispatcher("/addAddress.jsp")
                .forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Add Address Servlet";
    }
}