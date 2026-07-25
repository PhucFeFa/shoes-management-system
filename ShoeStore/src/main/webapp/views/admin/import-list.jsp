<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis Admin - Import Management</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f5f5f3; margin: 0; overflow-y: scroll; }
        .main-content { 
            margin-left: 256px; 
            padding: 32px 36px;
            min-height: 100vh;
            width: calc(100% - 256px); box-sizing: border-box;
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
            border-radius: 4px;
            border: 1px solid #e8e8e8;
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
            text-align: left;
        }
        .user-table tbody tr {
            border-bottom: 1px solid #f0f0f0;
            transition: background .12s;
        }
        .user-table tbody tr:last-child { border-bottom: none; }
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
        .empty-row td {
            text-align: center;
            padding: 48px;
            font-size: 12px;
            color: #aaa;
            letter-spacing: .06em;
            text-transform: uppercase;
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
        .cell-id {
            font-size: 12px;
            color: #bbb;
            font-weight: 600;
        }
        .form-control:focus {
            box-shadow: none;
            border-color: #dee2e6;
        }
        .input-group-text, .form-control {
            border-color: #dee2e6;
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
<body class="bg-[#f5f5f3] text-[#1a1c1c] antialiased flex min-h-screen">

    <c:set var="activePage" value="import" scope="request" />
    <jsp:include page="/views/admin/sidebar.jsp" />

    <main class="main-content flex-1 flex flex-col min-h-screen min-w-0">
        <div class="flex items-center mb-4">
            <div class="page-header mb-0">
                <i class="bi bi-box-seam" style="font-size:16px; color:#1a1a1a;"></i>
                <h3 class="page-title">Confirm Import</h3>
            </div>
        </div>
        
        <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
            <form action="${pageContext.request.contextPath}/import" method="GET" class="input-group" style="width: 300px;">
                <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search supplier or staff..." style="font-size: 13px;">
                <button type="submit" class="d-none"></button>
            </form>
        </div>

        <section class="flex-1">
            <div class="table-card">
                <table class="user-table" id="dataTable">
                    <colgroup>
                        <col style="width: 10%;">
                        <col style="width: 18%;">
                        <col style="width: 20%;">
                        <col style="width: 14%;">
                        <col style="width: 15%;">
                        <col style="width: 13%;">
                        <col style="width: 10%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Staff</th>
                            <th>Supplier</th>
                            <th>Date</th>
                            <th>Total Amount</th>
                            <th style="text-align:center">Status</th>
                            <th style="text-align:center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty importList}">
                                <tr class="empty-row">
                                    <td colspan="7">
                                        <div class="flex flex-col items-center gap-2">
                                            <i class="bi bi-box-seam" style="font-size: 24px; opacity: 0.5;"></i>
                                            <p>No import requests found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${importList}">
                                    <tr>
                                        <td><span class="cell-id">#<c:out value="${item.importID}"/></span></td>
                                        <td><span style="font-weight: 600; color: #1a1a1a;"><c:out value="${item.staffName}"/></span></td>
                                        <td><c:out value="${item.supplier}"/></td>
                                        <td style="color: #888;">
                                            <fmt:formatDate value="${item.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td style="font-weight: 600; color: #1a1a1a;">
                                            <fmt:formatNumber value="${item.totalAmount}" pattern="#,##0"/> đ
                                        </td>
                                        <td style="text-align:center">
                                            <c:set var="statusClass" value=""/>
                                            <c:choose>
                                                <c:when test="${item.status == 'REQUESTING' || item.status == 'PENDING'}">
                                                    <c:set var="statusClass" value="background: #e8f4fd; color: #1a6fa8; border: 1px solid #d2e9fc;"/>
                                                </c:when>
                                                <c:when test="${item.status == 'APPROVED' || item.status == 'SHIPPING'}">
                                                    <c:set var="statusClass" value="background: #fff8e6; color: #b38600; border: 1px solid #ffe8cc;"/>
                                                </c:when>
                                                <c:when test="${item.status == 'REPORTED'}">
                                                    <c:set var="statusClass" value="background: #f4e8fd; color: #7a1aa8; border: 1px solid #e9d5ff;"/>
                                                </c:when>
                                                <c:when test="${item.status == 'ACCEPTED' || item.status == 'COMPLETE' || item.status == 'COMPLETED'}">
                                                    <c:set var="statusClass" value="background: #f0fdf4; color: #15803d; border: 1px solid #dcfce7;"/>
                                                </c:when>
                                                <c:when test="${item.status == 'CANCELLED' || item.status == 'REJECTED'}">
                                                    <c:set var="statusClass" value="background: #fff5f5; color: #e53e3e; border: 1px solid #fed7d7;"/>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:set var="statusClass" value="background: #f5f5f5; color: #666; border: 1px solid #e8e8e8;"/>
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="status-badge" style="${statusClass}">
                                                <c:out value="${item.status}"/>
                                            </span>
                                        </td>
                                        <td style="text-align:center">
                                            <div class="action-wrap">
                                                <a href="${pageContext.request.contextPath}/admin/import-detail?id=${item.importID}" class="btn-action btn-view">View</a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
                
                <!-- Pagination Footer -->
                <div class="pagination-footer">
                    <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalImports} imports</span>
                    <div class="pagination-controls">
                        <!-- Prev button -->
                        <c:choose>
                            <c:when test="${currentPage <= 1}">
                                <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/import?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <c:choose>
                                <c:when test="${p == currentPage}">
                                    <span class="page-btn active"><c:out value="${p}" /></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/import?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- Next button -->
                        <c:choose>
                            <c:when test="${currentPage >= totalPages}">
                                <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/import?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <script>
        function searchTable() {
            var input, filter, table, tr, td1, td2, i, txtValue1, txtValue2;
            input = document.getElementById("searchInput");
            filter = input.value.toUpperCase();
            table = document.getElementById("dataTable");
            tr = table.getElementsByTagName("tr");

            for (i = 1; i < tr.length; i++) {
                if (tr[i].classList.contains('empty-row')) continue;
                
                td1 = tr[i].getElementsByTagName("td")[1]; // Staff
                td2 = tr[i].getElementsByTagName("td")[2]; // Supplier
                if (td1 || td2) {
                    txtValue1 = td1.textContent || td1.innerText;
                    txtValue2 = td2.textContent || td2.innerText;
                    if (txtValue1.toUpperCase().indexOf(filter) > -1 || txtValue2.toUpperCase().indexOf(filter) > -1) {
                        tr[i].style.display = "";
                    } else {
                        tr[i].style.display = "none";
                    }
                }       
            }
        }
    </script>
</body>
</html>

