<%-- Author: baolgce191178 --%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                <%@ page contentType="text/html" pageEncoding="UTF-8" %>
                    <!DOCTYPE html>
                    <html class="light" lang="en">

                    <head>
                        <meta charset="utf-8" />
                        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                        <title>ADIDIS | Order History</title>
                        <meta name="description"
                            content="View your complete purchase history at ADIDIS. Track order status, total amounts, and order dates." />

                        <link href="https://fonts.googleapis.com" rel="preconnect" />
                        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
                        <link
                            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                            rel="stylesheet" />
                        <link
                            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                            rel="stylesheet" />

                        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                        <script id="tailwind-config">
                            tailwind.config = {
                                darkMode: "class",
                                theme: {
                                    extend: {
                                        colors: {
                                            "surface-container-lowest": "#ffffff",
                                            "primary-fixed": "#e2e2e2",
                                            "on-surface-variant": "#444748",
                                            "on-primary-container": "#848484",
                                            "error-container": "#ffdad6",
                                            "surface-variant": "#e2e2e2",
                                            "surface-container": "#eeeeee",
                                            "tertiary-fixed": "#e2e2e2",
                                            "on-secondary-fixed": "#1a1c1c",
                                            "secondary": "#5d5f5f",
                                            "tertiary-container": "#1b1b1b",
                                            "surface-dim": "#dadada",
                                            "secondary-fixed-dim": "#c6c7c6",
                                            "on-secondary": "#ffffff",
                                            "inverse-on-surface": "#f0f1f1",
                                            "surface": "#f9f9f9",
                                            "on-error-container": "#93000a",
                                            "primary-fixed-dim": "#c6c6c6",
                                            "surface-container-highest": "#e2e2e2",
                                            "on-background": "#1a1c1c",
                                            "inverse-primary": "#c6c6c6",
                                            "on-secondary-fixed-variant": "#454747",
                                            "primary": "#000000",
                                            "on-primary": "#ffffff",
                                            "primary-container": "#1b1b1b",
                                            "on-tertiary-container": "#848484",
                                            "error": "#ba1a1a",
                                            "on-tertiary": "#ffffff",
                                            "on-error": "#ffffff",
                                            "outline": "#7e7576",
                                            "on-surface": "#1a1c1c",
                                            "outline-variant": "#c4c7c7",
                                            "tertiary": "#000000",
                                            "surface-container-low": "#f3f3f4",
                                            "on-tertiary-fixed": "#1b1b1b",
                                            "on-tertiary-fixed-variant": "#474747",
                                            "on-primary-fixed-variant": "#474747",
                                            "on-primary-fixed": "#1b1b1b",
                                            "surface-container-high": "#e8e8e8",
                                            "secondary-container": "#e2e3e2",
                                            "inverse-surface": "#2f3131",
                                            "on-secondary-container": "#636565",
                                            "surface-bright": "#f9f9f9",
                                            "surface-tint": "#5e5e5e",
                                            "background": "#f9f9f9",
                                            "secondary-fixed": "#e2e3e2",
                                            "tertiary-fixed-dim": "#c6c6c6"
                                        },
                                        borderRadius: {
                                            DEFAULT: "0.25rem",
                                            lg: "0.5rem",
                                            xl: "0.75rem",
                                            full: "9999px"
                                        },
                                        spacing: {
                                            "margin-mobile": "20px",
                                            "margin-desktop": "64px",
                                            "margin-tablet": "32px",
                                            gutter: "24px",
                                            base: "8px",
                                            "container-max": "1440px"
                                        },
                                        fontFamily: {
                                            "label-md": ["Inter"],
                                            "display-lg": ["Inter"],
                                            "label-sm": ["Inter"],
                                            "headline-md": ["Inter"],
                                            "body-md": ["Inter"],
                                            "headline-lg": ["Inter"],
                                            "display-lg-mobile": ["Inter"],
                                            "body-lg": ["Inter"]
                                        },
                                        fontSize: {
                                            "label-md": ["14px", { lineHeight: "1.0", letterSpacing: "0.05em", fontWeight: "600" }],
                                            "display-lg": ["72px", { lineHeight: "1.1", letterSpacing: "-0.04em", fontWeight: "800" }],
                                            "label-sm": ["12px", { lineHeight: "1.0", letterSpacing: "0", fontWeight: "500" }],
                                            "headline-md": ["24px", { lineHeight: "1.3", letterSpacing: "-0.01em", fontWeight: "600" }],
                                            "body-md": ["16px", { lineHeight: "1.5", letterSpacing: "0", fontWeight: "400" }],
                                            "headline-lg": ["32px", { lineHeight: "1.2", letterSpacing: "-0.02em", fontWeight: "700" }],
                                            "display-lg-mobile": ["40px", { lineHeight: "1.2", letterSpacing: "-0.02em", fontWeight: "800" }],
                                            "body-lg": ["18px", { lineHeight: "1.6", letterSpacing: "0", fontWeight: "400" }]
                                        }
                                    }
                                }
                            }
                        </script>
                        <style>
                            .material-symbols-outlined {
                                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
                            }

                            .status-pending {
                                background-color: #e2e2e2;
                                color: #1a1c1c;
                            }

                            .status-confirmed {
                                background-color: #1b1b1b;
                                color: #ffffff;
                            }

                            .status-shipping {
                                background-color: #000000;
                                color: #ffffff;
                            }

                            .status-completed {
                                background-color: #d1fae5;
                                color: #065f46;
                            }

                            .status-cancelled {
                                background-color: #ffdad6;
                                color: #93000a;
                            }

                            .row-fade-in {
                                animation: fadeInRow 0.25s ease forwards;
                            }

                            @keyframes fadeInRow {
                                from {
                                    opacity: 0;
                                    transform: translateY(6px);
                                }

                                to {
                                    opacity: 1;
                                    transform: translateY(0);
                                }
                            }
                        </style>
                    </head>

                    <body
                        class="bg-background text-on-background font-body-md text-body-md antialiased flex selection:bg-primary selection:text-on-primary min-h-screen">

                        <aside
                            class="fixed left-0 top-0 h-full w-64 border-r border-outline-variant bg-surface flex flex-col py-base z-40">
                            <div class="px-6 py-8 border-b border-outline-variant/50">
                                <a href="${pageContext.request.contextPath}/home">
                                    <h1
                                        class="font-headline-md text-headline-md font-bold text-primary tracking-tighter uppercase">
                                        ADIDIS</h1>
                                </a>
                                <p class="font-label-sm text-label-sm text-secondary mt-1">My Account</p>
                            </div>

                            <nav class="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
                                <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                    href="${pageContext.request.contextPath}/profile">
                                    <span class="material-symbols-outlined text-[20px]">manage_accounts</span>
                                    Profile
                                </a>
                                <c:choose>
                                    <c:when test="${sessionScope.currentUser.roleName eq 'Admin'}">
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/dashboard">
                                            <span class="material-symbols-outlined text-[20px]">dashboard</span>
                                            Dashboard
                                        </a>
                                    </c:when>
                                    <c:when test="${sessionScope.currentUser.roleName eq 'Staff'}">
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/staff/orders">
                                            <span class="material-symbols-outlined text-[20px]">dashboard</span>
                                            Dashboard
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-label-md text-label-md uppercase bg-primary text-on-primary font-bold active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/profile/orders">
                                            <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                                            Orders
                                        </a>
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-xl font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/profile/addresses">
                                            <span class="material-symbols-outlined text-[20px]">location_on</span>
                                            Addresses
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </nav>

                            <div class="px-4 py-6 border-t border-outline-variant/50 flex flex-col gap-4">

                                <div class="space-y-1">
                                    <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-xl transition-colors"
                                        href="${pageContext.request.contextPath}/home">
                                        <span class="material-symbols-outlined text-[18px]">arrow_back</span>
                                        Back to Shop
                                    </a>
                                    <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-xl transition-colors"
                                        href="${pageContext.request.contextPath}/Logout">
                                        <span class="material-symbols-outlined text-[18px]">logout</span>
                                        Logout
                                    </a>
                                </div>
                            </div>
                        </aside>

                        <main class="ml-64 flex-1 flex flex-col min-h-screen">

                            <header
                                class="px-margin-desktop pt-margin-desktop pb-8 flex justify-between items-end border-b border-outline-variant/30">
                                <div>
                                    <h2 class="font-headline-lg text-headline-lg text-primary tracking-tight">Order
                                        History</h2>
                                    <p class="font-body-md text-body-md text-secondary mt-2 max-w-lg">
                                        View all orders you have placed. Track shipping status and payment history.
                                    </p>
                                </div>
                                <div class="flex gap-4">
                                    <span
                                        class="font-label-sm text-label-sm text-secondary uppercase tracking-widest self-end pb-1">
                                        Total: <strong class="text-primary">${totalOrders}</strong> orders
                                    </span>
                                </div>
                            </header>

                            <section
                                class="px-margin-desktop py-6 flex justify-between items-center bg-surface-bright sticky top-0 z-30 shadow-[0_1px_0_rgba(0,0,0,0.05)]">
                                <form method="get" action="${pageContext.request.contextPath}/profile/orders"
                                    class="flex items-center gap-4 flex-1">
                                    <div class="flex gap-3">
                                        <select id="status-filter" name="status" onchange="this.form.submit()"
                                            class="bg-surface border border-outline-variant text-primary font-label-md text-label-md uppercase py-3 pl-4 pr-10 rounded-xl focus:ring-1 focus:ring-primary focus:border-primary appearance-none cursor-pointer hover:border-outline transition-colors">
                                            <option value="" ${empty statusFilter ? 'selected' : '' }>All Statuses
                                            </option>
                                            <option value="pending" ${statusFilter=='pending' ? 'selected' : '' }>
                                                Pending</option>
                                            <option value="confirmed" ${statusFilter=='confirmed' ? 'selected' : '' }>
                                                Confirmed</option>
                                            <option value="shipping" ${statusFilter=='shipping' ? 'selected' : '' }>
                                                Shipping</option>
                                            <option value="completed" ${statusFilter=='completed' ? 'selected' : '' }>
                                                Completed</option>
                                            <option value="cancelled" ${statusFilter=='cancelled' ? 'selected' : '' }>
                                                Cancelled</option>
                                        </select>
                                    </div>
                                </form>

                                <div class="font-label-sm text-label-sm text-secondary uppercase tracking-widest">
                                    <c:choose>
                                        <c:when test="${totalOrders > 0}">
                                            Showing ${startEntry}–${endEntry} of ${totalOrders} orders
                                        </c:when>
                                        <c:otherwise>No orders found</c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                            <section class="px-margin-desktop py-6 flex-1">
                                <div class="border border-outline-variant bg-surface overflow-hidden shadow-sm rounded-2xl">
                                    <table class="w-full text-left border-collapse">
                                        <thead class="bg-surface-container-low border-b border-outline-variant">
                                            <tr>
                                                <th
                                                    class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                                    Order ID</th>
                                                <th
                                                    class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                                    Order Date</th>
                                                <th
                                                    class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-right">
                                                    Total Amount</th>
                                                <th
                                                    class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">
                                                    Status</th>
                                                <th
                                                    class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-right">
                                                    Action</th>
                                            </tr>
                                        </thead>
                                        <tbody
                                            class="divide-y divide-outline-variant/50 font-body-md text-body-md text-primary">
                                            <c:choose>
                                                <c:when test="${empty orders}">
                                                    <tr>
                                                        <td colspan="5" class="py-20 px-6 text-center text-secondary">
                                                            <div class="flex flex-col items-center gap-4">
                                                                <span
                                                                    class="material-symbols-outlined text-[64px] text-outline-variant">receipt_long</span>
                                                                <p
                                                                    class="font-label-md text-label-md uppercase tracking-wider">
                                                                    You have no orders yet</p>
                                                                <a href="${pageContext.request.contextPath}/home"
                                                                    class="mt-2 px-8 py-3 bg-primary text-on-primary font-label-md text-label-md uppercase rounded-full hover:opacity-90 transition-opacity">
                                                                    Shop Now
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:forEach var="order" items="${orders}" varStatus="loop">
                                                        <tr class="hover:bg-surface-container-low transition-colors group row-fade-in"
                                                            style="animation-delay: ${loop.index * 40}ms">
                                                            <td
                                                                class="py-4 px-6 font-bold font-label-md tracking-wider">
                                                                SL-${fn:toUpperCase(fn:substring(order.id, 0, 8))}
                                                            </td>
                                                            <td class="py-4 px-6 text-secondary">
                                                                <fmt:formatDate value="${order.createdAt}"
                                                                    pattern="dd/MM/yyyy" />
                                                                <span class="text-[12px] ml-1">
                                                                    <fmt:formatDate value="${order.createdAt}"
                                                                        pattern="HH:mm" />
                                                                </span>
                                                            </td>
                                                            <td class="py-4 px-6 text-right font-label-md">
                                                                <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0" /> đ
                                                            </td>
                                                            <td class="py-4 px-6">
                                                                <span
                                                                    class="inline-flex items-center px-2 py-1 font-label-sm text-label-sm uppercase tracking-widest rounded-xl status-${order.status}">
                                                                    <c:choose>
                                                                        <c:when test="${order.status == 'pending'}">
                                                                            Pending</c:when>
                                                                        <c:when test="${order.status == 'confirmed'}">
                                                                            Confirmed</c:when>
                                                                        <c:when test="${order.status == 'shipping'}">
                                                                            Shipping</c:when>
                                                                        <c:when test="${order.status == 'completed'}">
                                                                            Completed</c:when>
                                                                        <c:when test="${order.status == 'cancelled'}">
                                                                            Cancelled</c:when>
                                                                        <c:otherwise>${order.status}</c:otherwise>
                                                                    </c:choose>
                                                                </span>
                                                            </td>
                                                            <td class="py-4 px-6 text-right">
                                                                <a href="${pageContext.request.contextPath}/profile/order/details?id=${order.id}"
                                                                    class="inline-block px-4 py-2 border border-outline-variant text-secondary hover:bg-surface-container-low transition-colors font-label-sm text-label-sm uppercase tracking-widest rounded-full">
                                                                    Details
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:otherwise>
                                            </c:choose>
                                        </tbody>
                                    </table>

                                    <c:if test="${totalOrders > 0}">
                                        <div
                                            class="px-6 py-4 border-t border-outline-variant flex items-center justify-between bg-surface-bright">
                                            <span
                                                class="font-label-sm text-label-sm text-secondary uppercase tracking-widest">
                                                Showing ${startEntry}–${endEntry} of ${totalOrders} orders
                                            </span>
                                            <div class="flex items-center gap-2">
                                                <a href="?status=${statusFilter}&page=${currentPage - 1}"
                                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:text-primary hover:border-primary transition-colors rounded-xl ${currentPage <= 1 ? 'opacity-30 pointer-events-none' : ''}">
                                                    <span
                                                        class="material-symbols-outlined text-[18px]">chevron_left</span>
                                                </a>

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
                                                            <span
                                                                class="w-8 h-8 flex items-center justify-center bg-primary text-on-primary font-label-sm text-label-sm rounded-xl">${p}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="?status=${statusFilter}&page=${p}"
                                                                class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:bg-surface-container-low font-label-sm text-label-sm rounded-xl transition-colors">${p}</a>
                                                        </c:otherwise>
                                                    </c:choose>
    <c:if test="${startPage > 2}">
        <span class="px-2">...</span>
    </c:if>
