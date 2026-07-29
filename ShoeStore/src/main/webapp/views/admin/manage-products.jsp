<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Products - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
        <!-- Select2 CSS -->
        <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            /* Custom Select2 Styling to match screenshot */
            .select2-container--default .select2-selection--single {
                border: 1px solid #ced4da;
                border-radius: 8px;
                height: 42px;
                display: flex;
                align-items: center;
                background-color: #fff;
            }
            .select2-container--default .select2-selection--single .select2-selection__rendered {
                color: #334155;
                font-size: 14px;
                font-weight: 500;
                padding-left: 16px;
                line-height: 40px;
            }
            .select2-container--default .select2-selection--single .select2-selection__arrow {
                height: 40px;
                right: 12px;
            }
            .select2-container--default.select2-container--open .select2-selection--single {
                border-color: #94a3b8;
            }
            
            /* The Dropdown List */
            .custom-dropdown-style {
                border: 1px solid #e2e8f0;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
                margin-top: 8px;
                overflow: hidden;
            }
            .custom-dropdown-style .select2-results__options {
                padding: 0;
                margin: 0;
            }
            .custom-dropdown-style .select2-results__option {
                padding: 14px 16px;
                font-size: 14px;
                font-weight: 600;
                color: #1e293b;
                border-bottom: 1px solid #f1f5f9;
                background-color: #fff;
            }
            .custom-dropdown-style .select2-results__option:last-child {
                border-bottom: none;
            }
            .custom-dropdown-style .select2-results__option--highlighted[aria-selected] {
                background-color: #f8fafc;
                color: #0f172a;
            }
            .custom-dropdown-style .select2-results__option[aria-selected=true] {
                background-color: #f1f5f9;
                color: #0f172a;
            }

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
                min-width: 60px;
            }
            .btn-action.btn-variants {
                min-width: 76px;
                background-color: #1a1a1a;
                color: #ffffff;
                border-color: #1a1a1a;
            }
            .btn-action.btn-variants:hover {
                background-color: #333333;
                color: #ffffff;
                border-color: #333333;
            }
            .btn-edit { background-color: #e8f4fd; color: #1a6fa8; }
            .btn-edit:hover { background-color: #d2e9fc; color: #0b4f7c; }
            .btn-delete { background-color: #fff5f5; color: #e53e3e; border-color: #fed7d7; }
            .btn-delete:hover { background-color: #e53e3e; color: #fff; border-color: #e53e3e; }
            .btn-show { background-color: #f0fdf4; color: #15803d; border-color: #dcfce7; }
            .btn-show:hover { background-color: #15803d; color: #fff; border-color: #15803d; }
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
            <c:set var="activePage" value="manage-products" scope="request" />
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-box-seam" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Manage Products</h3>
                    </div>
                </div>



                <c:if test="${not empty sessionScope.successMsg}">
                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert" id="alertMsg">
                        ${sessionScope.successMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="successMsg" scope="session"/>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.errorMsg}">
                    <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert" id="alertMsg">
                        ${sessionScope.errorMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="errorMsg" scope="session"/>
                    </div>
                </c:if>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/admin/manage-products" method="GET" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0" style="border-top-left-radius: 50px; border-bottom-left-radius: 50px; padding-left: 14px;"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search product name..." style="font-size: 13px; border-top-right-radius: 50px; border-bottom-right-radius: 50px; padding-right: 14px;">
                        <button type="submit" class="d-none"></button>
                    </form>
                    <button type="button" class="btn-add-product" data-bs-toggle="modal" data-bs-target="#addProductModal">
                        + Add New Product
                    </button>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 4%;">
                            <col style="width: 8%;">
                            <col style="width: 22%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 10%;">
                            <col style="width: 26%;">
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
                                                <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${not empty product.firstImageUrl ? product.firstImageUrl : 'https://via.placeholder.com/40'}" class="product-img" alt="${product.name}">
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
                                                    <a href="${pageContext.request.contextPath}/admin/product/details?id=${product.id}" class="btn-action btn-variants">Variants</a>
                                                    <button type="button" class="btn-action btn-edit" 
                                                            data-id="${product.id}" 
                                                            data-name="${product.name}" 
                                                            data-category="${product.category.name}" 
                                                            data-brand="${product.brand.name}" 
                                                            data-price="<fmt:formatNumber value='${product.price}' pattern='0' />" 
                                                            data-desc="${product.description}"
                                                            onclick="editProduct(this)">Edit</button>
                                                    <form action="${pageContext.request.contextPath}/admin/product/toggle-status" method="POST" style="margin: 0;">
                                                        <input type="hidden" name="id" value="${product.id}">
                                                        <c:choose>
                                                            <c:when test="${product.status eq 'active'}">
                                                                <button type="submit" class="btn-action btn-delete">Hide</button>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <button type="submit" class="btn-action btn-show">Show</button>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
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

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalProducts} products</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/manage-products?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-products?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-products?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-products?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/manage-products?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/product/create" method="POST" enctype="multipart/form-data">
                  <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Add New Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Product Name <span class="text-danger">*</span></label>
                              <input type="text" class="form-control form-control-sm" name="name" required>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Category <span class="text-danger">*</span></label>
                              <select class="form-select form-select-sm select2-dropdown" name="categoryName" required style="width: 100%;">
                                  <option value="">Select Category...</option>
                                  <c:forEach var="c" items="${categories}">
                                      <option value="${c.name}">${c.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Brand <span class="text-danger">*</span></label>
                              <select class="form-select form-select-sm select2-dropdown" name="brandName" required style="width: 100%;">
                                  <option value="">Select Brand...</option>
                                  <c:forEach var="b" items="${brands}">
                                      <option value="${b.name}">${b.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Base Price <span class="text-danger">*</span></label>
                              <input type="number" step="0.01" class="form-control form-control-sm" name="price" required>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Product Image</label>
                              <input type="file" class="form-control form-control-sm" name="productImages" accept=".jpg, .jpeg, .png, .webp">
                              <div class="form-text" style="font-size: 10px;">Select an image for the product. Supported formats: JPG, PNG, WEBP. Max size: 2MB.</div>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Description</label>
                              <textarea class="form-control form-control-sm" name="description" rows="3"></textarea>
                          </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark btn-sm">Save Product</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Edit Product Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/product/edit" method="POST" enctype="multipart/form-data">
                  <input type="hidden" name="id" id="editProductId">
                  <input type="hidden" name="page" value="${currentPage}">
                  <div class="modal-header border-0 pb-0">
                    <h5 class="modal-title" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Edit Product</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Product Name <span class="text-danger">*</span></label>
                              <input type="text" class="form-control form-control-sm" name="name" id="editProductName" required>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Category <span class="text-danger">*</span></label>
                              <select class="form-select form-select-sm select2-dropdown-edit" name="categoryName" id="editProductCategory" required style="width: 100%;">
                                  <option value="">Select Category...</option>
                                  <c:forEach var="c" items="${categories}">
                                      <option value="${c.name}">${c.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Brand <span class="text-danger">*</span></label>
                              <select class="form-select form-select-sm select2-dropdown-edit" name="brandName" id="editProductBrand" required style="width: 100%;">
                                  <option value="">Select Brand...</option>
                                  <c:forEach var="b" items="${brands}">
                                      <option value="${b.name}">${b.name}</option>
                                  </c:forEach>
                              </select>
                          </div>
                          <div class="col-md-4 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Base Price <span class="text-danger">*</span></label>
                              <input type="number" step="0.01" class="form-control form-control-sm" name="price" id="editProductPrice" required>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Update Image</label>
                              <input type="file" class="form-control form-control-sm" name="productImages" accept=".jpg, .jpeg, .png, .webp">
                              <div class="form-text" style="font-size: 10px;">Upload a new image to replace the current one. Supported formats: JPG, PNG, WEBP. Max size: 2MB.</div>
                          </div>
                      </div>
                      
                      <div class="row">
                          <div class="col-md-12 mb-3">
                              <label class="form-label" style="font-size: 12px; font-weight: 600;">Description</label>
                              <textarea class="form-control form-control-sm" name="description" id="editProductDescription" rows="3"></textarea>
                          </div>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark btn-sm">Save Changes</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <!-- jQuery and Select2 JS -->
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        <script>
            $(document).ready(function() {
                $('.select2-dropdown').select2({
                    dropdownParent: $('#addProductModal'),
                    width: '100%',
                    minimumResultsForSearch: Infinity,
                    dropdownCssClass: 'custom-dropdown-style'
                });
                $('.select2-dropdown-edit').select2({
                    dropdownParent: $('#editProductModal'),
                    width: '100%',
                    minimumResultsForSearch: Infinity,
                    dropdownCssClass: 'custom-dropdown-style'
                });
            });

            function editProduct(btn) {
                var id = btn.getAttribute('data-id');
                var name = btn.getAttribute('data-name');
                var category = btn.getAttribute('data-category');
                var brand = btn.getAttribute('data-brand');
                var price = btn.getAttribute('data-price');
                var desc = btn.getAttribute('data-desc');

                document.getElementById('editProductId').value = id;
                document.getElementById('editProductName').value = name;
                document.getElementById('editProductPrice').value = price;
                document.getElementById('editProductDescription').value = (desc && desc !== 'null') ? desc : '';
                
                $('#editProductCategory').val(category).trigger('change');
                $('#editProductBrand').val(brand).trigger('change');
                
                var modal = new bootstrap.Modal(document.getElementById('editProductModal'));
                modal.show();
            }

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



