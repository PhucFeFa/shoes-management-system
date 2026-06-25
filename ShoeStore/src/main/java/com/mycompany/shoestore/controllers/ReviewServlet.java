// Author: PhucLHCE191132
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

@WebServlet(name = "ReviewServlet", urlPatterns = {"/review"})
public class ReviewServlet extends HttpServlet {

    private final ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");
        
        if (productId == null || productId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String redirectUrl = request.getContextPath() + "/ProductDetail?id=" + productId;

        try {
            if ("add".equals(action)) {
                // Kiểm tra điều kiện: chỉ thêm khi đã mua hàng và đơn hàng hoàn thành
                if (!reviewDAO.canUserReview(currentUser.getId(), productId)) {
                    session.setAttribute("error", "You can only review products that have been delivered to you.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                // Kiểm tra xem đã review chưa, mỗi user chỉ 1 review/sản phẩm
                if (reviewDAO.getReviewByUserAndProduct(currentUser.getId(), productId) != null) {
                    session.setAttribute("error", "You have already reviewed this product.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                int rating = parseRating(request.getParameter("rating"));
                String comment = sanitizeComment(request.getParameter("comment"));

                if (rating < 1 || rating > 5) {
                    session.setAttribute("error", "Invalid rating. Rating must be between 1 and 5.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                if (comment.isEmpty()) {
                    session.setAttribute("error", "Review comment cannot be empty.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                Review newReview = new Review();
                newReview.setUserId(currentUser.getId());
                newReview.setProductId(productId);
                newReview.setRating(rating);
                newReview.setComment(comment);

                if (reviewDAO.addReview(newReview)) {
                    session.setAttribute("success", "Thank you for your review!");
                } else {
                    session.setAttribute("error", "Failed to submit review.");
                }

            } else if ("update".equals(action)) {
                String reviewId = request.getParameter("reviewId");
                int rating = parseRating(request.getParameter("rating"));
                String comment = sanitizeComment(request.getParameter("comment"));

                if (rating < 1 || rating > 5) {
                    session.setAttribute("error", "Invalid rating. Rating must be between 1 and 5.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                if (comment.isEmpty()) {
                    session.setAttribute("error", "Review comment cannot be empty.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                Review existingReview = reviewDAO.getReviewByUserAndProduct(currentUser.getId(), productId);
                if (existingReview == null) {
                    session.setAttribute("error", "Review not found.");
                    response.sendRedirect(redirectUrl);
                    return;
                }
                
                if (existingReview.isUpdated()) {
                    session.setAttribute("error", "You can only update your review once.");
                    response.sendRedirect(redirectUrl);
                    return;
                }

                Review updateReview = new Review();
                updateReview.setId(reviewId);
                updateReview.setUserId(currentUser.getId());
                updateReview.setRating(rating);
                updateReview.setComment(comment);
                updateReview.setPreviousComment(existingReview.getComment());

                if (reviewDAO.updateReview(updateReview)) {
                    session.setAttribute("success", "Review updated successfully.");
                } else {
                    session.setAttribute("error", "Failed to update review.");
                }

            } else if ("delete".equals(action)) {
                String reviewId = request.getParameter("reviewId");
                
                if (reviewDAO.deleteReview(reviewId, currentUser.getId())) {
                    session.setAttribute("success", "Review deleted successfully.");
                } else {
                    session.setAttribute("error", "Failed to delete review.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "An unexpected error occurred.");
        }

        response.sendRedirect(redirectUrl);
    }

    private int parseRating(String ratingStr) {
        try {
            return Integer.parseInt(ratingStr);
        } catch (NumberFormatException e) {
            return 0; // Invalid rating
        }
    }

    private String sanitizeComment(String comment) {
        if (comment == null) return "";
        // Ngăn chặn XSS cơ bản
        return comment.replaceAll("<", "&lt;").replaceAll(">", "&gt;").trim();
    }
}
