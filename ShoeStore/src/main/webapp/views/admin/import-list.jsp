<%-- 
    Document   : import-list
    Created on : Jun 14, 2026, 5:05:44 PM
    Author     : Khoa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import Orders Management - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css">
</head>
<body>
    <div class="d-flex">
        <jsp:include page="sidebar.jsp" />

        <div class="container-fluid p-4" style="background-color: #f8f9fa; min-height: 100vh;">
            <div class="card shadow-sm border-0 p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h3 class="text-dark fw-bold m-0"><i class="bi bi-box-seam me-2 text-primary"></i> Import Orders</h3>
                    <button class="btn btn-primary btn-sm"><i class="bi bi-plus-lg me-1"></i> Create New Order</button>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle border-start border-end">
                        <thead class="table-light text-secondary">
                            <tr>
                                <th class="ps-3" style="width: 10%">Import ID</th>
                                <th style="width: 25%">Created By (User ID)</th>
                                <th style="width: 20%">Supplier</th>
                                <th style="width: 15%">Total Amount</th>
                                <th style="width: 15%">Order Date</th>
                                <th class="text-center" style="width: 15%">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty importList}">
                                    <c:forEach var="imp" items="${importList}">
                                        <tr>
                                            <td class="fw-bold text-primary ps-3">#${imp.importID}</td>
                                            <td class="text-muted"><small>${imp.userID}</small></td>
                                            <td class="fw-semibold text-dark">${imp.supplier}</td>
                                            <td class="text-danger fw-bold">
                                                <fmt:formatNumber value="${imp.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                            </td>
                                            <td class="text-secondary">
                                                <fmt:parseDate value="${imp.orderDate}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                                <fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy HH:mm"/>
                                            </td>
                                            <td class="text-center">
                                                <c:choose>
                                                    <c:when test="${imp.status eq 'completed'}">
                                                        <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill">Completed</span>
                                                    </c:when>
                                                    <c:when test="${imp.status eq 'shipping'}">
                                                        <span class="badge bg-warning-subtle text-warning px-3 py-2 rounded-pill">Shipping</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary-subtle text-secondary px-3 py-2 rounded-pill text-capitalize">${imp.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" class="text-center text-muted py-4">No import orders found in the system.</td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>