<%-- Author: baolgce191178 --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>SOLE_LAB - Order Management</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
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
<body class="bg-background text-on-background font-body-md text-body-md antialiased flex selection:bg-primary selection:text-on-primary min-h-screen">

<!-- ===================== SideNavBar ===================== -->
<aside class="fixed left-0 top-0 h-full w-64 border-r border-outline-variant bg-surface flex flex-col py-base z-40">
    <!-- Header / Brand -->
    <div class="px-6 py-8 border-b border-outline-variant/50">
        <h1 class="font-headline-md text-headline-md font-bold text-primary tracking-tighter uppercase">SOLE_LAB</h1>
        <p class="font-label-sm text-label-sm text-secondary mt-1">Staff Portal</p>
    </div>

    <!-- Main Navigation -->
    <nav class="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
        <!-- Dashboard -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
           href="${pageContext.request.contextPath}/home">
            <span class="material-symbols-outlined text-[20px]">dashboard</span>
            Dashboard
        </a>
        <!-- Orders (Active) -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase bg-primary text-on-primary font-bold active:scale-95 transition-transform"
           href="${pageContext.request.contextPath}/staff/orders">
            <span class="material-symbols-outlined text-[20px]">shopping_cart</span>
            Orders
        </a>
        <!-- Inventory -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
           href="#">
            <span class="material-symbols-outlined text-[20px]">inventory_2</span>
            Inventory
        </a>
        <!-- Customers -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
           href="#">
            <span class="material-symbols-outlined text-[20px]">group</span>
            Customers
        </a>
        <!-- Settings -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
           href="#">
            <span class="material-symbols-outlined text-[20px]">settings</span>
            Settings
        </a>
    </nav>

    <!-- CTA & Footer -->
    <div class="px-4 py-6 border-t border-outline-variant/50 flex flex-col gap-4">
        <div class="space-y-1 mt-2">
            <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-lg transition-colors" href="#">
                <span class="material-symbols-outlined text-[18px]">help</span>
                Help
            </a>
            <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-lg transition-colors"
               href="${pageContext.request.contextPath}/login">
                <span class="material-symbols-outlined text-[18px]">logout</span>
                Logout
            </a>
        </div>
        <!-- User Profile Snippet -->
        <div class="flex items-center gap-3 px-2 mt-4">
            <div class="w-10 h-10 rounded-full bg-surface-container-high overflow-hidden border border-outline-variant flex items-center justify-center">
                <span class="material-symbols-outlined text-secondary text-[24px]">account_circle</span>
            </div>
            <div class="flex flex-col">
                <span class="font-label-md text-label-md text-primary">
                    <c:out value="${sessionScope.currentUser.fullName}" default="Staff"/>
                </span>
                <span class="font-label-sm text-label-sm text-secondary capitalize">
                    <c:out value="${sessionScope.currentUser.roleName}" default="staff"/>
                </span>
            </div>
        </div>
    </div>
</aside>

