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
            body { background: #f5f5f3; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; }
            .main-content {
                margin-left: 256px;
                padding: 40px 48px;
                min-height: 100vh;
                width: calc(100% - 256px);
            }
            .page-header { display: flex; align-items: center; margin-bottom: 32px; gap: 12px; }
            .page-title { font-size: 14px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #1a1a1a; margin: 0; }
            .table-card { background: #fff; border: 1px solid #e8e8e8; border-radius: 4px; box-shadow: 0 1px 3px rgba(0,0,0,0.02); overflow: hidden; }
            .user-table { width: 100%; border-collapse: collapse; table-layout: fixed; }
            .user-table thead tr { border-bottom: 2px solid #f0f0f0; background: #fcfcfc; }
            .user-table thead th { font-size: 10px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #999; padding: 16px; text-align: left; }
            .user-table tbody tr { border-bottom: 1px solid #f8f8f8; transition: background .12s; }
            .user-table tbody tr:hover { background: #fafafa; }
            .user-table tbody td { padding: 18px 16px; font-size: 14px; color: #1a1a1a; vertical-align: middle; }
            
            .col-no { width: 50px; } .col-code { width: 140px; } .col-value { width: 90px; } .col-min { width: 110px; } .col-date { width: 120px; } .col-usage { width: 100px; } .col-status { width: 90px; } .col-action { width: 180px; }
            .cell-no { font-size: 12px; color: #ccc; font-weight: 600; }
            .cell-code { font-weight: 700; color: #1a1a1a; letter-spacing: 0.02em; }
            .qty-badge { font-size: 11px; font-weight: 700; background: #f1f3f5; color: #495057; padding: 4px 10px; border-radius: 4px; display: inline-block; }
            
            .status-badge { font-size: 9px; font-weight: 700; padding: 4px 10px; border-radius: 20px; text-transform: uppercase; display: inline-block; }
            .status-active { background: #e6fffa; color: #2c7a7b; }
            .status-inactive { background: #fff5f5; color: #e03131; }
            
            .action-wrap { display: flex; gap: 8px; justify-content: center; }
            .btn-action { font-size: 10px; font-weight: 700; letter-spacing: .05em; text-transform: uppercase; padding: 8px 14px; text-decoration: none !important; border-radius: 4px; transition: all 0.2s ease; border: 1px solid transparent; }
            .btn-view { background: #f8f9fa; color: #333; border-color: #e9ecef; }
            .btn-view:hover { background: #e9ecef; }
            .btn-edit { background: #e8f4fd; color: #1a6fa8; }
            .btn-edit:hover { background: #d2e9fc; }
            .btn-delete { background: #fff5f5; color: #e03131; }
            .btn-delete:hover { background: #ffe3e3; }
            .empty-row td { text-align: center; padding: 60px; font-size: 13px; color: #aaa; text-transform: uppercase; letter-spacing: 0.1em; }
            
            .btn-create {
                background: #1a1a1a;
                color: #fff;
                font-size: 11px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: .1em;
                padding: 10px 20px;
                border-radius: 4px;
                border: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: background 0.2s;
                text-decoration: none !important;
            }
            .btn-create:hover { background: #333; color: #fff; text-decoration: none !important; }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="voucher" scope="request" />
            <jsp:include page="sidebar.jsp" />
            <div class="main-content">
                <div class="page-header d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center gap-2">
                        <i class="bi bi-ticket-perforated" style="font-size:18px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Voucher Management</h3>
                    </div>
                    <a href="${pageContext.request.contextPath}/create-voucher" class="btn-create">
                        <i class="bi bi-plus-lg"></i> Create Voucher
                    </a>
                </div>
                <div class="table-card">
                    <table class="user-table">
                        <thead>
                            <tr>
                                <th class="col-no">No.</th>
                                <th class="col-code">Code</th>
                                <th class="col-value">Value (%)</th>
                                <th class="col-min">Min Order</th>
                                <th class="col-date">Start Date</th>
                                <th class="col-date">End Date</th>
                                <th class="col-usage">Usage</th>
                                <th class="col-status">Status</th>
                                <th class="col-action" style="text-align:center">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty VOUCHER_LIST}">
                                    <c:forEach items="${VOUCHER_LIST}" var="v" varStatus="status">
                                        <tr>
                                            <td class="col-no"><span class="cell-no">${status.count}</span></td>
                                            <td class="col-code"><span class="cell-code">${v.code}</span></td>
                                            <td class="col-value">
                                                <strong><fmt:formatNumber value="${v.discountValue}" pattern="#,##0.##" />%</strong>
                                            </td>
                                            <td class="col-min">
                                                <span style="font-size: 13px;"><fmt:formatNumber value="${v.minOrderAmount}" pattern="#,##0.##" /> đ</span>
                                            </td>
                                            <td class="col-date">
                                                <c:set var="sDate" value="${v.startDate.toString()}" />
                                                <fmt:parseDate value="${sDate.substring(0,10)}" pattern="yyyy-MM-dd" var="parsedS" type="date" />
                                                <fmt:formatDate value="${parsedS}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td class="col-date">
                                                <c:set var="eDate" value="${v.endDate.toString()}" />
                                                <fmt:parseDate value="${eDate.substring(0,10)}" pattern="yyyy-MM-dd" var="parsedE" type="date" />
                                                <fmt:formatDate value="${parsedE}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td class="col-usage"><span class="qty-badge">${v.usedQuantity} / ${v.quantity}</span></td>
                                            <td class="col-status">
                                                <span class="status-badge ${v.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                                                    ${v.status}
                                                </span>
                                            </td>
                                            <td class="col-action">
                                                <div class="action-wrap">
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/view?id=${v.id}" class="btn-action btn-view">View</a>
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/edit?id=${v.id}" class="btn-action btn-edit">Edit</a>
                                                    <c:if test="${v.status == 'ACTIVE'}">
                                                        <a href="javascript:void(0);" onclick="confirmDelete('${v.id}')" class="btn-action btn-delete">Delete</a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row"><td colspan="9">No vouchers found in the system.</td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function confirmDelete(id) {
                if (confirm('Are you sure you want to delete this voucher? This will change status to INACTIVE.')) {
                    window.location.href = '${pageContext.request.contextPath}/manage-voucher/delete?id=' + id;
                }
            }
        </script>
    </body>
</html>
