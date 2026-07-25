<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Product Variants - Admin</title>
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
            .info-card {
                background: #fff;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                padding: 24px;
                margin-bottom: 24px;
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
            .cell-no { font-size: 12px; color: #bbb; font-weight: 600; }
            .cell-name { font-weight: 600; color: #1a1a1a; }
            .action-wrap {
                display: flex;
                gap: 6px;
                justify-content: center;
                align-items: center;
                flex-wrap: nowrap;
            }
            .btn-action {
                border: none;
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                padding: 5px 10px;
                border-radius: 4px;
                cursor: pointer;
                transition: opacity .15s;
                white-space: nowrap;
            }
            .btn-action:hover { opacity: 0.8; }
            .btn-edit { background: #e8f0fe; color: #1967d2; }
            .btn-delete { background: #fce8e6; color: #d93025; }
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
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-add:hover { background: #000; }
            .btn-back {
                background: #e2e8f0;
                color: #475569;
                text-decoration: none;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 0 16px;
                height: 38px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 4px;
            }
            .btn-back:hover { background: #cbd5e1; color: #334155; }
            
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
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-2">
                    <div class="page-header mb-0">
                        <i class="bi bi-box-seam" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Manage Variants: ${product.name}</h3>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/admin/product/details" method="GET" class="input-group" style="width: 300px;">
                        <input type="hidden" name="id" value="${product.id}">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${param.search}" class="form-control border-start-0" placeholder="Search variants..." style="font-size: 13px;">
                        <button type="submit" class="d-none"></button>
                    </form>
                    <button type="button" class="btn-add" data-bs-toggle="modal" data-bs-target="#addVariantModal">
                        + Add New Variant
                    </button>
                </div>

                <c:if test="${not empty sessionScope.successMsg}">
                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert">
                        ${sessionScope.successMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="successMsg" scope="session"/>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.errorMsg}">
                    <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
                        ${sessionScope.errorMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="errorMsg" scope="session"/>
                    </div>
                </c:if>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 10%;">
                            <col style="width: 25%;">
                            <col style="width: 25%;">
                            <col style="width: 20%;">
                            <col style="width: 20%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Size</th>
                                <th>Color</th>
                                <th>Stock Qty</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty variants}">
                                    <c:forEach var="v" items="${variants}" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td><span class="cell-name">${v.size}</span></td>
                                            <td><span class="cell-name" style="text-transform: capitalize;">${v.color}</span></td>
                                            <td><span class="cell-name">${v.stockQuantity}</span></td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <button type="button" class="btn-action btn-edit" onclick="editVariant('${v.id}', '${v.size}', '${v.color}')">Edit</button>
                                                    <form action="${pageContext.request.contextPath}/admin/product/details" method="POST" style="margin: 0; display: inline-block;" onsubmit="return confirm('Are you sure you want to delete this variant?');">
                                                        <input type="hidden" name="action" value="delete_variant">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="variantId" value="${v.id}">
                                                        <button type="submit" class="btn-action btn-delete">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" style="text-align:center; padding: 30px;">No variants found for this product.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalDetails} variants</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/product/details?id=${product.id}&page=${currentPage - 1}${not empty param.search ? '&search=' : ''}${not empty param.search ? param.search : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
                                </c:otherwise>
                            </c:choose>

                            <!-- Page numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="p">
                                <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <span class="page-btn active"><c:out value="${p}" /></span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/admin/product/details?id=${product.id}&page=${p}${not empty param.search ? '&search=' : ''}${not empty param.search ? param.search : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/product/details?id=${product.id}&page=${currentPage + 1}${not empty param.search ? '&search=' : ''}${not empty param.search ? param.search : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Add Variant Modal -->
        <div class="modal fade" id="addVariantModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/product/details" method="POST">
                  <input type="hidden" name="action" value="add_variant">
                  <input type="hidden" name="productId" value="${product.id}">
                  <div class="modal-header">
                    <h5 class="modal-title" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Add New Variant</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Size <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="size" required placeholder="e.g. 40, 41, 42">
                      </div>
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Color <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="color" required placeholder="e.g. Black, White, Red">
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark">Save Variant</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Edit Variant Modal -->
        <div class="modal fade" id="editVariantModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/product/details" method="POST">
                  <input type="hidden" name="action" value="edit_variant">
                  <input type="hidden" name="productId" value="${product.id}">
                  <input type="hidden" name="variantId" id="editVariantId">
                  <div class="modal-header">
                    <h5 class="modal-title" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Edit Variant</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Size <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="size" id="editVariantSize" required>
                      </div>
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Color <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="color" id="editVariantColor" required>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark">Save Changes</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function editVariant(id, size, color) {
                document.getElementById('editVariantId').value = id;
                document.getElementById('editVariantSize').value = size;
                document.getElementById('editVariantColor').value = color;
                var modal = new bootstrap.Modal(document.getElementById('editVariantModal'));
                modal.show();
            }

            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.toLowerCase();
                var table = document.querySelector(".user-table");
                var trs = table.querySelectorAll("tbody tr");

                trs.forEach(function(tr) {
                    var text = tr.textContent.toLowerCase();
                    if (text.includes(filter)) {
                        tr.style.display = "";
                    } else {
                        tr.style.display = "none";
                    }
                });
            }
        </script>
    </body>
</html>
