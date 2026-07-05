<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Account Management - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
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
                white-space: nowrap;
                overflow: hidden;
            }
            .user-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .user-table tbody tr:last-child {
                border-bottom: none;
            }
            .user-table tbody tr:hover {
                background: #fafafa;
            }
            .user-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .col-no       {
                width: 5%;
            }
            .col-uuid     {
                width: 18%;
            }
            .col-name     {
                width: 14%;
            }
            .col-email    {
                width: 18%;
            }
            .col-role     {
                width: 11%;
            }
            .col-status   {
                width: 10%;
            }
            .col-date     {
                width: 18%;
            }
            .col-action   {
                width: 21%;
            }

            .cell-no {
                font-size: 12px;
                color: #bbb;
                font-weight: 600;
            }
            .cell-uuid {
                font-size: 11px;
                color: #bbb;
                display: block;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .cell-name {
                font-weight: 600;
                color: #1a1a1a;
            }
            .cell-name-empty {
                font-weight: 400;
                color: #bbb;
                font-style: italic;
            }
            .cell-email {
                font-size: 12px;
                color: #555;
            }
            .cell-date {
                font-size: 12px;
                color: #888;
            }
            .role-badge, .status-badge {
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                padding: 4px 10px;
                display: inline-block;
                white-space: nowrap;
                border-radius: 4px;
            }
            .badge-customer {
                background: #e8f4fd;
                color: #1a6fa8;
            }
            .badge-other {
                background: #e6f4ea;
                color: #2d7a3a;
            }
            .badge-active {
                background: #e6f4ea;
                color: #1e7e34;
            }
            .badge-inactive {
                background: #f8d7da;
                color: #b21f2d;
            }
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
            }
            .btn-view {
                background-color: #f1f1f1;
                color: #333;
            }
            .btn-view:hover {
                background-color: #e2e2e2;
                color: #000;
            }
            .btn-edit {
                background-color: #e8f4fd;
                color: #1a6fa8;
            }
            .btn-edit:hover {
                background-color: #d2e9fc;
                color: #0b4f7c;
            }
            .btn-toggle-status {
                background-color: #fff5f5;
                color: #e53e3e;
                border-color: #fed7d7;
            }
            .btn-toggle-status:hover {
                background-color: #e53e3e;
                color: #fff;
                border-color: #e53e3e;
            }
            .btn-toggle-active {
                background-color: #f0fdf4;
                color: #15803d;
                border-color: #dcfce7;
            }
            .btn-toggle-active:hover {
                background-color: #15803d;
                color: #fff;
                border-color: #15803d;
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
            <c:set var="activePage" value="user" scope="request" />
            <jsp:include page="sidebar.jsp" />

            <div class="main-content">
                <div class="page-header">
                    <i class="bi bi-people" style="font-size:16px; color:#1a1a1a;"></i>
                    <h3 class="page-title">Account List</h3>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col class="col-no">
                            <col class="col-uuid">
                            <col class="col-name">
                            <col class="col-email">
                            <col class="col-role">
                            <col class="col-status">
                            <col class="col-date">
                            <col class="col-action">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>ID (UUID)</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th style="text-align:center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty users}">
                                    <c:forEach items="${users}" var="u" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td><span class="cell-uuid">${u.id}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.fullName != null}">
                                                        <span class="cell-name">${u.fullName}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="cell-name-empty">Not updated</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><span class="cell-email">${u.email}</span></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.roleName eq 'Customer'}">
                                                        <span class="role-badge badge-customer">Customer</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="role-badge badge-other">${u.roleName}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${u.status eq 'Active'}">
                                                        <span class="status-badge badge-active">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge badge-inactive">${not empty u.status ? u.status : 'Inactive'}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td><span class="cell-date"><fmt:formatDate value="${u.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span></td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <a href="${pageContext.request.contextPath}/manage-account/view?id=${u.id}" class="btn-action btn-view">View</a>
                                                    <a href="${pageContext.request.contextPath}/manage-account/edit?id=${u.id}" class="btn-action btn-edit">Edit</a>
                                                    <c:choose>
                                                        <c:when test="${u.status eq 'Active'}">
                                                            <a href="${pageContext.request.contextPath}/status-account?id=${u.id}&currentStatus=Active" 
                                                               class="btn-action btn-toggle-status" 
                                                               onclick="return confirm('Are you sure you want to block this account?');">Block</a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/status-account?id=${u.id}&currentStatus=Inactive" 
                                                               class="btn-action btn-toggle-active" 
                                                               onclick="return confirm('Are you sure you want to activate this account?');">Unblock</a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="8">No accounts found in the system.</td>
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