</c:if>

<c:forEach begin="${startPage}" end="${endPage}" var="p">
    <c:choose>
                                                        <c:when test="${p == currentPage}">
                                                            <span
                                                                class="w-8 h-8 flex items-center justify-center bg-primary text-on-primary font-label-sm text-label-sm rounded-xl">${p}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="?status=${statusFilter}&page=${p}"
                                                                class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:bg-surface-container-low font-label-sm text-label-sm rounded-xl transition-colors">${p}</a>
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
                                                            <span
                                                                class="w-8 h-8 flex items-center justify-center bg-primary text-on-primary font-label-sm text-label-sm rounded-xl">${p}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="?status=${statusFilter}&page=${p}"
                                                                class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:bg-surface-container-low font-label-sm text-label-sm rounded-xl transition-colors">${p}</a>
                                                        </c:otherwise>
                                                    </c:choose>
</c:if>

                                                <a href="?status=${statusFilter}&page=${currentPage + 1}"
                                                    class="w-8 h-8 flex items-center justify-center border border-outline-variant text-secondary hover:text-primary hover:border-primary transition-colors rounded-xl ${currentPage >= totalPages ? 'opacity-30 pointer-events-none' : ''}">
                                                    <span
                                                        class="material-symbols-outlined text-[18px]">chevron_right</span>
                                                </a>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </section>
                        </main>

                    </body>

                    </html>

