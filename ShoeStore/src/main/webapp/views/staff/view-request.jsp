<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Import Requests - Staff</title>
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
            .badge-requesting { background: #e1effe; color: #1e429f; }
            .badge-approved { background: #fdf6b2; color: #723b13; }
            .badge-reported { background: #f3e8ff; color: #6b21a8; }
            .badge-accepted { background: #e6f4ea; color: #1e7e34; }
            .badge-complete { background: #d1fae5; color: #065f46; }
            .badge-cancelled { background: #f8d7da; color: #b21f2d; }
            .badge-default { background: #f3f4f6; color: #374151; }
            
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
            .btn-add-product {
                background: #1a1a1a;
                color: #fff;
                font-size: 11px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: .05em;
                padding: 0 16px;
                height: 38px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border: none;
                border-radius: 4px;
                transition: 0.2s;
                text-decoration: none;
            }
            .btn-add-product:hover { background: #333; color: #fff; }
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
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="import-requests" scope="request" />
            <jsp:include page="/views/staff/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-box-arrow-in-right" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Import Requests</h3>
                    </div>
                </div>

                <c:if test="${param.success eq 'true' or param.msg eq 'success'}">
                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert">
                        <i class="bi bi-check-circle me-2"></i> Your import request has been submitted successfully and is now pending admin approval.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${param.msg eq 'report_success'}">
                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert">
                        <i class="bi bi-check-circle me-2"></i> Your arrival report has been submitted successfully and is now pending admin approval.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                <c:if test="${param.msg eq 'stockin_success'}">
                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert">
                        <i class="bi bi-check-circle me-2"></i> Stock-in completed successfully! Items have been added to inventory.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/staff/view-request" method="GET" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0" style="border-top-left-radius: 50px; border-bottom-left-radius: 50px; padding-left: 14px;"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search supplier or ID..." style="font-size: 13px; border-top-right-radius: 50px; border-bottom-right-radius: 50px; padding-right: 14px;">
                        <button type="submit" class="d-none"></button>
                    </form>
                    <a href="${pageContext.request.contextPath}/staff/create-import" class="btn-add-product">
                        + New Request
                    </a>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 15%;">
                            <col style="width: 25%;">
                            <col style="width: 20%;">
                            <col style="width: 15%;">
                            <col style="width: 15%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Supplier</th>
                                <th>Date</th>
                                <th>Total Amount</th>
                                <th>Status</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty importRequests}">
                                    <c:forEach var="req" items="${importRequests}">
                                        <tr style="${req.status == 'CANCELLED' ? 'opacity: 0.6;' : ''}">
                                            <td><span class="cell-name">#<c:out value="${req.importID}" /></span></td>
                                            <td><span class="cell-name"><c:out value="${req.supplier}" /></span></td>
                                            <td>
                                                <span class="cell-brand">
                                                    <fmt:formatDate value="${req.orderDate}" pattern="dd/MM/yyyy" /> 
                                                    <span style="font-size:10px; margin-left:4px;"><fmt:formatDate value="${req.orderDate}" pattern="HH:mm" /></span>
                                                </span>
                                            </td>
                                            <td><span class="cell-price"><fmt:formatNumber value="${req.totalAmount}" pattern="#,##0" /> đ</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${req.status == 'REQUESTING'}"><span class="status-badge badge-requesting">Requesting</span></c:when>
                                                    <c:when test="${req.status == 'APPROVED'}"><span class="status-badge badge-approved">Approved</span></c:when>
                                                    <c:when test="${req.status == 'REPORTED'}"><span class="status-badge badge-reported">Reported</span></c:when>
                                                    <c:when test="${req.status == 'ACCEPTED'}"><span class="status-badge badge-accepted">Accepted</span></c:when>
                                                    <c:when test="${req.status == 'COMPLETE'}"><span class="status-badge badge-complete">Complete</span></c:when>
                                                    <c:when test="${req.status == 'CANCELLED'}"><span class="status-badge badge-cancelled">Cancelled</span></c:when>
                                                    <c:otherwise><span class="status-badge badge-default"><c:out value="${req.status}" /></span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <a href="${pageContext.request.contextPath}/staff/import-detail?id=${req.importID}" class="btn-action btn-view" style="min-width: unset; padding: 6px 10px;">
                                                        Detail
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="6">
                                            <i class="bi bi-inbox" style="font-size: 24px; display: block; margin-bottom: 8px; opacity: 0.5;"></i>
                                            No import requests found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalImportRequests} requests</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/view-request?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/view-request?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/view-request?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/view-request?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/view-request?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

