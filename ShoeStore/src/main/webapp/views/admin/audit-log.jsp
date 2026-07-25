<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Audit Logs - Admin</title>
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
                width: 100%;
            }
            .page-header {
                display: flex;
                align-items: center;
                margin-bottom: 24px;
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
            .cell-date {
                font-size: 12px;
                color: #888;
            }
            .action-badge {
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                padding: 4px 10px;
                display: inline-block;
                white-space: nowrap;
                border-radius: 4px;
                background: #e8f4fd;
                color: #1a6fa8;
            }
            .form-control:focus {
                box-shadow: none;
                border-color: #dee2e6;
            }
            .input-group-text, .form-control {
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
            <c:set var="activePage" value="audit-log" scope="request" />
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-clock-history" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Staff Audit Logs</h3>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/admin/audit-log" method="GET" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search by name or email..." style="font-size: 13px;">
                    </form>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 5%;">
                            <col style="width: 25%;">
                            <col style="width: 20%;">
                            <col style="width: 35%;">
                            <col style="width: 15%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Staff Name</th>
                                <th>Order ID</th>
                                <th>Action Details</th>
                                <th>Timestamp</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty logs}">
                                    <c:forEach var="log" items="${logs}" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td>
                                                <span class="cell-name">${log.staffName}</span><br>
                                                <span style="font-size: 11px; color: #888;">${log.staffEmail}</span>
                                            </td>
                                            <td><span style="font-size: 11px; font-family: monospace;">${log.orderId}</span></td>
                                            <td><span style="font-size: 12px; color: #555;">${log.action}</span></td>
                                            <td><span class="cell-date"><fmt:formatDate value="${log.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></span></td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="6">No audit logs found.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalLogs} logs</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/audit-log?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/audit-log?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/audit-log?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
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
