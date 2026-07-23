<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
            rel="stylesheet">
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
            rel="stylesheet">

        <style>
            .adidis-sidebar {
                width: 240px;
                height: 100vh;
                position: fixed;
                top: 0;
                left: 0;
                background: #ffffff;
                border-right: 1px solid #e5e7eb;
                display: flex;
                flex-direction: column;
                padding: 24px 16px;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                z-index: 40;
                box-shadow: 2px 0 16px rgba(0, 0, 0, 0.03);
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

            .adidis-nav-item a .material-symbols-outlined {
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

            .adidis-footer a,
            .adidis-footer button {
                display: flex;
                align-items: center;
                gap: 12px;
                font-size: 12px;
                font-weight: 700;
                letter-spacing: 0.05em;
                text-transform: uppercase;
                color: #6b7280;
                text-decoration: none;
                background: transparent;
                border: none;
                padding: 0;
                cursor: pointer;
                transition: color 0.15s ease;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            }

            .adidis-footer a:hover,
            .adidis-footer button:hover {
                color: #000000;
            }

            .adidis-footer a .material-symbols-outlined,
            .adidis-footer button .material-symbols-outlined {
                font-size: 18px;
            }
        </style>

        <div class="adidis-sidebar">
            <div class="adidis-brand">
                <div class="adidis-brand-name">ADIDIS</div>
                <div class="adidis-brand-sub">Management Panel</div>
            </div>

            <ul class="adidis-nav">
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard"
                        class="${activePage eq 'dashboard' ? 'active' : ''}">
                        <span class="material-symbols-outlined">dashboard</span>
                        <span>Dashboard</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/manage-account"
                        class="${activePage eq 'user' ? 'active' : ''}">
                        <span class="material-symbols-outlined">group</span>
                        <span>Users</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/manage-staff"
                        class="${activePage eq 'manage-staff' ? 'active' : ''}">
                        <span class="material-symbols-outlined">badge</span>
                        <span>Manage Staff</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/audit-log"
                        class="${activePage eq 'audit-log' ? 'active' : ''}">
                        <span class="material-symbols-outlined">history</span>
                        <span>Audit Logs</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/manage-products"
                        class="${activePage eq 'manage-products' ? 'active' : ''}">
                        <span class="material-symbols-outlined">inventory_2</span>
                        <span>Products</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/manage-categories"
                        class="${activePage eq 'manage-categories' ? 'active' : ''}">
                        <span class="material-symbols-outlined">category</span>
                        <span>Categories</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/admin/manage-brands"
                        class="${activePage eq 'manage-brands' ? 'active' : ''}">
                        <span class="material-symbols-outlined">branding_watermark</span>
                        <span>Brands</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/import"
                        class="${activePage eq 'import' ? 'active' : ''}">
                        <span class="material-symbols-outlined">local_shipping</span>
                        <span>Confirm Import</span>
                    </a>
                </li>
                <li class="adidis-nav-item">
                    <a href="${pageContext.request.contextPath}/manage-voucher"
                        class="${activePage eq 'voucher' ? 'active' : ''}">
                        <span class="material-symbols-outlined">confirmation_number</span>
                        <span>Voucher</span>
                    </a>
                </li>
            </ul>

            <div class="adidis-footer">
                <form action="${pageContext.request.contextPath}/home" method="GET" style="margin:0;width:100%">
                    <button type="submit">
                        <span class="material-symbols-outlined">home</span>
                        <span>Back to Website</span>
                    </button>
                </form>
            </div>
        </div>