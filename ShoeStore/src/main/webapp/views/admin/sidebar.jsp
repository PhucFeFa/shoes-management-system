<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    .sole-sidebar {
        width: 220px;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        background: #ffffff;
        border-left: 4px solid #6C5CE7;
        display: flex;
        flex-direction: column;
        padding: 28px 0 24px;
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        box-shadow: 2px 0 12px rgba(0,0,0,0.05);
        z-index: 1000;
    }
    .sole-brand {
        padding: 0 24px 20px;
        border-bottom: 1px solid #f0f0f0;
        margin-bottom: 8px;
    }
    .sole-brand-name {
        font-size: 15px;
        font-weight: 700;
        letter-spacing: 0.08em;
        color: #1a1a1a;
    }
    .sole-brand-sub {
        font-size: 10px;
        font-weight: 600;
        letter-spacing: 0.14em;
        text-transform: uppercase;
        color: #aaa;
        margin-top: 3px;
    }
    .sole-nav {
        list-style: none;
        margin: 0;
        padding: 8px 0;
        flex: 1;
    }
    .sole-nav-item a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 11px 24px;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: #666;
        text-decoration: none;
        transition: background 0.12s, color 0.12s;
    }
    .sole-nav-item a:hover {
        color: #1a1a1a;
        background: #f5f3ff;
    }
    .sole-nav-item a.active {
        background: #1a1a1a;
        color: #ffffff;
    }
    .sole-nav-item a i {
        font-size: 16px;
        flex-shrink: 0;
        opacity: 0.85;
    }
    .sole-nav-item a.active i {
        opacity: 1;
    }
    .sole-footer {
        padding: 16px 24px 0;
        border-top: 1px solid #f0f0f0;
    }
    .sole-footer a {
        display: flex;
        align-items: center;
        gap: 10px;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        color: #999;
        text-decoration: none;
        transition: color 0.12s;
    }
    .sole-footer a:hover {
        color: #333;
    }
    .sole-footer a i {
        font-size: 16px;
    }
    .main-content {
        margin-left: 220px;
    }
</style>

<div class="sole-sidebar">

    <div class="sole-brand">
        <div class="sole-brand-name">ShoesStore</div>
    </div>

    <ul class="sole-nav">
        <li class="sole-nav-item">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="${activePage eq 'dashboard' ? 'active' : ''}">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="sole-nav-item">
            <a href="${pageContext.request.contextPath}/manage-account"
               class="${activePage eq 'user' ? 'active' : ''}">
                <i class="bi bi-people"></i>
                <span>Users</span>
            </a>
        </li>
        <li class="sole-nav-item">
            <a href="${pageContext.request.contextPath}/import"
               class="${activePage eq 'import' ? 'active' : ''}">
                <i class="bi bi-box-seam"></i>
                <span>Confirm Import</span>
            </a>
        </li>
    </ul>

    <div class="sole-footer">
        <form action="${pageContext.request.contextPath}/Logout" method="GET" style="margin: 0; width: 100%;">
            <button type="submit" style="background: none; border: none; width: 100%; text-align: left; display: flex; align-items: center; gap: 10px; cursor: pointer; color: inherit; font: inherit; padding: 0;">
                <i class="bi bi-box-arrow-left"></i>
                <span>Logout</span>
            </button>
        </form>
    </div>

</div>
