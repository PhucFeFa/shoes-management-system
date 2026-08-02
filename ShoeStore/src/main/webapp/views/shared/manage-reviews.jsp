<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Review Management - Staff</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; }
            body {
                background: #f5f5f3;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                margin: 0;
                overflow-y: scroll;
            }
            .main-content {
                margin-left: 256px;
                padding: 32px 36px;
                min-height: 100vh;
                width: calc(100% - 256px); box-sizing: border-box;
            }
            .page-header {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .page-title {
                font-size: 13px;
                font-weight: 700;
                letter-spacing: .12em;
                text-transform: uppercase;
                color: #1a1a1a;
                margin: 0;
            }
            .table-card {
                background: #fff;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                overflow-x: auto;
            }
            .user-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 900px;
            }
            .user-table thead tr {
                border-bottom: 2px solid #e8e8e8;
            }
            .user-table thead th {
                font-size: 11px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                color: #1a1a1a;
                padding: 14px 16px;
                white-space: nowrap;
                overflow: hidden;
            }
            .user-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .user-table tbody tr:last-child { border-bottom: none; }
            .user-table tbody tr:hover { background: #fafafa; }
            .user-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .cell-no {
                font-size: 12px;
                color: #bbb;
                font-weight: 600;
            }
            .cell-name {
                font-weight: 600;
                color: #1a1a1a;
            }
            .cell-brand, .cell-category {
                font-size: 12px;
                color: #555;
            }
            .cell-price {
                font-weight: 600;
                color: #1a1a1a;
            }
            .status-badge {
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                padding: 4px 10px;
                display: inline-block;
                white-space: nowrap;
                border-radius: 4px;
            }
            .badge-approved { background: #e6f4ea; color: #1e7e34; }
            .badge-flagged { background: #fdf6b2; color: #723b13; }
            
            .action-wrap {
                display: flex;
                gap: 6px;
                justify-content: center;
                align-items: center;
                flex-wrap: nowrap;
            }
            .btn-action {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 10px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 6px 12px;
                text-decoration: none;
                white-space: nowrap;
                border-radius: 4px;
                transition: all 0.2s ease;
                line-height: 1.2;
                border: 1px solid transparent;
                cursor: pointer;
                min-width: 60px;
            }
            .btn-view {
                background-color: #f1f1f1;
                color: #333;
                border: 1px solid transparent;
            }
            .btn-view:hover {
                background-color: #e2e2e2;
                color: #000;
            }
            
            .form-control:focus, .form-select:focus {
                box-shadow: none;
                border-color: #dee2e6;
            }
            .input-group-text, .form-control, .form-select {
                border-color: #dee2e6;
            }
            .empty-row td {
                text-align: center;
                padding: 48px;
                font-size: 12px;
                color: #aaa;
                letter-spacing: .06em;
                text-transform: uppercase;
            }

            /* Pagination */
            .pagination-footer {
                padding: 16px;
                border-top: 1px solid #e8e8e8;
                display: flex;
                align-items: center;
                justify-content: space-between;
                background: #fff;
            }
            .pagination-info {
                font-size: 11px;
                font-weight: 600;
                color: #888;
                text-transform: uppercase;
                letter-spacing: .05em;
            }
            .pagination-controls {
                display: flex;
                gap: 6px;
            }
            .page-btn {
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                border: 1px solid #e8e8e8;
                border-radius: 50%;
                font-size: 12px;
                font-weight: 600;
                color: #555;
                text-decoration: none;
                transition: 0.2s;
            }
            .page-btn:hover:not(.disabled) {
                border-color: #1a1a1a;
                color: #1a1a1a;
            }
            .page-btn.active {
                background: #1a1a1a;
                color: #fff;
                border-color: #1a1a1a;
            }
            .page-btn.disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }

            /* Custom Drawer CSS */
            .custom-drawer-overlay {
                position: fixed;
                top: 0; left: 0; right: 0; bottom: 0;
                background: rgba(0, 0, 0, 0.4);
                backdrop-filter: blur(2px);
                z-index: 1050;
                opacity: 1;
                transition: opacity 0.3s ease;
                display: flex;
                justify-content: flex-end;
            }
            .custom-drawer-overlay.hidden-drawer {
                opacity: 0;
                pointer-events: none;
            }
            .custom-drawer-panel {
                width: 100%;
                max-width: 500px;
                background: #fff;
                height: 100%;
                transform: translateX(0);
                transition: transform 0.3s ease;
                display: flex;
                flex-direction: column;
                box-shadow: -4px 0 15px rgba(0,0,0,0.1);
            }
            .custom-drawer-panel.translate-out {
                transform: translateX(100%);
            }
            .drawer-header {
                padding: 24px 32px;
                border-bottom: 1px solid #e8e8e8;
                background: #f9f9f9;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
            .drawer-body {
                padding: 32px;
                flex: 1;
                overflow-y: auto;
            }
            .drawer-footer {
                padding: 24px 32px;
                border-top: 1px solid #e8e8e8;
                background: #fff;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 16px;
            }
            .drawer-title {
                font-size: 18px;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: -0.02em;
                margin: 0;
            }
            .drawer-id {
                font-size: 12px;
                color: #888;
                margin: 4px 0 0 0;
            }
            .section-label {
                font-size: 11px;
                font-weight: 700;
                letter-spacing: .05em;
                text-transform: uppercase;
                color: #555;
                margin-bottom: 8px;
                display: block;
            }
            .product-context {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 16px;
                background: #f9f9f9;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                margin-bottom: 24px;
            }
            .product-context img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 4px;
                background: #eee;
            }
            .feedback-box {
                padding: 20px;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                margin-bottom: 24px;
            }
            .flag-box {
                padding: 16px;
                background: #fdf6b2;
                border: 1px solid #fce96a;
                color: #723b13;
                border-radius: 4px;
                margin-bottom: 24px;
                font-style: italic;
                font-size: 13px;
            }
            .btn-save-reply {
                background: #1a1a1a;
                color: #fff;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: .05em;
                border: none;
                padding: 12px;
                border-radius: 4px;
                cursor: pointer;
                transition: 0.2s;
            }
            .btn-save-reply:hover { background: #333; }
            .btn-flag-review {
                background: #fff;
                color: #b21f2d;
                border: 1px solid #b21f2d;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: .05em;
                padding: 12px;
                border-radius: 4px;
                cursor: pointer;
                transition: 0.2s;
            }
            .btn-flag-review:hover { background: #f8d7da; }
            .rating-stars i { color: #f59e0b; font-size: 16px; }
            
            /* Alerts */
            .alert-custom {
                padding: 16px;
                border-radius: 4px;
                font-size: 13px;
                font-weight: 500;
                margin-bottom: 16px;
            }
            .alert-custom.success { background: #e6f4ea; color: #1e7e34; border: 1px solid #c3e6cb; }
            .alert-custom.error { background: #f8d7da; color: #b21f2d; border: 1px solid #f5c6cb; }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="reviews" scope="request" />
            <jsp:include page="/views/staff/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-chat-square-text" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Review Management</h3>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form method="get" action="${pageContext.request.contextPath}/staff/manage-reviews" class="d-flex gap-3 w-100" style="max-width: 600px;">
                        <div class="input-group" style="width: 300px;">
                            <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                            <input type="text" id="keyword-input" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search reviews..." style="font-size: 13px;">
                        </div>
                        <select id="status-select" name="filter" onchange="this.form.submit()" class="form-select" style="font-size: 13px; font-weight: 600; color: #555; width: 170px; cursor: pointer;">
                            <option value="ALL" <c:if test="${empty currentFilter or currentFilter == 'ALL'}">selected</c:if>>All Reviews</option>
                            <option value="PENDING_HIDE" <c:if test="${currentFilter == 'PENDING_HIDE'}">selected</c:if>>Pending Approval</option>
                            <option value="VISIBLE" <c:if test="${currentFilter == 'VISIBLE'}">selected</c:if>>Approved / Visible</option>
                        </select>
                        <button type="submit" class="d-none">Search</button>
                    </form>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 20%;">
                            <col style="width: 15%;">
                            <col style="width: 10%;">
                            <col style="width: 25%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Customer</th>
                                <th>Rating</th>
                                <th>Comment</th>
                                <th>Date</th>
                                <th>Status</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:forEach var="review" items="${reviews}">
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${not empty review.productImage ? review.productImage : 'https://via.placeholder.com/50'}" alt="" style="width: 32px; height: 32px; object-fit: cover; border-radius: 4px; border: 1px solid #e8e8e8;">
                                                    <span class="cell-name text-truncate" style="max-width: 120px;" title="${review.productName}">${review.productName}</span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="cell-name">${review.userName}</span>
                                            </td>
                                            <td>
                                                <div class="rating-stars">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <i class="bi bi-star-fill" style="${i > review.rating ? 'color:#e8e8e8;' : ''}"></i>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>
                                                <div style="line-height: 1.4;">
                                                    <div class="text-truncate" style="max-width: 200px; font-style: italic; color: #555;">"${review.comment}"</div>
                                                    <c:if test="${not empty review.replyComment}">
                                                        <div class="text-truncate mt-1" style="max-width: 200px; font-size: 11px; color: #888;"><strong>REPLY:</strong> ${review.replyComment}</div>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="cell-brand">
                                                    <fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy" /> 
                                                </span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${review.moderationStatus == 'VISIBLE'}"><span class="status-badge badge-approved">Approved</span></c:when>
                                                    <c:when test="${review.moderationStatus == 'PENDING_HIDE'}"><span class="status-badge badge-flagged">Flagged</span></c:when>
                                                </c:choose>
                                            </td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <button type="button" data-review-id="${review.id}" class="btn-action btn-view" style="min-width: unset; padding: 6px 10px;" onclick="openDrawer('${review.id}', '${review.productImage}', '${review.productName}', '${review.userName}', '${review.rating}', '${review.comment.replace('\'', '\\\'')}', '${review.replyComment != null ? review.replyComment.replace('\'', '\\\'') : ''}', '${review.moderationStatus}', '${review.hideReason != null ? review.hideReason.replace('\'', '\\\'') : ''}')">
                                                        Detail
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="7">
                                            <i class="bi bi-inbox" style="font-size: 24px; display: block; margin-bottom: 8px; opacity: 0.5;"></i>
                                            No reviews found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalReviews} reviews</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/manage-reviews?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}${not empty currentFilter ? '&filter=' : ''}${not empty currentFilter ? currentFilter : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:set var="startPage" value="${currentPage - 2}" />
<c:set var="endPage" value="${currentPage + 2}" />
<c:if test="${startPage < 1}">
    <c:set var="endPage" value="${endPage + (1 - startPage)}" />
    <c:set var="startPage" value="1" />
</c:if>
<c:if test="${endPage > totalPages}">
    <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
    <c:set var="endPage" value="${totalPages}" />
</c:if>
<c:if test="${startPage < 1}">
    <c:set var="startPage" value="1" />
</c:if>

<c:if test="${startPage > 1}">
    <c:set var="p" value="1" />
    <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/staff/manage-reviews?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}${not empty currentFilter ? '&filter=' : ''}${not empty currentFilter ? currentFilter : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
    <c:if test="${startPage > 2}">
        <span class="px-2">...</span>
    </c:if>
</c:if>

<c:forEach begin="${startPage}" end="${endPage}" var="p">
    <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/staff/manage-reviews?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}${not empty currentFilter ? '&filter=' : ''}${not empty currentFilter ? currentFilter : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:forEach>

<c:if test="${endPage < totalPages}">
    <c:if test="${endPage < totalPages - 1}">
        <span class="px-2">...</span>
    </c:if>
    <c:set var="p" value="${totalPages}" />
    <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/staff/manage-reviews?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}${not empty currentFilter ? '&filter=' : ''}${not empty currentFilter ? currentFilter : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/manage-reviews?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}${not empty currentFilter ? '&filter=' : ''}${not empty currentFilter ? currentFilter : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Side Drawer -->
        <div class="custom-drawer-overlay hidden-drawer" id="reviewDrawer">
            <div class="custom-drawer-panel translate-out" id="drawerPanel">
                <div class="drawer-header">
                    <div>
                        <h3 class="drawer-title">Review Detail</h3>
                        <p class="drawer-id" id="d-id">ID: </p>
                    </div>
                    <button type="button" class="btn-close" onclick="closeDrawer()" aria-label="Close"></button>
                </div>

                <div class="drawer-body">
                    <!-- Alerts -->
                    <c:if test="${not empty sessionScope.successMessage or not empty sessionScope.errorMessage}">
                        <div id="drawer-alerts">
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="alert-custom success">
                                    ${sessionScope.successMessage}
                                </div>
                                <c:remove var="successMessage" scope="session" />
                            </c:if>
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="alert-custom error">
                                    ${sessionScope.errorMessage}
                                </div>
                                <c:remove var="errorMessage" scope="session" />
                            </c:if>
                        </div>
                    </c:if>
                    
                    <span class="section-label">Product Context</span>
                    <div class="product-context">
                        <img id="d-p-img" src="" onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" />
                        <div>
                            <div class="cell-name" id="d-p-name"></div>
                        </div>
                    </div>

                    <span class="section-label">Customer Feedback <span id="d-c-name" style="font-weight: normal; text-transform: none; color: #888;"></span></span>
                    <div class="feedback-box">
                        <div class="rating-stars mb-2" id="d-rating"></div>
                        <p style="font-size: 14px; font-style: italic; margin: 0; color: #333;" id="d-comment"></p>
                    </div>

                    <div id="flag-reason-section" style="display: none;">
                        <span class="section-label" style="color: #b21f2d;">Flag Reason</span>
                        <div class="flag-box" id="d-hide-reason"></div>
                    </div>

                    <span class="section-label">Moderator Reply</span>
                    <form action="${pageContext.request.contextPath}/staff/manage-reviews/reply" method="post" id="replyForm">
                        <input type="hidden" name="reviewId" id="reply-review-id" />
                        <input type="hidden" name="filter" value="${currentFilter}" />
                        <textarea name="replyComment" id="d-reply" class="form-control" style="font-size: 13px; height: 100px; resize: none;" placeholder="Type your public response here..."></textarea>
                        <p id="reply-error" class="text-danger mt-1 mb-0 d-none" style="font-size: 11px; font-weight: 600;"></p>
                    </form>

                    <div id="flag-action-section" class="mt-4">
                        <span class="section-label" style="color: #b21f2d;">Flag Content</span>
                        <form action="${pageContext.request.contextPath}/staff/manage-reviews/hide" method="post" id="hideForm">
                            <input type="hidden" name="reviewId" id="hide-review-id" />
                            <input type="hidden" name="filter" value="${currentFilter}" />
                            <textarea name="hideReason" id="d-hide-input" class="form-control border-danger" style="font-size: 13px; height: 70px; resize: none;" placeholder="Reason for flagging/hiding this review..."></textarea>
                            <p id="hide-error" class="text-danger mt-1 mb-0 d-none" style="font-size: 11px; font-weight: 600;"></p>
                        </form>
                    </div>
                    
                    <div id="unhide-action-section" class="mt-4" style="display: none;">
                        <span class="section-label" style="color: #1e7e34;">Approve Content</span>
                        <form action="${pageContext.request.contextPath}/staff/manage-reviews/unhide" method="post" id="unhideForm">
                            <input type="hidden" name="reviewId" id="unhide-review-id" />
                            <input type="hidden" name="filter" value="${currentFilter}" />
                            <p class="text-body-md text-secondary" style="font-size: 13px;">Click "Approve" to make this review visible to customers again.</p>
                        </form>
                    </div>
                </div>

                <div class="drawer-footer">
                    <button form="hideForm" type="submit" class="btn-flag-review" id="btn-flag">Flag Review</button>
                    <button form="unhideForm" type="submit" class="btn-save-reply" id="btn-unhide" style="background: #e6f4ea; color: #1e7e34; border: 1px solid #1e7e34; display: none;">Approve Review</button>
                    <button form="replyForm" type="submit" class="btn-save-reply" id="btn-reply">Save Reply</button>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            <c:if test="${not empty param.open}">
            document.addEventListener("DOMContentLoaded", function() {
                const btn = document.querySelector("button[data-review-id='${param.open}']");
                if (btn) {
                    btn.click();
                }
            });
            </c:if>

            document.getElementById('replyForm').addEventListener('submit', function(e) {
                e.preventDefault();
                submitAjaxForm(this, 'reply');
            });

            document.getElementById('hideForm').addEventListener('submit', function(e) {
                e.preventDefault();
                submitAjaxForm(this, 'hide');
            });

            document.getElementById('unhideForm').addEventListener('submit', function(e) {
                e.preventDefault();
                submitAjaxForm(this, 'unhide');
            });

            function submitAjaxForm(form, actionType) {
                const formData = new FormData(form);
                const url = new URL(form.action, window.location.origin);
                url.searchParams.append('ajax', 'true');

                // Reset errors
                document.getElementById('reply-error').classList.add('d-none');
                document.getElementById('hide-error').classList.add('d-none');
                document.getElementById('d-reply').classList.remove('is-invalid');
                document.getElementById('d-hide-input').classList.remove('is-invalid');

                let alertsContainer = document.getElementById('drawer-alerts');
                if (!alertsContainer) {
                    const drawerBody = document.querySelector('.drawer-body');
                    alertsContainer = document.createElement('div');
                    alertsContainer.id = 'drawer-alerts';
                    drawerBody.insertBefore(alertsContainer, drawerBody.firstChild);
                }

                fetch(url, {
                    method: 'POST',
                    body: new URLSearchParams(formData)
                })
                .then(res => res.json())
                .then(data => {
                    alertsContainer.innerHTML = ''; 
                    
                    if (data.success) {
                        alertsContainer.innerHTML = '<div class="alert-custom success">' + data.message + '</div>';
                        if (actionType === 'reply') {
                            document.getElementById('d-reply').value = data.reply;
                        } else if (actionType === 'hide') {
                            document.getElementById('flag-reason-section').style.display = 'block';
                            document.getElementById('d-hide-reason').innerText = data.reason;
                            document.getElementById('flag-action-section').style.display = 'none';
                            document.getElementById('btn-flag').style.display = 'none';
                            document.getElementById('unhide-action-section').style.display = 'block';
                            document.getElementById('btn-unhide').style.display = 'block';
                            
                            // Hide reply form
                            document.getElementById('replyForm').style.display = 'none';
                            document.getElementById('btn-reply').style.display = 'none';

                            // Update the row status in the table directly
                            const reviewId = document.getElementById('hide-review-id').value;
                            const btn = document.querySelector('button[data-review-id="' + reviewId + '"]');
                            if (btn) {
                                const row = btn.closest('tr');
                                if (row) {
                                    const statusTd = row.querySelectorAll('td')[5];
                                    if (statusTd) {
                                        statusTd.innerHTML = '<span class="status-badge badge-flagged">Flagged</span>';
                                    }
                                }
                            }
                        } else if (actionType === 'unhide') {
                            document.getElementById('flag-reason-section').style.display = 'none';
                            document.getElementById('flag-action-section').style.display = 'block';
                            document.getElementById('btn-flag').style.display = 'block';
                            document.getElementById('unhide-action-section').style.display = 'none';
                            document.getElementById('btn-unhide').style.display = 'none';
                            
                            // Show reply form
                            document.getElementById('replyForm').style.display = 'block';
                            document.getElementById('btn-reply').style.display = 'block';
                            
                            const reviewId = document.getElementById('unhide-review-id').value;
                            const btn = document.querySelector('button[data-review-id="' + reviewId + '"]');
                            if (btn) {
                                const row = btn.closest('tr');
                                if (row) {
                                    const statusTd = row.querySelectorAll('td')[5];
                                    if (statusTd) {
                                        statusTd.innerHTML = '<span class="status-badge badge-approved">Approved</span>';
                                    }
                                }
                            }
                        }
                    } else {
                        if (actionType === 'reply') {
                            const errEl = document.getElementById('reply-error');
                            errEl.innerText = data.message;
                            errEl.classList.remove('d-none');
                            document.getElementById('d-reply').classList.add('is-invalid');
                        } else if (actionType === 'hide') {
                            const errEl = document.getElementById('hide-error');
                            errEl.innerText = data.message;
                            errEl.classList.remove('d-none');
                            document.getElementById('d-hide-input').classList.add('is-invalid');
                        }
                    }
                })
                .catch(err => {
                    alertsContainer.innerHTML = '<div class="alert-custom error">An error occurred. Please try again.</div>';
                });
            }

            function openDrawer(id, pImg, pName, cName, rating, comment, reply, modStatus, hideReason) {
                document.getElementById('d-id').innerText = 'ID: ' + id;
                document.getElementById('d-p-img').src = pImg ? pImg : 'https://via.placeholder.com/50';
                document.getElementById('d-p-name').innerText = pName;
                document.getElementById('d-c-name').innerText = '- ' + cName;

                // Reset previous error states
                document.getElementById('reply-error').classList.add('d-none');
                document.getElementById('hide-error').classList.add('d-none');
                document.getElementById('d-reply').classList.remove('is-invalid');
                document.getElementById('d-hide-input').classList.remove('is-invalid');
                let alertsContainer = document.getElementById('drawer-alerts');
                if (alertsContainer) alertsContainer.innerHTML = '';

                let stars = '';
                for (let i = 1; i <= 5; i++) {
                    if (i <= rating) stars += '<i class="bi bi-star-fill"></i> ';
                    else stars += '<i class="bi bi-star-fill" style="color:#e8e8e8;"></i> ';
                }
                document.getElementById('d-rating').innerHTML = stars;
                document.getElementById('d-comment').innerText = '"' + comment + '"';

                document.getElementById('d-reply').value = reply;
                document.getElementById('reply-review-id').value = id;
                document.getElementById('hide-review-id').value = id;
                document.getElementById('unhide-review-id').value = id;

                if (modStatus === 'PENDING_HIDE') {
                    document.getElementById('flag-reason-section').style.display = 'block';
                    document.getElementById('d-hide-reason').innerText = hideReason;
                    document.getElementById('flag-action-section').style.display = 'none';
                    document.getElementById('btn-flag').style.display = 'none';
                    
                    document.getElementById('unhide-action-section').style.display = 'block';
                    document.getElementById('btn-unhide').style.display = 'block';
                    
                    // Hide reply section
                    document.getElementById('replyForm').style.display = 'none';
                    document.getElementById('btn-reply').style.display = 'none';
                } else {
                    document.getElementById('flag-reason-section').style.display = 'none';
                    document.getElementById('flag-action-section').style.display = 'block';
                    document.getElementById('btn-flag').style.display = 'block';
                    
                    document.getElementById('unhide-action-section').style.display = 'none';
                    document.getElementById('btn-unhide').style.display = 'none';
                    
                    // Show reply section
                    document.getElementById('replyForm').style.display = 'block';
                    document.getElementById('btn-reply').style.display = 'block';
                }

                const drawer = document.getElementById('reviewDrawer');
                const panel = document.getElementById('drawerPanel');
                drawer.classList.remove('hidden-drawer');
                panel.classList.remove('translate-out');
            }

            function closeDrawer() {
                const drawer = document.getElementById('reviewDrawer');
                const panel = document.getElementById('drawerPanel');
                drawer.classList.add('hidden-drawer');
                panel.classList.add('translate-out');
                
                // Remove 'open' param from URL
                const url = new URL(window.location);
                if (url.searchParams.has('open')) {
                    url.searchParams.delete('open');
                    window.history.replaceState({}, document.title, url.toString());
                }
            }
        </script>
    </body>
</html>
