<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

<style>
    .sole-sidebar {
        width: 256px; /* 64 x 4 giống thiết kế w-64 */
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        background: #f9f9f9; /* Màu nền surface mờ */
        border-right: 1px solid #e2e2e2; /* Đường kẻ viền bên phải */
        display: flex;
        flex-direction: column;
        padding: 8px 0;
        font-family: 'Inter', sans-serif;
        z-index: 1000;
    }
    .sole-brand {
        padding: 32px 24px;
        border-bottom: 1px solid rgba(226, 226, 226, 0.5);
    }
    .sole-brand-name {
        font-size: 24px;
        font-weight: 700;
        letter-spacing: -0.02em;
        color: #000000;
        text-transform: uppercase;
    }
    .sole-brand-sub {
        font-size: 12px;
        color: #5d5f5f;
        margin-top: 4px;
        font-weight: 500;
    }
    .sole-nav {
        list-style: none;
        margin: 0;
        padding: 24px 16px;
        flex: 1;
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    .sole-nav-item a {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 12px 16px;
        font-size: 14px;
        font-weight: 600;
        text-transform: uppercase;
        color: #5d5f5f; /* Màu chữ secondary nhạt */
        text-decoration: none;
        border-radius: 4px;
        transition: all 0.15s ease;
    }
    .sole-nav-item a:hover {
        color: #000000;
        background: #f3f3f4; /* Hiệu ứng hover xám nhạt */
    }
    /* Giao diện nút Active giống hệt trang Profile trong ảnh */
    .sole-nav-item a.active {
        background: #000000;
        color: #ffffff;
        font-weight: 700;
    }
    .sole-nav-item a .material-symbols-outlined {
        font-size: 20px;
    }
    .sole-footer {
        padding: 24px 16px;
        border-top: 1px solid rgba(226, 226, 226, 0.5);
    }
    .sole-footer a {
        background: none;
        border: none;
        width: 100%;
        text-align: left;
        display: flex;
        align-items: center;
        gap: 12px;
        cursor: pointer;
        padding: 8px 16px;
        font-size: 12px;
        font-weight: 500;
        text-transform: uppercase;
        color: #5d5f5f;
        border-radius: 4px;
        transition: background 0.15s, color 0.15s;
        text-decoration: none;
    }
    .sole-footer a:hover {
        color: #000000;
        background: #f3f3f4;
    }
    .sole-footer a .material-symbols-outlined {
        font-size: 18px;
    }
    /* Đảm bảo nội dung trang chính thụt lề chuẩn theo sidebar mới */
    .main-content {
        margin-left: 256px;
    }
</style>

<div class="sole-sidebar">

    <div class="sole-brand">
        <div class="sole-brand-name">ADIDIS</div>
        <div class="sole-brand-sub">Management Panel</div>
    </div>

    <ul class="sole-nav">
        <li class="sole-nav-item">
            <a href="${pageContext.request.contextPath}/dashboard"
               class="${activePage eq 'dashboard' ? 'active' : ''}">
                <span class="material-symbols-outlined">dashboard</span>
                <span>Dashboard</span>
            </a>
        </li>
        
        <c:if test="${sessionScope.currentUser.roleName eq 'Admin'}">
            <li class="sole-nav-item">
                <a href="${pageContext.request.contextPath}/manage-account"
                   class="${activePage eq 'user' ? 'active' : ''}">
                    <span class="material-symbols-outlined">group</span>
                    <span>Customers</span>
                </a>
            </li>
            <li class="sole-nav-item">
                <a href="${pageContext.request.contextPath}/import"
                   class="${activePage eq 'import' ? 'active' : ''}">
                    <span class="material-symbols-outlined">local_shipping</span>
                    <span>Confirm Import</span>
                </a>
            </li>
            <li class="sole-nav-item">
                <a href="${pageContext.request.contextPath}/manage-voucher"
                   class="${activePage eq 'voucher' ? 'active' : ''}">
                    <span class="material-symbols-outlined">confirmation_number</span>
                    <span>Voucher</span>
                </a>
            </li>
        </c:if>

        <c:if test="${sessionScope.currentUser.roleName eq 'Staff'}">
            <li class="sole-nav-item">
                <a href="${pageContext.request.contextPath}/staff/orders"
                   class="${activePage eq 'orders' ? 'active' : ''}">
                    <span class="material-symbols-outlined">receipt_long</span>
                    <span>Order Management</span>
                </a>
            </li>
            <li class="sole-nav-item">
                <a href="${pageContext.request.contextPath}/staff/request"
                   class="${activePage eq 'request' ? 'active' : ''}">
                    <span class="material-symbols-outlined">description</span>
                    <span>Request Import</span>
                </a>
            </li>
        </c:if>
    </ul>

    <div class="sole-footer">
        <a href="${pageContext.request.contextPath}/home">
            <span class="material-symbols-outlined">logout</span>
            <span>Back to Website</span>
        </a>
    </div>

</div>