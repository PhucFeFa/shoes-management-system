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
            "/home", "/login", "/Logout", "/products", "/ProductDetail",
            "/register", "/forgot-password", "/reset-password", "/verify-forgot-otp", "/verify-otp"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

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

        // Admin URLs only accessible by Admin
        if (path.equals("/admin") || path.startsWith("/admin/") || path.equals("/dashboard") || path.equals("/import") 
            || path.startsWith("/manage-account") || path.startsWith("/manage-voucher") 
            || path.equals("/create-voucher") || path.equals("/status-account") || path.startsWith("/admin/audit-log")) {
            if (!"Admin".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        // Staff URLs only accessible by Staff
        if (path.startsWith("/staff")) {
            if (!"Staff".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        if (path.startsWith("/profile") || path.equals("/Cart")
                || path.equals("/AddToCart") || path.equals("/UpdateCart") || path.equals("/RemoveCart")
                || path.equals("/AddAddress") || path.equals("/EditAddress") || path.equals("/DeleteAddress")
                || path.equals("/checkout") || path.equals("/place-order") || path.equals("/order-success")) {
            if (!"Customer".equalsIgnoreCase(roleName)) {
                httpRes.sendRedirect(contextPath + "/home");
                return;
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
