<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Categories - Admin</title>
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
            .btn-add {
                background: #1a1a1a;
                color: #fff;
                border: none;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 10px 16px;
                border-radius: 4px;
                cursor: pointer;
            }
            .btn-add:hover { background: #000; }
        </style>
    </head>
    <body>
        <div class="d-flex">
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-tag" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Manage Categories</h3>
                    </div>
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

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <button type="button" class="btn-add" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                        + Add New Category
                    </button>
                    <form onsubmit="event.preventDefault(); searchTable();" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" id="searchInput" onkeyup="searchTable()" class="form-control border-start-0" placeholder="Search category name..." style="font-size: 13px;">
                    </form>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 10%;">
                            <col style="width: 60%;">
                            <col style="width: 30%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Category Name</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty categories}">
                                    <c:forEach var="c" items="${categories}" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td><span class="cell-name">${c.name}</span></td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <button type="button" class="btn-action btn-edit" onclick="editCategory('${c.id}', '${c.name}')">Edit</button>
                                                    <form action="${pageContext.request.contextPath}/admin/manage-categories" method="POST" style="margin: 0; display: inline-block;" onsubmit="return confirm('Are you sure you want to delete this category?');">
                                                        <input type="hidden" name="action" value="delete">
                                                        <input type="hidden" name="id" value="${c.id}">
                                                        <button type="submit" class="btn-action btn-delete">Delete</button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="3" style="text-align:center">No categories found.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- Add Category Modal -->
        <div class="modal fade" id="addCategoryModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/manage-categories" method="POST">
                  <input type="hidden" name="action" value="add">
                  <div class="modal-header">
                    <h5 class="modal-title" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Add New Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Category Name <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="name" required>
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark">Save Category</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Edit Category Modal -->
        <div class="modal fade" id="editCategoryModal" tabindex="-1" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/manage-categories" method="POST">
                  <input type="hidden" name="action" value="edit">
                  <input type="hidden" name="id" id="editCategoryId">
                  <div class="modal-header">
                    <h5 class="modal-title" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Edit Category</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div class="mb-3">
                          <label class="form-label" style="font-size: 12px; font-weight: 600;">Category Name <span class="text-danger">*</span></label>
                          <input type="text" class="form-control" name="name" id="editCategoryName" required>
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
            function editCategory(id, name) {
                document.getElementById('editCategoryId').value = id;
                document.getElementById('editCategoryName').value = name;
                var modal = new bootstrap.Modal(document.getElementById('editCategoryModal'));
                modal.show();
            }

            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.trim().toLowerCase();
                var tbody = document.querySelector(".user-table tbody");
                var tr = tbody.getElementsByTagName("tr");
                
                for (var i = 0; i < tr.length; i++) {
                    var tdName = tr[i].getElementsByTagName("td")[1];
                    if (tdName) {
                        var txtValue = tdName.textContent || tdName.innerText;
                        if (txtValue.toLowerCase().indexOf(filter) > -1) {
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
