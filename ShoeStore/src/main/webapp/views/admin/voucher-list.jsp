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
            body { background: #f5f5f3; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; overflow-y: scroll; }
            .main-content {
                margin-left: 220px;
                padding: 32px 36px;
                min-height: 100vh;
                width: 100%;
            }
            .page-header { display: flex; align-items: center; margin-bottom: 24px; gap: 10px; }
            .page-title { font-size: 13px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #1a1a1a; margin: 0; }
            .table-card { background: #fff; border: 1px solid #e8e8e8; border-radius: 4px; overflow: hidden; }
            .user-table { width: 100%; border-collapse: collapse; table-layout: fixed; }
            .user-table thead tr { border-bottom: 2px solid #e8e8e8; background: #fff; }
            .user-table thead th { font-size: 11px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #1a1a1a; padding: 14px 16px; text-align: left; }
            .user-table tbody tr { border-bottom: 1px solid #f0f0f0; transition: background .12s; }
            .user-table tbody tr:hover { background: #fafafa; }
            .user-table tbody td { padding: 16px; font-size: 13px; color: #1a1a1a; vertical-align: middle; }
            
            .col-no { width: 50px; } .col-code { width: 140px; } .col-value { width: 90px; } .col-min { width: 110px; } .col-date { width: 120px; } .col-usage { width: 100px; } .col-status { width: 90px; } .col-action { width: 180px; }
            .cell-no { font-size: 12px; color: #ccc; font-weight: 600; }
            .cell-code { font-weight: 700; color: #1a1a1a; letter-spacing: 0.02em; }
            .qty-badge { font-size: 11px; font-weight: 700; background: #f1f3f5; color: #495057; padding: 4px 10px; border-radius: 4px; display: inline-block; }
            
            .status-badge { font-size: 9px; font-weight: 700; padding: 4px 10px; border-radius: 4px; text-transform: uppercase; display: inline-block; letter-spacing: .1em; }
            .status-active { background: #f0fdf4; color: #15803d; border: 1px solid #dcfce7; }
            .status-inactive { background: #fff5f5; color: #e53e3e; border: 1px solid #fed7d7; }
            
            .action-wrap { display: flex; gap: 6px; justify-content: center; align-items: center; }
            .btn-action { font-size: 10px; font-weight: 600; letter-spacing: .05em; text-transform: uppercase; padding: 6px 12px; text-decoration: none !important; border-radius: 4px; transition: all 0.2s ease; border: 1px solid transparent; line-height: 1.2; }
            .btn-view { background: #f1f1f1; color: #333; }
            .btn-view:hover { background: #e2e2e2; color: #000; }
            .btn-edit { background: #e8f4fd; color: #1a6fa8; }
            .btn-edit:hover { background: #d2e9fc; color: #0b4f7c; }
            .btn-delete { background: #fff5f5; color: #e53e3e; border-color: #fed7d7; }
            .btn-delete:hover { background: #e53e3e; color: #fff; border-color: #e53e3e; }
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
            }
            .user-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .user-table tbody tr:hover {
                background: #fafafa;
            }
            .user-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
            }
            /* Cấu hình độ rộng các cột */
            .col-no {
                width: 6%;
            }
            .col-code {
                width: 22%;
            }
            .col-date {
                width: 22%;
            }
            .col-qty {
                width: 15%;
            }
            .col-action {
                width: 13%;
            }

            .cell-no {
                font-size: 12px;
                color: #bbb;
                font-weight: 600;
            }
            .cell-code {
                font-weight: 600;
                color: #1a1a1a;
            }
            .cell-date {
                font-size: 12px;
                color: #888;
            }

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
            .btn-add {
                background: #1a1a1a;
                color: #fff;
                border: none;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 0 16px;
                height: 38px;
                border-radius: 4px;
                cursor: pointer;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            .btn-add:hover {
                background: #000;
                color: #fff;
            }
            .btn-view {
                background: #f1f1f1;
                color: #333;
            }
            .btn-view:hover {
                background: #e2e2e2;
            }
            .btn-edit {
                background: #e8f4fd;
                color: #1a6fa8;
            }
            .btn-edit:hover {
                background: #d2e9fc;
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
            <c:set var="activePage" value="voucher" scope="request" />
            <jsp:include page="sidebar.jsp" />
            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-ticket-perforated" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Voucher Management</h3>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/manage-voucher" method="GET" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search by voucher code..." style="font-size: 13px;">
                        <button type="submit" class="d-none"></button>
                    </form>
                    <a href="${pageContext.request.contextPath}/create-voucher" class="btn-add">
                        + Create Voucher
                    </a>
                </div>
                <div class="table-card">
                    <table class="user-table">
                        <thead>
                            <tr>
                                <th class="col-no">No.</th>
                                <th class="col-code">Code</th>
                                <th class="col-value">Value</th>
                                <th class="col-min">Min Order</th>
                                <th class="col-date">Start Date</th>
                                <th class="col-date">End Date</th>
                                <th class="col-usage">Usage</th>
                                <th class="col-status" style="text-align:center">Status</th>
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
                                                <c:choose>
                                                    <c:when test="${v.discountValue <= 100}">
                                                        <strong><fmt:formatNumber value="${v.discountValue}" pattern="#,##0.##" />%</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <strong><fmt:formatNumber value="${v.discountValue}" pattern="#,##0" /> đ</strong>
                                                    </c:otherwise>
                                                </c:choose>
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
                                            <td class="col-status" style="text-align:center">
                                                <span class="status-badge ${v.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                                                    ${v.status}
                                                </span>
                                            </td>
                                            <td class="col-action" style="text-align:center">
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

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalVouchers} vouchers</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/manage-voucher?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/manage-voucher?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/manage-voucher?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.trim().toLowerCase();
                var tableBody = document.querySelector(".user-table tbody");
                var tr = tableBody.getElementsByTagName("tr");

                for (var i = 0; i < tr.length; i++) {
                    if (tr[i].classList.contains('empty-row')) continue;
                    
                    var tdCode = tr[i].getElementsByTagName("td")[1];
                    
                    if (tdCode) {
                        var codeText = tdCode.textContent || tdCode.innerText;
                        
                        if (codeText.toLowerCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            function confirmDelete(id) {
                if (confirm('Are you sure you want to delete this voucher? This will change status to INACTIVE.')) {
                    window.location.href = '${pageContext.request.contextPath}/manage-voucher/delete?id=' + id;
                }
            }
        </script>
    </body>
</html>