<!-- ===================== Main Content ===================== -->
<main class="ml-64 flex-1 flex flex-col min-h-screen">

    <!-- Header Section -->
    <header class="px-margin-desktop pt-margin-desktop pb-8 flex justify-between items-end border-b border-outline-variant/30">
        <div>
            <h2 class="font-headline-lg text-headline-lg text-primary tracking-tight">Order Management</h2>
            <p class="font-body-md text-body-md text-secondary mt-2 max-w-lg">
                Track all system orders. Filter by status, search by customer name, and process orders quickly.
            </p>
        </div>
        <div class="flex gap-4">
            <button class="px-6 py-3 border-[1.5px] border-primary font-label-md text-label-md uppercase text-primary hover:bg-primary hover:text-on-primary transition-colors rounded-lg flex items-center gap-2">
                <span class="material-symbols-outlined text-[18px]">download</span>
                Export CSV
            </button>
        </div>
    </header>

    <!-- Control Bar: Filters & Search (GET form) -->
    <section class="px-margin-desktop py-6 flex justify-between items-center bg-surface-bright sticky top-0 z-30 shadow-[0_1px_0_rgba(0,0,0,0.05)]">
        <form method="get" action="${pageContext.request.contextPath}/staff/orders"
              class="flex items-center gap-4 flex-1">
            <!-- Search Input -->
            <div class="relative w-full max-w-md">
                <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-secondary pointer-events-none">search</span>
                <input id="keyword-input"
                       class="w-full bg-surface-container text-primary font-body-md text-body-md pl-12 pr-4 py-3 rounded-full border-none focus:ring-2 focus:ring-primary focus:outline-none transition-shadow placeholder:text-secondary"
                       type="text"
                       name="keyword"
                       placeholder="Search by customer name, email..."
                       value="<c:out value='${keyword}'/>">
            </div>
            <!-- Status Filter -->
            <div class="flex gap-3">
                <select id="status-select"
                        name="status"
                        onchange="this.form.submit()"
                        class="bg-surface border border-outline-variant text-primary font-label-md text-label-md uppercase py-3 pl-4 pr-10 rounded-lg focus:ring-1 focus:ring-primary focus:border-primary appearance-none cursor-pointer hover:border-outline transition-colors">
                    <option value="" <c:if test="${empty statusFilter}">selected</c:if>>All Statuses</option>
                    <option value="pending"   <c:if test="${statusFilter == 'pending'}">selected</c:if>>Pending</option>
                    <option value="confirmed" <c:if test="${statusFilter == 'confirmed'}">selected</c:if>>Confirmed</option>
                    <option value="shipping"  <c:if test="${statusFilter == 'shipping'}">selected</c:if>>Shipping</option>
                    <option value="completed" <c:if test="${statusFilter == 'completed'}">selected</c:if>>Completed</option>
                    <option value="cancelled" <c:if test="${statusFilter == 'cancelled'}">selected</c:if>>Cancelled</option>
                </select>
            </div>
            <!-- Submit button (hidden, triggered by enter or select change) -->
            <button type="submit"
                    class="px-5 py-3 bg-primary text-on-primary font-label-md text-label-md uppercase rounded-lg hover:opacity-90 transition-opacity">
                Search
            </button>
        </form>

        <!-- Selected count (Bulk Actions placeholder) -->
        <div class="flex items-center gap-3 pl-6 border-l border-outline-variant/50 ml-6 opacity-50 pointer-events-none transition-opacity" id="bulk-actions">
            <span class="font-label-sm text-label-sm text-secondary uppercase">0 Selected</span>
            <button class="px-4 py-2 bg-surface-container text-primary font-label-md text-label-md uppercase rounded-lg border border-outline-variant hover:bg-surface-container-high transition-colors">
                Confirm
            </button>
        </div>
    </section>

    <!-- Data Table -->
    <section class="px-margin-desktop py-6 flex-1">
        <div class="border border-outline-variant bg-surface overflow-hidden shadow-sm">
            <table class="w-full text-left border-collapse">
                <thead class="bg-surface-container-low border-b border-outline-variant">
                    <tr>
                        <th class="py-4 px-6 w-12">
                            <input id="select-all-checkbox" class="rounded-[2px] border-outline-variant text-primary focus:ring-primary cursor-pointer w-4 h-4" type="checkbox">
                        </th>
                        <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Order ID</th>
                        <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Customer</th>
                        <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Order Date</th>
                        <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-right">Total Amount</th>
                        <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Status</th>
                        <th class="py-4 px-6 w-12"></th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-outline-variant/50 font-body-md text-body-md text-primary">

                    <c:choose>
                        <c:when test="${empty orders}">
                            <!-- Empty state -->
                            <tr>
                                <td colspan="7" class="py-20 text-center">
                                    <div class="flex flex-col items-center gap-3 text-secondary">
                                        <span class="material-symbols-outlined text-[48px] opacity-30">inbox</span>
                                        <p class="font-label-md text-label-md uppercase tracking-wider">No orders found</p>
                                        <c:if test="${not empty statusFilter or not empty keyword}">
                                            <a href="${pageContext.request.contextPath}/staff/orders"
                                               class="text-primary underline font-label-sm text-label-sm uppercase">Clear filters</a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <c:set var="rowOpacity" value="${order.status == 'cancelled' ? 'opacity-60' : ''}"/>

                                <tr class="hover:bg-surface-container-low transition-colors group">
                                    <td class="py-4 px-6">
                                        <input class="rounded-[2px] border-outline-variant text-primary focus:ring-primary cursor-pointer w-4 h-4 row-checkbox" type="checkbox">
                                    </td>
                                    <td class="py-4 px-6 font-bold font-label-md tracking-wider ${rowOpacity}">
                                        #<c:out value="${order.id.length() > 8 ? order.id.substring(order.id.length() - 8).toUpperCase() : order.id}"/>
                                    </td>
                                    <td class="py-4 px-6 ${rowOpacity}">
                                        <div class="flex flex-col">
                                            <span class="font-label-md text-label-md text-primary">
                                                <c:out value="${not empty order.customerFullName ? order.customerFullName : 'N/A'}"/>
                                            </span>
                                            <span class="font-label-sm text-label-sm text-secondary">
                                                <c:out value="${order.customerEmail}"/>
                                            </span>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6 text-secondary ${rowOpacity}">
                                        <fmt:formatDate value="${order.createdAt}" pattern="dd/MM/yyyy"/>
                                        <span class="text-[12px] ml-1">
                                            <fmt:formatDate value="${order.createdAt}" pattern="HH:mm"/>
                                        </span>
                                    </td>
                                    <td class="py-4 px-6 text-right font-label-md ${rowOpacity}">
                                        <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </td>
                                    <td class="py-4 px-6">
                                        <c:choose>
                                            <c:when test="${order.status == 'pending'}">
                                                <span class="inline-flex items-center px-2 py-1 bg-surface-variant text-on-surface font-label-sm text-label-sm uppercase tracking-widest rounded-md">
                                                    Pending
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'confirmed'}">
                                                <span class="inline-flex items-center px-2 py-1 border border-primary text-primary font-label-sm text-label-sm uppercase tracking-widest rounded-md">
                                                    Confirmed
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'shipping'}">
                                                <span class="inline-flex items-center px-2 py-1 bg-tertiary-fixed text-on-tertiary-fixed-variant font-label-sm text-label-sm uppercase tracking-widest rounded-md border border-tertiary-fixed-dim">
                                                    Shipping
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'completed'}">
                                                <span class="inline-flex items-center px-2 py-1 bg-primary text-on-primary font-label-sm text-label-sm uppercase tracking-widest rounded-md">
                                                    Completed
                                                </span>
                                            </c:when>
                                            <c:when test="${order.status == 'cancelled'}">
                                                <span class="inline-flex items-center px-2 py-1 bg-error-container text-on-error-container font-label-sm text-label-sm uppercase tracking-widest rounded-md">
                                                    Cancelled
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center px-2 py-1 bg-surface-container text-secondary font-label-sm text-label-sm uppercase tracking-widest rounded-md">
                                                    <c:out value="${order.status}"/>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="py-4 px-6 text-right">
                                        <a href="${pageContext.request.contextPath}/staff/order/details?id=${order.id}" class="text-secondary hover:text-primary transition-colors opacity-0 group-hover:opacity-100"
                                                title="View order details">
                                            <span class="material-symbols-outlined">more_vert</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>

                </tbody>
            </table>

            <!-- Pagination Footer -->
            <div class="px-6 py-4 border-t border-outline-variant flex items-center justify-between bg-surface-bright">
                <span class="font-label-sm text-label-sm text-secondary uppercase tracking-widest">
                    Showing ${rangeStart}–${rangeEnd} of ${totalOrders} orders
                </span>
                <div class="flex items-center gap-2">
                    <!-- Prev button -->
                    <c:choose>
                        <c:when test="${currentPage <= 1}">
                            <button disabled class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary disabled:opacity-30 rounded-lg">
                                <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/staff/orders?page=${currentPage - 1}&status=${statusFilter}&keyword=${keyword}"
                               class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:text-primary hover:border-primary transition-colors rounded-lg">
                                <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <!-- Page numbers -->
                    <c:forEach begin="1" end="${totalPages}" var="p">
                        <c:choose>
                            <c:when test="${p == currentPage}">
                                <button class="w-8 h-8 flex items-center justify-center bg-primary text-on-primary font-label-sm text-label-sm rounded-lg">
                                    <c:out value="${p}"/>
                                </button>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/staff/orders?page=${p}&status=${statusFilter}&keyword=${keyword}"
                                   class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:bg-surface-container-low font-label-sm text-label-sm rounded-lg transition-colors">
                                    <c:out value="${p}"/>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <!-- Next button -->
                    <c:choose>
                        <c:when test="${currentPage >= totalPages}">
                            <button disabled class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary disabled:opacity-30 rounded-lg">
                                <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/staff/orders?page=${currentPage + 1}&status=${statusFilter}&keyword=${keyword}"
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

<!-- JS: Checkbox bulk-actions toggle -->
<script>
    document.addEventListener('DOMContentLoaded', () => {
        const selectAll    = document.getElementById('select-all-checkbox');
        const checkboxes   = document.querySelectorAll('.row-checkbox');
        const bulkActionsBar = document.getElementById('bulk-actions');

        function updateBulkBar() {
            const checked = Array.from(checkboxes).filter(c => c.checked);
            if (checked.length > 0) {
                bulkActionsBar.classList.remove('opacity-50', 'pointer-events-none');
                bulkActionsBar.querySelector('span').textContent = checked.length + ' SELECTED';
            } else {
                bulkActionsBar.classList.add('opacity-50', 'pointer-events-none');
                bulkActionsBar.querySelector('span').textContent = '0 Selected';
            }
        }

        if (selectAll) {
            selectAll.addEventListener('change', () => {
                checkboxes.forEach(cb => { cb.checked = selectAll.checked; });
                updateBulkBar();
            });
        }

        checkboxes.forEach(cb => {
            cb.addEventListener('change', () => {
                updateBulkBar();
                if (selectAll) {
                    selectAll.checked = Array.from(checkboxes).every(c => c.checked);
                }
            });
        });
    });
</script>
</body>
</html>
