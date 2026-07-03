package com.mycompany.shoestore.controllers;

import com.mycompany.shoestore.dao.ReviewDAO;
import com.mycompany.shoestore.models.Review;
import com.mycompany.shoestore.models.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManageReviewServlet", urlPatterns = {
        "/manage-reviews",
        "/manage-reviews/reply",
        "/manage-reviews/hide",
        "/manage-reviews/approve-hide",
        "/manage-reviews/reject-hide"
})
public class ManageReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null || !"Staff".equalsIgnoreCase(currentUser.getRoleName())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        if ("/manage-reviews".equals(path)) {
            String filterStatus = request.getParameter("filter");
            if (filterStatus == null || filterStatus.isEmpty()) {
                filterStatus = "ALL";
            }
            
            // Only fetch PENDING_HIDE if filter is PENDING_HIDE, etc.
            List<Review> reviews = reviewDAO.getAllReviews(filterStatus);
            request.setAttribute("reviews", reviews);
            request.setAttribute("currentFilter", filterStatus);
            request.getRequestDispatcher("/views/shared/manage-reviews.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/manage-reviews");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null || !"Staff".equalsIgnoreCase(currentUser.getRoleName())) {
            boolean isAjax = "true".equals(request.getParameter("ajax"));
            if (isAjax) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String path = request.getServletPath();
        String reviewId = request.getParameter("reviewId");
        boolean isAjax = "true".equals(request.getParameter("ajax"));

        if ("/manage-reviews/reply".equals(path)) {
            String replyComment = request.getParameter("replyComment");
            if (replyComment != null && !replyComment.trim().isEmpty()) {
                reviewDAO.updateStoreReply(reviewId, replyComment, currentUser.getId());
                if (isAjax) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String safeReply = replyComment.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
                    response.getWriter().write("{\"success\":true, \"message\":\"Reply added successfully.\", \"reply\":\"" + safeReply + "\"}");
                    return;
                }
                session.setAttribute("successMessage", "Reply added successfully.");
            } else {
                if (isAjax) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\":false, \"message\":\"Reply cannot be empty.\"}");
                    return;
                }
                session.setAttribute("errorMessage", "Reply cannot be empty.");
            }
        } else if ("/manage-reviews/hide".equals(path)) {
            String reason = request.getParameter("hideReason");
            if (reason != null && !reason.trim().isEmpty()) {
                reviewDAO.updateReviewModeration(reviewId, "PENDING_HIDE", reason);
                if (isAjax) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    String safeReason = reason.replace("\"", "\\\"").replace("\n", "\\n").replace("\r", "");
                    response.getWriter().write("{\"success\":true, \"message\":\"Review flagged and hidden successfully.\", \"reason\":\"" + safeReason + "\"}");
                    return;
                }
                session.setAttribute("successMessage", "Review flagged and hidden successfully.");
            } else {
                if (isAjax) {
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("{\"success\":false, \"message\":\"Hide reason is required.\"}");
                    return;
                }
                session.setAttribute("errorMessage", "Hide reason is required.");
            }
        }

        if (isAjax) return;

        String filter = request.getParameter("filter");
        String redirectUrl = request.getContextPath() + "/manage-reviews";
        if (filter != null && !filter.isEmpty()) {
            redirectUrl += "?filter=" + filter;
        }
        if (reviewId != null && !reviewId.isEmpty()) {
            redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "open=" + reviewId;
        }
        response.sendRedirect(redirectUrl);
    }

}
