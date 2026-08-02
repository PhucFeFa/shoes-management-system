<%-- Author: baolgce191178 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Order Management - Staff</title>
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
            }
            .user-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
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
            .user-table thead th a {
                color: #1a1a1a;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 4px;
            }
            .user-table thead th a:hover {
                color: #000;
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
            .badge-pending { background: #fdf6b2; color: #723b13; }
            .badge-confirmed { background: #e1effe; color: #1e429f; }
            .badge-shipping { background: #f0fdf4; color: #15803d; }
            .badge-completed { background: #e6f4ea; color: #1e7e34; }
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
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="orders" scope="request" />
            <jsp:include page="/views/staff/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-cart2" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Order Management</h3>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form method="get" action="${pageContext.request.contextPath}/staff/orders" class="d-flex gap-3 w-100" style="max-width: 600px;">
                        <div class="input-group" style="width: 300px;">
                            <span class="input-group-text bg-white border-end-0" style="border-top-left-radius: 50px; border-bottom-left-radius: 50px; padding-left: 14px;"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                            <input type="text" name="keyword" value="<c:out value='${keyword}'/>" class="form-control border-start-0" placeholder="Search by customer name, email..." style="font-size: 13px; border-top-right-radius: 50px; border-bottom-right-radius: 50px;">
                        </div>
                        <select name="status" onchange="this.form.submit()" class="form-select" style="font-size: 13px; font-weight: 600; color: #555; width: 150px; cursor: pointer;">
                            <option value="" <c:if test="${empty statusFilter}">selected</c:if>>All Statuses</option>
                            <option value="pending" <c:if test="${statusFilter == 'pending'}">selected</c:if>>Pending</option>
                            <option value="confirmed" <c:if test="${statusFilter == 'confirmed'}">selected</c:if>>Confirmed</option>
                            <option value="shipping" <c:if test="${statusFilter == 'shipping'}">selected</c:if>>Shipping</option>
                            <option value="completed" <c:if test="${statusFilter == 'completed'}">selected</c:if>>Completed</option>
                            <option value="cancelled" <c:if test="${statusFilter == 'cancelled'}">selected</c:if>>Cancelled</option>
                        </select>
                        <input type="hidden" name="sortBy" value="${sortBy}">
                        <input type="hidden" name="sortOrder" value="${sortOrder}">
                        <button type="submit" class="d-none">Search</button>
                    </form>
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
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>
                                    <a href="${pageContext.request.contextPath}/staff/orders?status=${statusFilter}&keyword=${keyword}&sortBy=date&sortOrder=${(sortBy == 'date' && sortOrder == 'asc') ? 'desc' : 'asc'}">
                                        Order Date <i class="bi bi-arrow-down-up ms-1" style="font-size:10px;"></i>
                                    </a>
                                </th>
                                <th>
                                    <a href="${pageContext.request.contextPath}/staff/orders?status=${statusFilter}&keyword=${keyword}&sortBy=amount&sortOrder=${(sortBy == 'amount' && sortOrder == 'desc') ? 'asc' : 'desc'}">
                                        Total Amount <i class="bi bi-arrow-down-up ms-1" style="font-size:10px;"></i>
                                    </a>
                                </th>
                                <th>Status</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty orders}">
                                    <c:forEach var="order" items="${orders}">
                                        <tr style="${order.status == 'cancelled' ? 'opacity: 0.6;' : ''}">
                                            <td><span class="cell-name"><c:out value="${order.id.length() > 8 ? order.id.substring(order.id.length() - 8).toUpperCase() : order.id}" /></span></td>
                                            <td>
                                                <div style="line-height: 1.4;">
                                                    <div class="cell-name"><c:out value="${not empty order.customerFullName ? order.customerFullName : 'N/A'}" /></div>
                                                    <div class="cell-category"><c:out value="${order.customerEmail}" /></div>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="cell-brand">
                                                    <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy" /> 
                                                    <span style="font-size:10px; margin-left:4px;"><fmt:formatDate value="${order.createdAt}" pattern="HH:mm" /></span>
                                                </span>
                                            </td>
                                            <td><span class="cell-price"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /> đ</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.status == 'pending'}"><span class="status-badge badge-pending">Pending</span></c:when>
                                                    <c:when test="${order.status == 'confirmed'}"><span class="status-badge badge-confirmed">Confirmed</span></c:when>
                                                    <c:when test="${order.status == 'shipping'}"><span class="status-badge badge-shipping">Shipping</span></c:when>
                                                    <c:when test="${order.status == 'completed'}"><span class="status-badge badge-completed">Completed</span></c:when>
                                                    <c:when test="${order.status == 'cancelled'}"><span class="status-badge badge-cancelled">Cancelled</span></c:when>
                                                    <c:otherwise><span class="status-badge badge-default"><c:out value="${order.status}" /></span></c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <a href="${pageContext.request.contextPath}/staff/order/details?id=${order.id}" class="btn-action btn-view" style="min-width: unset; padding: 6px 10px;">
                                                        View
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
                                            No orders found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalOrders} orders</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/orders?page=${currentPage - 1}&status=${statusFilter}&keyword=${keyword}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/orders?page=${p}&status=${statusFilter}&keyword=${keyword}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/orders?page=${p}&status=${statusFilter}&keyword=${keyword}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/staff/orders?page=${p}&status=${statusFilter}&keyword=${keyword}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/orders?page=${currentPage + 1}&status=${statusFilter}&keyword=${keyword}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
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
