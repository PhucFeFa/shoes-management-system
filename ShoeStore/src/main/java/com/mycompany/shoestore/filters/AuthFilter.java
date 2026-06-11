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

/**
 * AuthFilter guards all URLs under /staff/*.
 * - Unauthenticated users are redirected to /login.
 * - Authenticated users without staff or admin role are redirected to /home.
 *
 * NOTE: @WebFilter is disabled during development/testing.
 * Uncomment the annotation below to enable role-based access control.
 */
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
            // Not logged in → redirect to login page
            httpRes.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        String roleName = currentUser.getRoleName();
        if (!"staff".equalsIgnoreCase(roleName) && !"admin".equalsIgnoreCase(roleName)) {
            // Logged in but not authorized → redirect to home
            httpRes.sendRedirect(httpReq.getContextPath() + "/home");
            return;
        }

        // Authorized → continue
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
