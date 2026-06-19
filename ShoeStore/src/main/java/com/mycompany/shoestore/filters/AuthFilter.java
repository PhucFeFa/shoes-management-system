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
import java.util.Arrays;
import java.util.List;

@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    private static final List<String> PUBLIC_URLS = Arrays.asList(
            "/home", "/login", "/Logout", "/products", "/product-detail"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpRes = (HttpServletResponse) response;
        String contextPath = httpReq.getContextPath();
        String uri = httpReq.getRequestURI();
        String path = uri.substring(contextPath.length());

        if (path.startsWith("/assets/") || path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.startsWith("/fonts/")
                || path.endsWith(".css") || path.endsWith(".js")
                || path.endsWith(".png") || path.endsWith(".jpg") || path.endsWith(".jpeg")
                || path.endsWith(".gif") || path.endsWith(".ico") || path.endsWith(".svg")) {
            chain.doFilter(request, response);
            return;
        }

        for (String publicUrl : PUBLIC_URLS) {
            if (path.equals(publicUrl) || path.equals("/") || path.isEmpty()) {
                chain.doFilter(request, response);
                return;
            }
        }

        HttpSession session = httpReq.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            httpRes.sendRedirect(contextPath + "/login");
            return;
        }

        String roleName = currentUser.getRoleName();

        if (path.startsWith("/admin") || path.equals("/dashboard") || path.equals("/manage-account") || path.equals("/import")) {
            if (!"Admin".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        if (path.startsWith("/staff")) {
            if (!"Staff".equalsIgnoreCase(roleName) && !"Admin".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        if (path.startsWith("/customer") || path.equals("/Cart")
                || path.equals("/AddToCart") || path.equals("/UpdateCart") || path.equals("/RemoveCart")
                || path.equals("/profile")
                || path.equals("/AddAddress") || path.equals("/EditAddress") || path.equals("/DeleteAddress")) {
            if (!"Customer".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
