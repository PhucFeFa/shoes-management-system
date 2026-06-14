// Author: baolgce191178
package com.mycompany.shoestore.filters;

import com.mycompany.shoestore.models.User;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

// @WebFilter(urlPatterns = {"/staff/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        HttpSession session = httpReq.getSession(false);

        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        String roleName = currentUser.getRoleName();
        if (!"staff".equalsIgnoreCase(roleName) && !"admin".equalsIgnoreCase(roleName)) {
            httpRes.sendRedirect(httpReq.getContextPath() + "/home");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
