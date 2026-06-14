<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Management - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/user.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3 col-lg-2 p-0 bg-dark sidebar-container">
                <c:set var="activePage" value="user" scope="request" />
                <jsp:include page="sidebar.jsp" />
            </div>

            <div class="col-md-9 col-lg-10 p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2><i class="bi bi-people-fill me-2"></i>Account List</h2>
                </div>

                <div class="card shadow-sm">
                    <div class="card-body p-0">
                        <table class="table table-hover table-striped mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th scope="col" class="ps-3 col-no">No.</th>
                                    <th scope="col" class="col-id">ID (UUID)</th>
                                    <th scope="col" class="col-name">Full Name</th>
                                    <th scope="col" class="col-email">Email</th>
                                    <th scope="col" class="col-role">Role</th> 
                                    <th scope="col" class="col-created">Created At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${not empty users}">
                                        <c:forEach items="${users}" var="u" varStatus="status">
                                            <tr>
                                                <td class="ps-3">${status.index + 1}</td>
                                                <td><small class="text-secondary uuid-text">${u.id}</small></td>
                                                <td><strong>${u.fullName != null ? u.fullName : 'Not updated'}</strong></td>
                                                <td>${u.email}</td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${u.roleName eq 'Customer'}">
                                                            <span class="badge bg-info text-dark">${u.roleName}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">${u.roleName}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${u.createdAt}</td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="6" class="text-center py-4 text-muted">
                                                No accounts found in the system.
                                            </td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>