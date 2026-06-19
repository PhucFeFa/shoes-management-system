<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Import Management - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
        <style>
            * {
                box-sizing: border-box;
            }
            body {
                background: #f5f5f3;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                margin: 0;
            }
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
            .import-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
            }
            .import-table thead tr {
                border-bottom: 2px solid #e8e8e8;
            }
            .import-table thead th {
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .14em;
                text-transform: uppercase;
                color: #999;
                padding: 14px 16px;
                white-space: nowrap;
                overflow: hidden;
            }
            .import-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .import-table tbody tr:last-child {
                border-bottom: none;
            }
            .import-table tbody tr:hover {
                background: #fafafa;
            }
            .import-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .col-id       { width: 10%; }
            .col-created  { width: 22%; }
            .col-supplier { width: 22%; }
            .col-amount   { width: 14%; }
            .col-date     { width: 14%; }
            .col-status   { width: 10%; } 
            .col-action   { width: 8%; }

            .cell-id {
                font-size: 13px;
                font-weight: 700;
                color: #1a1a1a;
            }
            .cell-muted {
                font-size: 12px;
                color: #bbb;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                display: block;
            }
            .cell-supplier {
                font-weight: 600;
                color: #1a1a1a;
            }
            .cell-amount {
                font-weight: 700;
                color: #1a1a1a;
            }
            .cell-date {
                font-size: 12px;
                color: #888;
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
            .badge-completed {
                background: #e6f4ea;
                color: #2d7a3a;
            }
            .badge-shipping {
                background: #fff8e1;
                color: #b08000;
            }
            .badge-default {
                background: #f0f0f0;
                color: #888;
            }
            .btn-view {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-size: 10px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 6px 14px;
                background-color: #f1f1f1;
                color: #333;
                text-decoration: none;
                white-space: nowrap;
                border-radius: 4px;
                transition: all 0.2s ease;
                line-height: 1.2;
                border: 1px solid transparent;
            }
            .btn-view:hover {
                background-color: #e2e2e2;
                color: #000;
            }
            .empty-row td {
                text-align: center;
                padding: 48px;
                font-size: 12px;
                color: #aaa;
                letter-spacing: .06em;
                text-transform: uppercase;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="import" scope="request" />
            <jsp:include page="sidebar.jsp" />

            <div class="main-content">
                <div class="page-header">
                    <i class="bi bi-box-seam" style="font-size:16px; color:#1a1a1a;"></i>
                    <h3 class="page-title">Import Orders</h3>
                </div>

                <div class="table-card">
                    <table class="import-table">
                        <colgroup>
                            <col class="col-id">
                            <col class="col-created">
                            <col class="col-supplier">
                            <col class="col-amount">
                            <col class="col-date">
                            <col class="col-status">
                            <col class="col-action">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>Import ID</th>
                                <th>Created By</th>
                                <th>Supplier</th>
                                <th>Total Amount</th>
                                <th>Order Date</th>
                                <th style="text-align:center">Status</th>
                                <th style="text-align:center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty importList}">
                                    <c:forEach var="imp" items="${importList}">
                                        <tr>
                                            <td><span class="cell-id">#${imp.importID}</span></td>
                                            <td><span class="cell-muted">${imp.userID}</span></td>
                                            <td><span class="cell-supplier">${imp.supplier}</span></td>
                                            <td><span class="cell-amount">
                                                    <fmt:formatNumber value="${imp.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                                </span></td>
                                            <td><span class="cell-date">
                                                    <fmt:parseDate value="${imp.orderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                    <fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy HH:mm"/>
                                                </span></td>
                                            <td style="text-align:center">
                                                <c:choose>
                                                    <c:when test="${imp.status eq 'completed'}">
                                                        <span class="status-badge badge-completed">Completed</span>
                                                    </c:when>
                                                    <c:when test="${imp.status eq 'shipping'}">
                                                        <span class="status-badge badge-shipping">Shipping</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge badge-default">${imp.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="text-align:center">
                                                <a href="${pageContext.request.contextPath}/import-detail?id=${imp.importID}" class="btn-view">View</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="7">No import orders found in the system.</td>
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