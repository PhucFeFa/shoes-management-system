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
        "/staff/manage-reviews",
        "/staff/manage-reviews/reply",
        "/staff/manage-reviews/hide",
        "/staff/manage-reviews/approve-hide",
        "/staff/manage-reviews/reject-hide"
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
        if ("/staff/manage-reviews".equals(path)) {
            String filterStatus = request.getParameter("filter");
            if (filterStatus == null || filterStatus.isEmpty()) {
                filterStatus = "ALL";
            }
            
            // Only fetch PENDING_HIDE if filter is PENDING_HIDE, etc.
            List<Review> reviews = reviewDAO.getAllReviews(filterStatus);
            
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                String q = search.trim().toLowerCase();
                reviews = reviews.stream()
                        .filter(r -> (r.getComment() != null && r.getComment().toLowerCase().contains(q)) || 
                                     (r.getProductName() != null && r.getProductName().toLowerCase().contains(q)) ||
                                     (r.getUserName() != null && r.getUserName().toLowerCase().contains(q)))
                        .collect(java.util.stream.Collectors.toList());
            }

            int pageSize = 10;
            int totalReviews = reviews.size();
            int totalPages = (int) Math.ceil((double) totalReviews / pageSize);
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
            int endIndex = Math.min(startIndex + pageSize, totalReviews);
            List<Review> paginatedReviews = reviews.subList(startIndex, endIndex);

            request.setAttribute("reviews", paginatedReviews);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalReviews", totalReviews);
            request.setAttribute("rangeStart", totalReviews == 0 ? 0 : startIndex + 1);
            request.setAttribute("rangeEnd", endIndex);
            request.setAttribute("searchQuery", search);
            request.setAttribute("currentFilter", filterStatus);
            request.getRequestDispatcher("/views/shared/manage-reviews.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/staff/manage-reviews");
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

        if ("/staff/manage-reviews/reply".equals(path)) {
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
        } else if ("/staff/manage-reviews/hide".equals(path)) {
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
        String redirectUrl = request.getContextPath() + "/staff/manage-reviews";
        if (filter != null && !filter.isEmpty()) {
            redirectUrl += "?filter=" + filter;
        }
        if (reviewId != null && !reviewId.isEmpty()) {
            redirectUrl += (redirectUrl.contains("?") ? "&" : "?") + "open=" + reviewId;
        }
        response.sendRedirect(redirectUrl);
    }

}
