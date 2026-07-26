<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Manage Staff - Admin</title>
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
            .cell-email {
                font-size: 12px;
                color: #555;
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
            .btn-toggle-status { background-color: #fff5f5; color: #e53e3e; border-color: #fed7d7; }
            .btn-toggle-status:hover { background-color: #e53e3e; color: #fff; border-color: #e53e3e; }
            .btn-toggle-active { background-color: #f0fdf4; color: #15803d; border-color: #dcfce7; }
            .btn-toggle-active:hover { background-color: #15803d; color: #fff; border-color: #15803d; }
            .btn-add-staff {
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
            .btn-add-staff:hover { background: #333; color: #fff; }
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
            <c:set var="activePage" value="manage-staff" scope="request" />
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center mb-4">
                    <div class="page-header mb-0">
                        <i class="bi bi-person-badge" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Manage Staff</h3>
                    </div>
                </div>



                <c:if test="${not empty sessionScope.successMsg}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert" id="alertMsg">
                        ${sessionScope.successMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="successMsg" scope="session"/>
                    </div>
                </c:if>

                <c:if test="${not empty sessionScope.errorMsg}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert" id="alertMsg">
                        ${sessionScope.errorMsg}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <c:remove var="errorMsg" scope="session"/>
                    </div>
                </c:if>

                <div class="d-flex justify-content-between align-items-center mb-3" style="min-height: 38px;">
                    <form action="${pageContext.request.contextPath}/admin/manage-staff" method="GET" class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0" style="border-top-left-radius: 50px; border-bottom-left-radius: 50px; padding-left: 14px;"><i class="bi bi-search" style="font-size: 14px; color: #888;"></i></span>
                        <input type="text" name="search" value="${searchQuery}" class="form-control border-start-0" placeholder="Search by name or email..." style="font-size: 13px; border-top-right-radius: 50px; border-bottom-right-radius: 50px; padding-right: 14px;">
                        <button type="submit" class="d-none"></button>
                    </form>
                    <button type="button" class="btn-add-staff" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                        + Add New Staff
                    </button>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 5%;">
                            <col style="width: 25%;">
                            <col style="width: 25%;">
                            <col style="width: 15%;">
                            <col style="width: 15%;">
                            <col style="width: 15%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>No.</th>
                                <th>Full Name</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Created At</th>
                                <th style="text-align:center">Actions</th>
                            </tr>
                        </thead>
                        <tbody id="staffTableBody">
                            <c:choose>
                                <c:when test="${not empty staffs}">
                                    <c:forEach var="staff" items="${staffs}" varStatus="status">
                                        <tr>
                                            <td><span class="cell-no">${status.index + 1}</span></td>
                                            <td><span class="cell-name">${staff.fullName}</span></td>
                                            <td><span class="cell-email">${staff.email}</span></td>
                                            <td>
                                                <span class="status-badge ${staff.status eq 'Active' ? 'badge-active' : 'badge-inactive'}">
                                                    ${staff.status}
                                                </span>
                                            </td>
                                            <td><span class="cell-date"><fmt:formatDate value="${staff.createdAt}" pattern="yyyy-MM-dd HH:mm"/></span></td>
                                            <td style="text-align:center">
                                                <div class="action-wrap">
                                                    <button type="button" onclick="openEditModal('${staff.id}', '${staff.email}', '${staff.fullName}')" class="btn-action btn-edit">Edit</button>
                                                    
                                                    <form action="${pageContext.request.contextPath}/admin/staff/toggle-status" method="POST" class="m-0">
                                                        <input type="hidden" name="id" value="${staff.id}">
                                                        <input type="hidden" name="currentStatus" value="${staff.status}">
                                                        <button type="submit" 
                                                                class="btn-action ${staff.status eq 'Active' ? 'btn-toggle-status' : 'btn-toggle-active'}">
                                                            ${staff.status eq 'Active' ? 'Deactivate' : 'Activate'}
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr class="empty-row">
                                        <td colspan="6">No staff members found.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>

                    <!-- Pagination Footer -->
                    <div class="pagination-footer">
                        <span class="pagination-info">Showing ${rangeStart}-${rangeEnd} of ${totalStaffs} staff</span>
                        <div class="pagination-controls">
                            <!-- Prev button -->
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-left"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/manage-staff?page=${currentPage - 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-left"></i></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-staff?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-staff?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
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
                                        <a href="${pageContext.request.contextPath}/admin/manage-staff?page=${p}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><c:out value="${p}" /></a>
                                    </c:otherwise>
                                </c:choose>
</c:if>

                            <!-- Next button -->
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <span class="page-btn disabled"><i class="bi bi-chevron-right"></i></span>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/manage-staff?page=${currentPage + 1}${not empty searchQuery ? '&search=' : ''}${not empty searchQuery ? searchQuery : ''}" class="page-btn"><i class="bi bi-chevron-right"></i></a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Add Staff Modal -->
        <div class="modal fade" id="addStaffModal" tabindex="-1" aria-labelledby="addStaffModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/staff/create" method="POST" onsubmit="return validateStaffForm()">
                  <div class="modal-header">
                    <h5 class="modal-title" id="addStaffModalLabel" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Add New Staff</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div id="addStaffError" class="alert alert-danger d-none" style="font-size: 13px; padding: 10px;"></div>
                      <div class="mb-3">
                          <label for="addFullName" class="form-label" style="font-size: 12px; font-weight: 600;">Full Name</label>
                          <input type="text" class="form-control form-control-sm" name="fullName" id="addFullName">
                      </div>
                      <div class="mb-3">
                          <label for="addEmail" class="form-label" style="font-size: 12px; font-weight: 600;">Email Address <span class="text-danger">*</span></label>
                          <input type="email" class="form-control form-control-sm" name="email" id="addEmail">
                      </div>
                      <div class="mb-3">
                          <label for="addPassword" class="form-label" style="font-size: 12px; font-weight: 600;">Password <span class="text-danger">*</span></label>
                          <input type="password" class="form-control form-control-sm" name="password" id="addPassword">
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark btn-sm">Save</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Edit Staff Modal -->
        <div class="modal fade" id="editStaffModal" tabindex="-1" aria-labelledby="editStaffModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <form action="${pageContext.request.contextPath}/admin/staff/update" method="POST" onsubmit="return validateEditStaffForm()">
                  <input type="hidden" name="id" id="editStaffId">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editStaffModalLabel" style="font-size: 14px; font-weight: 700; text-transform: uppercase;">Edit Staff</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                  </div>
                  <div class="modal-body">
                      <div id="editStaffError" class="alert alert-danger d-none" style="font-size: 13px; padding: 10px;"></div>
                      <div class="mb-3">
                          <label for="editFullName" class="form-label" style="font-size: 12px; font-weight: 600;">Full Name</label>
                          <input type="text" class="form-control form-control-sm" name="fullName" id="editFullName">
                      </div>
                      <div class="mb-3">
                          <label for="editEmail" class="form-label" style="font-size: 12px; font-weight: 600;">Email Address <span class="text-danger">*</span></label>
                          <input type="email" class="form-control form-control-sm" name="email" id="editEmail">
                      </div>
                      <div class="mb-3">
                          <label for="editPassword" class="form-label" style="font-size: 12px; font-weight: 600;">New Password <span class="text-danger">*</span></label>
                          <input type="password" class="form-control form-control-sm" name="password" id="editPassword" placeholder="Enter new password">
                      </div>
                  </div>
                  <div class="modal-footer">
                    <button type="button" class="btn btn-light btn-sm" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-dark btn-sm">Update</button>
                  </div>
              </form>
            </div>
          </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            let editModal = null;
            document.addEventListener("DOMContentLoaded", function() {
                editModal = new bootstrap.Modal(document.getElementById('editStaffModal'));
                
                // Auto-hide alerts after 3 seconds
                setTimeout(function() {
                    var alertMsg = document.getElementById('alertMsg');
                    if (alertMsg) {
                        var bsAlert = new bootstrap.Alert(alertMsg);
                        bsAlert.close();
                    }
                }, 3000);
            });

            function openEditModal(id, email, fullName) {
                document.getElementById('editStaffId').value = id;
                document.getElementById('editEmail').value = email;
                document.getElementById('editFullName').value = fullName;
                document.getElementById('editPassword').value = '';
                document.getElementById('editStaffError').classList.add('d-none');
                editModal.show();
            }

            function validateStaffForm() {
                const fullName = document.getElementById('addFullName').value.trim();
                const email = document.getElementById('addEmail').value.trim();
                const password = document.getElementById('addPassword').value.trim();
                const errorDiv = document.getElementById('addStaffError');
                
                if (fullName === '') {
                    errorDiv.textContent = 'Full Name cannot be empty or just spaces.';
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                
                if (email === '' || password === '') {
                    errorDiv.textContent = 'Email and Password are required fields and cannot be empty.';
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                return true;
            }
            
            function validateEditStaffForm() {
                const fullName = document.getElementById('editFullName').value.trim();
                const email = document.getElementById('editEmail').value.trim();
                const passwordInput = document.getElementById('editPassword').value;
                const errorDiv = document.getElementById('editStaffError');
                
                if (fullName === '') {
                    errorDiv.textContent = 'Full Name cannot be empty or just spaces.';
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                
                if (email === '') {
                    errorDiv.textContent = 'Email is a required field and cannot be empty.';
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                
                if (passwordInput.trim() === '') {
                    errorDiv.textContent = 'Password is required and cannot be empty or just spaces.';
                    errorDiv.classList.remove('d-none');
                    return false;
                }
                return true;
            }

            function searchTable() {
                var input = document.getElementById("searchInput");
                var filter = input.value.trim().toLowerCase();
                var tableBody = document.getElementById("staffTableBody");
                var tr = tableBody.getElementsByTagName("tr");

                for (var i = 0; i < tr.length; i++) {
                    if (tr[i].classList.contains('empty-row')) continue;
                    
                    var tdName = tr[i].getElementsByTagName("td")[1];
                    var tdEmail = tr[i].getElementsByTagName("td")[2];
                    
                    if (tdName && tdEmail) {
                        var txtValueName = tdName.textContent || tdName.innerText;
                        var txtValueEmail = tdEmail.textContent || tdEmail.innerText;
                        
                        if (txtValueName.toLowerCase().indexOf(filter) > -1 || txtValueEmail.toLowerCase().indexOf(filter) > -1) {
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

