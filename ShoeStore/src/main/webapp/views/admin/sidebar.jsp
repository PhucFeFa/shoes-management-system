<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
    rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    body,
    h1,
    h2,
    h3,
    h4,
    h5,
    h6,
    p,
    span:not(.material-symbols-outlined),
    div,
    table,
    tr,
    td,
    th,
    a,
    button,
    input,
    select,
    textarea {
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif !important;
    }

    .adidis-sidebar {
        width: 220px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        background: #ffffff;
        border-right: 1px solid #e5e7eb;
        display: flex;
        flex-direction: column;
        padding: 32px 16px 24px;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        z-index: 1000;
    }

    .adidis-brand {
        padding: 0 12px 24px;
        border-bottom: 1px solid #e5e7eb;
        margin-bottom: 24px;
    }

    .adidis-brand-name {
        font-size: 20px;
        font-weight: 800;
        letter-spacing: -0.02em;
        color: #000000;
        text-transform: uppercase;
    }

    .adidis-brand-sub {
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        color: #9ca3af;
        margin-top: 4px;
    }

    .adidis-nav {
        list-style: none;
        margin: 0;
        padding: 0;
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .adidis-nav-item a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        color: #4b5563;
        text-decoration: none;
        border-radius: 8px;
        transition: all 0.15s ease;
    }

    .adidis-nav-item a:hover {
        color: #111827;
        background: #f3f4f6;
    }

    .adidis-nav-item a.active {
        background: #000000;
        color: #ffffff;
    }

    .adidis-nav-item a i {
        font-size: 18px;
        flex-shrink: 0;
    }

    .adidis-footer {
        padding: 24px 12px 0;
        border-top: 1px solid #e5e7eb;
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .adidis-footer a {
        display: flex;
        align-items: center;
        gap: 12px;
        font-size: 12px;
        font-weight: 700;
        letter-spacing: 0.05em;
        text-transform: uppercase;
        color: #6b7280;
        text-decoration: none;
        transition: color 0.15s ease;
    }

    .adidis-footer a:hover {
        color: #000000;
    }

    .adidis-footer a i {
        font-size: 18px;
    }

    .adidis-user-info {
        display: flex;
        align-items: center;
        gap: 12px;
        margin-top: 8px;
        padding-top: 16px;
        border-top: 1px solid #e5e7eb;
    }

    .adidis-avatar {
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: #f3f4f6;
        border: 1px solid #e5e7eb;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    .adidis-avatar i {
        font-size: 18px;
        color: #4b5563;
    }

    .adidis-user-details {
        display: flex;
        flex-direction: column;
        min-width: 0;
    }

    .adidis-user-name {
        font-size: 13px;
        font-weight: 700;
        color: #111827;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .adidis-user-role {
        font-size: 11px;
        font-weight: 500;
        color: #9ca3af;
    }

    .main-content {
        margin-left: 220px;
    }
</style>

<div class="adidis-sidebar">

    <div class="adidis-brand">
        <div class="adidis-brand-name">Adidis</div>
        <div class="adidis-brand-sub">${sessionScope.currentUser.roleName} Portal</div>
    </div>

    <ul class="adidis-nav">
        <li class="adidis-nav-item">
            <a href="${pageContext.request.contextPath}/dashboard"
                class="${activePage eq 'dashboard' ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
        </li>
        
        <c:if test="${sessionScope.currentUser.roleName == 'Admin'}">
            <li class="adidis-nav-item">
                <a href="${pageContext.request.contextPath}/manage-account"
                    class="${activePage eq 'user' ? 'active' : ''}">
                    <i class="bi bi-people"></i>
                    <span>Users</span>
                </a>
            </li>
        </c:if>

        <li class="adidis-nav-item">
            <a href="${pageContext.request.contextPath}/import"
                class="${activePage eq 'import' ? 'active' : ''}">
                <i class="bi bi-box-seam"></i>
                <span>Confirm Import</span>
            </a>
        </li>
    </ul>

    <div class="adidis-footer">
        <a href="${pageContext.request.contextPath}/home">
            <i class="bi bi-box-arrow-left"></i>
            <span>Logout</span>
        </a>
    </div>

</div>
