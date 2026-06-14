<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/sidebar.css">

<div class="d-flex flex-column flex-shrink-0 p-3 text-white bg-dark sidebar-admin">
    <a href="${pageContext.request.contextPath}/admin" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="bi bi-shop me-2"></i>
        <span class="fs-4">ShoeStore Admin</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin" 
               class="nav-link ${activePage eq 'dashboard' ? 'active' : 'text-white'}">
                <i class="bi bi-speedometer2 me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item">
            <a href="${pageContext.request.contextPath}/manage-account" 
               class="nav-link ${activePage eq 'user' ? 'active' : 'text-white'}">
                <i class="bi bi-people me-2"></i> User
            </a>
        </li>
    </ul>
    <hr>
    <div class="dropdown">
        <a href="${pageContext.request.contextPath}/home.jsp" class="text-white text-decoration-none">
            <i class="bi bi-box-arrow-left me-2"></i> Back to Website
        </a>
    </div>
</div>