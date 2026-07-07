<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis - Import Requests</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- Material Symbols -->
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
        rel="stylesheet">
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }

        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }

        body, h1, h2, h3, h4, h5, h6, p, span:not(.material-symbols-outlined), div, table, tr, td, th, a, button, input, select, textarea {
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
            margin-left: 256px;
        }
    </style>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "tertiary-fixed": "#e2e2e2",
                        "primary-fixed": "#e2e2e2",
                        "outline": "#7e7576",
                        "on-surface": "#1a1c1c",
                        "on-secondary": "#ffffff",
                        "on-secondary-fixed": "#1a1c1c",
                        "secondary-fixed": "#e2e3e2",
                        "surface-dim": "#dadada",
                        "secondary": "#5d5f5f",
                        "on-error": "#ffffff",
                        "primary-fixed-dim": "#c6c6c6",
                        "surface-container-highest": "#e2e2e2",
                        "on-primary-fixed-variant": "#474747",
                        "on-error-container": "#93000a",
                        "error": "#ba1a1a",
                        "error-container": "#ffdad6",
                        "on-secondary-fixed-variant": "#454747",
                        "surface-container-high": "#e8e8e8",
                        "surface-tint": "#5e5e5e",
                        "on-primary-container": "#848484",
                        "inverse-on-surface": "#f0f1f1",
                        "on-tertiary-fixed-variant": "#474747",
                        "surface-container-low": "#f3f3f4",
                        "on-surface-variant": "#444748",
                        "tertiary-container": "#1b1b1b",
                        "on-primary": "#ffffff",
                        "outline-variant": "#c4c7c7",
                        "secondary-container": "#e2e3e2",
                        "on-primary-fixed": "#1b1b1b",
                        "tertiary": "#000000",
                        "primary-container": "#1b1b1b",
                        "surface": "#f9f9f9",
                        "surface-container": "#eeeeee",
                        "inverse-surface": "#2f3131",
                        "secondary-fixed-dim": "#c6c7c6",
                        "tertiary-fixed-dim": "#c6c6c6",
                        "surface-container-lowest": "#ffffff",
                        "background": "#f9f9f9",
                        "on-secondary-container": "#636565",
                        "inverse-primary": "#c6c6c6",
                        "surface-bright": "#f9f9f9",
                        "on-tertiary-container": "#848484",
                        "on-tertiary-fixed": "#1b1b1b",
                        "primary": "#000000",
                        "on-tertiary": "#ffffff",
                        "surface-variant": "#e2e2e2",
                        "on-background": "#1a1c1c"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "container-max": "1440px",
                        "margin-mobile": "20px",
                        "gutter": "24px",
                        "margin-tablet": "32px",
                        "margin-desktop": "64px",
                        "base": "8px"
                    },
                    "fontFamily": {
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-lg": ["Inter"],
                        "headline-lg": ["Inter"],
                        "display-lg-mobile": ["Inter"],
                        "label-md": ["Inter"],
                        "headline-md": ["Inter"]
                    },
                    "fontSize": {
                        "body-md": ["16px", { "lineHeight": "1.5", "letterSpacing": "0", "fontWeight": "400" }],
                        "label-sm": ["12px", { "lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "500" }],
                        "display-lg": ["72px", { "lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800" }],
                        "body-lg": ["18px", { "lineHeight": "1.6", "letterSpacing": "0", "fontWeight": "400" }],
                        "headline-lg": ["32px", { "lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700" }],
                        "display-lg-mobile": ["40px", { "lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "800" }],
                        "label-md": ["14px", { "lineHeight": "1.0", "letterSpacing": "0.05em", "fontWeight": "600" }],
                        "headline-md": ["24px", { "lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "600" }]
                    }
                }
            }
        }
    </script>
</head>

<body
    class="bg-background text-on-background font-body-md text-body-md antialiased flex selection:bg-primary selection:text-on-primary min-h-screen">

    <!-- ===================== SideNavBar ===================== -->
    <c:set var="activePage" value="import-requests" scope="request" />
    <jsp:include page="/views/staff/sidebar.jsp" />

    <!-- ===================== Main Content ===================== -->
    <main class="main-content flex-1 flex flex-col min-h-screen">

        <!-- Header Section -->
        <header
            class="px-margin-desktop pt-margin-desktop pb-8 flex justify-between items-end border-b border-outline-variant/30">
            <div>
                <h2 class="font-headline-lg text-headline-lg text-primary tracking-tight">Import Requests</h2>
                <p class="font-body-md text-body-md text-secondary mt-2 max-w-lg">
                    Track your stock replenishment requests and their status.
                </p>
            </div>
            <div class="flex gap-4">
                <a href="${pageContext.request.contextPath}/staff/create-import"
                    class="px-6 py-3 bg-primary text-on-primary font-label-md text-label-md uppercase hover:opacity-90 transition-opacity rounded-lg flex items-center gap-2">
                    <span class="material-symbols-outlined text-[18px]">add</span>
                    New Request
                </a>
            </div>
        </header>

        <!-- Content -->
        <section class="px-margin-desktop py-6 flex-1">

            <!-- Success Message (New Request) -->
            <c:if test="${param.success eq 'true' or param.msg eq 'success'}">
                <div
                    class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-700 font-body-md text-body-md flex items-center gap-3 rounded-lg">
                    <span class="material-symbols-outlined">check_circle</span>
                    Your import request has been submitted successfully and is now pending admin approval.
                </div>
            </c:if>

            <!-- Success Message (Arrival Report) -->
            <c:if test="${param.msg eq 'report_success'}">
                <div
                    class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-700 font-body-md text-body-md flex items-center gap-3 rounded-lg">
                    <span class="material-symbols-outlined">check_circle</span>
                    Your arrival report has been submitted successfully and is now pending admin approval.
                </div>
            </c:if>

            <!-- Data Table -->
            <div class="border border-outline-variant bg-surface overflow-hidden shadow-sm">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-surface-container-low border-b border-outline-variant">
                        <tr>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                ID</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                Supplier</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                Date</th>
                            <th
                                class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-right">
                                Total Amount</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                Status</th>
                            <th
                                class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-center">
                                Action</th>
                        </tr>
                    </thead>
                    <tbody
                        class="divide-y divide-outline-variant/50 font-body-md text-body-md text-primary">

                        <c:choose>
                            <c:when test="${empty importRequests}">
                                <!-- Empty state -->
                                <tr>
                                    <td colspan="6" class="py-20 text-center">
                                        <div class="flex flex-col items-center gap-3 text-secondary">
                                            <span
                                                class="material-symbols-outlined text-[48px] opacity-30">inventory_2</span>
                                            <p class="font-label-md text-label-md uppercase tracking-wider">
                                                No import requests found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="req" items="${importRequests}">
                                    <tr class="hover:bg-surface-container-low transition-colors group">
                                        <td class="py-4 px-6 font-bold font-label-md tracking-wider">
                                            #<c:out value="${req.importID}" />
                                        </td>
                                        <td class="py-4 px-6 font-body-md text-body-md text-primary">
                                            <c:out value="${req.supplier}" />
                                        </td>
                                        <td class="py-4 px-6 text-secondary">
                                            <fmt:formatDate value="${req.orderDate}" pattern="dd/MM/yyyy" />
                                            <span class="text-[12px] ml-1">
                                                <fmt:formatDate value="${req.orderDate}" pattern="HH:mm" />
                                            </span>
                                        </td>
                                        <td class="py-4 px-6 text-right font-label-md">
                                            <fmt:formatNumber value="${req.totalAmount}" pattern="#,##0" /> đ
                                        </td>
                                        <td class="py-4 px-6">
                                            <c:set var="statusClass" value=""/>
                                            <c:choose>
                                                <c:when test="${req.status == 'REQUESTING'}"><c:set var="statusClass" value="bg-blue-100 text-blue-700"/></c:when>
                                                <c:when test="${req.status == 'APPROVED'}"><c:set var="statusClass" value="bg-yellow-100 text-yellow-700"/></c:when>
                                                <c:when test="${req.status == 'REPORTED'}"><c:set var="statusClass" value="bg-purple-100 text-purple-700"/></c:when>
                                                <c:when test="${req.status == 'ACCEPTED'}"><c:set var="statusClass" value="bg-green-100 text-green-700"/></c:when>
                                                <c:when test="${req.status == 'COMPLETE'}"><c:set var="statusClass" value="bg-gray-900 text-white"/></c:when>
                                                <c:when test="${req.status == 'CANCELLED'}"><c:set var="statusClass" value="bg-red-100 text-red-700"/></c:when>
                                                <c:otherwise><c:set var="statusClass" value="bg-gray-100 text-gray-700"/></c:otherwise>
                                            </c:choose>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider ${statusClass}">
                                                <c:out value="${req.status}"/>
                                            </span>
                                        </td>
                                        <td class="py-4 px-6 text-center">
                                            <a href="${pageContext.request.contextPath}/staff/import-detail?id=${req.importID}"
                                                class="inline-flex items-center px-4 py-1.5 border-[1.5px] border-primary text-primary font-label-sm text-label-sm uppercase tracking-widest hover:bg-primary hover:text-on-primary transition-colors rounded-lg">
                                                Detail
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                    </tbody>
                </table>

                <!-- Pagination Footer -->
                <div
                    class="px-6 py-4 border-t border-outline-variant flex items-center justify-between bg-surface-bright">
                    <span class="font-label-sm text-label-sm text-secondary uppercase tracking-widest">
                        Showing ${rangeStart}-${rangeEnd} of ${totalImportRequests} requests
                    </span>
                    <div class="flex items-center gap-2">
                        <!-- Prev button -->
                        <c:choose>
                            <c:when test="${currentPage <= 1}">
                                <button disabled
                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary disabled:opacity-30 rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/staff/view-request?page=${currentPage - 1}"
                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:text-primary hover:border-primary transition-colors rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <!-- Page numbers -->
                        <c:forEach begin="1" end="${totalPages}" var="p">
                            <c:choose>
                                <c:when test="${p == currentPage}">
                                    <button
                                        class="w-8 h-8 flex items-center justify-center bg-primary text-on-primary font-label-sm text-label-sm rounded-lg">
                                        <c:out value="${p}" />
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/staff/view-request?page=${p}"
                                        class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:bg-surface-container-low font-label-sm text-label-sm rounded-lg transition-colors">
                                        <c:out value="${p}" />
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- Next button -->
                        <c:choose>
                            <c:when test="${currentPage >= totalPages}">
                                <button disabled
                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary disabled:opacity-30 rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/staff/view-request?page=${currentPage + 1}"
                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:text-primary hover:border-primary transition-colors rounded-lg">
                                    <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

            </div>
        </section>
    </main>

</body>

</html>
