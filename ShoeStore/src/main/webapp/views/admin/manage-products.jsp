<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Products - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; }
            body {
                background: #f5f5f3;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                margin: 0;
            }
            .main-content {
                margin-left: 220px;
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
            .badge-active { background: #e6f4ea; color: #1e7e34; }
            .badge-inactive { background: #f8d7da; color: #b21f2d; }
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
            }
            .btn-edit { background-color: #e8f4fd; color: #1a6fa8; }
            .btn-edit:hover { background-color: #d2e9fc; color: #0b4f7c; }
            .btn-delete { background-color: #fff5f5; color: #e53e3e; border-color: #fed7d7; }
            .btn-delete:hover { background-color: #e53e3e; color: #fff; border-color: #e53e3e; }
            .btn-add-product {
                background: #1a1a1a;
                color: #fff;
                font-size: 11px;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: .05em;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                transition: 0.2s;
            }
            .btn-add-product:hover { background: #333; color: #fff; }
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
            .product-img {
                width: 40px;
                height: 40px;
                object-fit: contain;
                background: #f8f9fa;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
            }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <c:set var="activePage" value="manage-products" scope="request" />
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-box-seam" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Manage Products</h3>
                    </div>
                    <button type="button" class="btn-add-product" onclick="alert('Add New Product function will be implemented soon.')">
                        + Add New Product
                    </button>
                </div>

                <div class="d-flex justify-content-end mb-3">
                    <form onsubmit="event.preventDefault(); searchTable();" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" id="searchInput" onkeyup="searchTable()" class="form-control border-start-0" placeholder="Search product name..." style="font-size: 13px;">
                    </form>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 5%;">
                            <col style="width: 8%;">
                            <col style="width: 25%;">
                            <col style="width: 12%;">
                            <col style="width: 12%;">
                            <col style="width: 12%;">
                            <col style="width: 10%;">
                            <col style="width: 16%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Image</th>
                                <th>Product Name</th>
                                <th>Brand</th>
                                <th>Category</th>
                                <th>Price</th>
                                <th>Status</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="ProductTableBody">
                            <c:choose>
                                <c:when test="${not empty products}">
                                    <c:forEach var="product" items="${products}" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td>
                                                <img src="${not empty product.firstImageUrl ? product.firstImageUrl : 'https://via.placeholder.com/40'}" class="product-img" alt="${product.name}">
                                            </td>
                                            <td><span class="cell-name">${product.name}</span></td>
                                            <td><span class="cell-brand">${product.brand.name}</span></td>
                                            <td><span class="cell-category">${product.category.name}</span></td>
                                            <td><span class="cell-price"><fmt:formatNumber value="${product.price}" pattern="#,##0" /> đ</span></td>
                                            <td>
                                                <span class="status-badge ${product.status eq 'active' ? 'badge-active' : 'badge-inactive'}">
                                                    ${product.status}
                                                </span>
                                            </td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <button type="button" onclick="alert('Edit Product function will be implemented soon.')" class="btn-action btn-edit">Edit</button>
                                                    <button type="button" onclick="alert('Delete Product function will be implemented soon.')" class="btn-action btn-delete">Delete</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="8">No products found.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.trim().toLowerCase();
                var tableBody = document.getElementById("ProductTableBody");
                var tr = tableBody.getElementsByTagName("tr");

                for (var i = 0; i < tr.length; i++) {
                    if (tr[i].classList.contains('empty-row')) continue;
                    
                    var tdName = tr[i].getElementsByTagName("td")[2];
                    var tdBrand = tr[i].getElementsByTagName("td")[3];
                    var tdCategory = tr[i].getElementsByTagName("td")[4];
                    
                    if (tdName && tdBrand && tdCategory) {
                        var txtValueName = tdName.textContent || tdName.innerText;
                        var txtValueBrand = tdBrand.textContent || tdBrand.innerText;
                        var txtValueCategory = tdCategory.textContent || tdCategory.innerText;
                        
                        if (txtValueName.toLowerCase().indexOf(filter) > -1 || 
                            txtValueBrand.toLowerCase().indexOf(filter) > -1 || 
                            txtValueCategory.toLowerCase().indexOf(filter) > -1) {
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
