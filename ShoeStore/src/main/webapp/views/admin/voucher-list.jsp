<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Voucher Management - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; }
            body {
                background: #f5f5f3;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                margin: 0;
            }
            /* Main content chuẩn margin 220px theo sidebar */
            .main-content {
                margin-left: 220px;
                padding: 32px 36px;
                min-height: 100vh;
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
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .14em;
                text-transform: uppercase;
                color: #999;
                padding: 14px 16px;
            }
            .user-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .user-table tbody tr:hover { background: #fafafa; }
            .user-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
            }
            /* Cấu hình độ rộng các cột */
            .col-no { width: 6%; }
            .col-code { width: 22%; }
            .col-date { width: 22%; }
            .col-qty { width: 15%; }
            .col-action { width: 13%; }

            .cell-no { font-size: 12px; color: #bbb; font-weight: 600; }
            .cell-code { font-weight: 600; color: #1a1a1a; }
            .cell-date { font-size: 12px; color: #888; }
            
            .qty-badge {
                font-size: 10px;
                font-weight: 700;
                background: #f1f3f5;
                color: #495057;
                padding: 4px 10px;
                border-radius: 4px;
                text-transform: uppercase;
            }

            .action-wrap {
                display: flex;
                gap: 6px;
                justify-content: center;
            }
            .btn-action {
                font-size: 10px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 6px 12px;
                text-decoration: none;
                border-radius: 4px;
                transition: all 0.2s ease;
            }
            .btn-view { background: #f1f1f1; color: #333; }
            .btn-view:hover { background: #e2e2e2; }
            .btn-edit { background: #e8f4fd; color: #1a6fa8; }
            .btn-edit:hover { background: #d2e9fc; }
            
            .empty-row td {
                text-align: center;
                padding: 48px;
                font-size: 12px;
                color: #aaa;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <%-- Thiết lập Active Page để sidebar tô màu đúng mục Voucher --%>
            <c:set var="activePage" value="voucher" scope="request" />
            <jsp:include page="sidebar.jsp" />

            <div class="main-content">
                <div class="page-header d-flex justify-content-between align-items-center w-100">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-ticket-perforated" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Voucher Management</h3>
                    </div>
                    
                    <a href="${pageContext.request.contextPath}/create-voucher" class="btn" style="background: #1a1a1a; color: #fff; font-size: 10px; font-weight: 700; text-transform: uppercase; letter-spacing: .1em; padding: 8px 16px; border-radius: 4px;">
                        <i class="bi bi-plus-lg me-1"></i> Create Voucher
                    </a>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col class="col-no">
                            <col class="col-code">
                            <col class="col-date">
                            <col class="col-date">
                            <col class="col-qty">
                            <col class="col-action">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Voucher Code</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Quantity</th>
                                <th style="text-align:center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty VOUCHER_LIST}">
                                    <c:forEach items="${VOUCHER_LIST}" var="v" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.count}</span></td>
                                            <td><span class="cell-code">${v.code}</span></td>
                                            <td>
                                                <span class="cell-date">
                                                    <fmt:formatDate value="${v.startDate}" pattern="yyyy-MM-dd HH:mm"/>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="cell-date">
                                                    <fmt:formatDate value="${v.endDate}" pattern="yyyy-MM-dd HH:mm"/>
                                                </span>
                                            </td>
                                            <td>
                                                <span class="qty-badge">${v.quantity}</span>
                                            </td>
                                            <td>
                                                <div class="action-wrap">
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/view?id=${v.id}" class="btn-action btn-view">View</a>
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/edit?id=${v.id}" class="btn-action btn-edit">Edit</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="6">No vouchers found in the system.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>