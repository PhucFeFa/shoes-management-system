<%-- Author: baolgce191178 --%>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
                    <!DOCTYPE html>
                    <html class="light" lang="en">

                    <head>
                        <meta charset="utf-8">
                        <meta content="width=device-width, initial-scale=1.0" name="viewport">
                        <title>Adidis ADMIN - Order Details</title>
                        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
                        <link
                            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
                            rel="stylesheet">
                        <!-- Bootstrap Icons -->
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                        <link
                            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
                            rel="stylesheet">
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
                                            "container-max": "1440px",
                                            "margin-mobile": "20px",
                                            "gutter": "24px",
                                            "margin-tablet": "32px",
                                            "margin-desktop": "64px",
                                            "base": "8px"
                                        },
                                        fontFamily: {
                                            "body-md": ["Inter"],
                                            "label-sm": ["Inter"],
                                            "display-lg": ["Inter"],
                                            "body-lg": ["Inter"],
                                            "headline-lg": ["Inter"],
                                            "display-lg-mobile": ["Inter"],
                                            "label-md": ["Inter"],
                                            "headline-md": ["Inter"]
                                        },
                                        fontSize: {
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
                        class="bg-background text-on-surface font-body-md text-body-md antialiased overflow-hidden flex h-screen">
                        <!-- SideNavBar (Shared Component) -->
                        <c:set var="activePage" value="orders" scope="request" />
                        <jsp:include page="/views/staff/sidebar.jsp" />

                        <!-- Main Content Canvas -->
                        <main class="ml-64 flex-1 h-full overflow-y-auto bg-background">
                            <div class="max-w-container-max mx-auto px-margin-desktop py-margin-desktop">

                                <c:if test="${not empty sessionScope.successMessage}">
                                    <div
                                        class="bg-d1fae5 text-065f46 p-4 mb-6 border border-065f46 flex justify-between">
                                        <span>${sessionScope.successMessage}</span>
                                    </div>
                                    <c:remove var="successMessage" scope="session" />
                                </c:if>
                                <c:if test="${not empty sessionScope.errorMessage}">
                                    <div
                                        class="bg-error-container text-error p-4 mb-6 border border-error flex justify-between">
                                        <span>${sessionScope.errorMessage}</span>
                                    </div>
                                    <c:remove var="errorMessage" scope="session" />
                                </c:if>

                                <!-- Page Header & Action Bar -->
                                <div
                                    class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12 border-b border-outline-variant pb-6">
                                    <div>
                                        <div class="flex items-center gap-4">
                                            <h2
                                                class="font-headline-lg text-headline-lg text-primary uppercase tracking-tighter">
                                                ORDER #SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}</h2>
                                            <span
                                                class="px-3 py-1 font-label-sm text-label-sm uppercase tracking-widest border status-${orderSummary.status}">${orderSummary.status}</span>
                                        </div>
                                        <p class="font-body-md text-body-md text-secondary mt-2">Placed on
                                            <fmt:formatDate value="${orderSummary.createdAt}"
                                                            pattern="dd MMM yyyy, HH:mm" timeZone="Asia/Ho_Chi_Minh"/>
                                        </p>
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <c:if test="${orderSummary.status != 'cancelled'}">
                                            <c:if
                                                test="${orderSummary.status == 'pending' || orderSummary.status == 'confirmed' || orderSummary.status == 'shipping'}">
                                                <button type="button"
                                                    onclick="document.getElementById('cancel-modal').classList.remove('hidden')"
                                                    class="w-[180px] border-[1.5px] border-primary text-primary bg-transparent hover:bg-primary hover:text-on-primary transition-colors font-label-md text-label-md uppercase px-6 h-[46px] flex items-center justify-center gap-2 rounded-2xl">
                                                    <span>Cancel Order</span>
                                                </button>
                                            </c:if>

                                            <c:choose>
                                                <c:when
                                                    test="${orderSummary.status == 'completed' || orderSummary.status == 'delivered'}">
                                                    <span
                                                        class="px-6 py-3 font-label-md text-label-md uppercase text-065f46 bg-d1fae5 border border-065f46 cursor-not-allowed rounded-2xl">
                                                        Order Completed
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form id="update-status-form"
                                                        action="${pageContext.request.contextPath}/staff/order/update-status"
                                                        method="POST" class="flex items-center gap-2">
                                                        <input type="hidden" name="orderId" value="${orderSummary.id}">
                                                        
                                                        <c:choose>
                                                            <c:when test="${orderSummary.status == 'pending'}">
                                                                <input type="hidden" name="status" value="confirmed">
                                                                <button type="submit"
                                                                    class="w-[180px] border-[1.5px] border-primary text-on-primary bg-primary hover:bg-opacity-90 transition-colors font-label-md text-label-md uppercase px-6 h-[46px] flex items-center justify-center gap-2 rounded-2xl">
                                                                    <span>Confirm Order</span>
                                                                    <span class="material-symbols-outlined text-[18px]">arrow_forward</span>
                                                                </button>
                                                            </c:when>
                                                            <c:when test="${orderSummary.status == 'confirmed'}">
                                                                <input type="hidden" name="status" value="shipping">
                                                                <button type="submit"
                                                                    class="w-[180px] border-[1.5px] border-primary text-on-primary bg-primary hover:bg-opacity-90 transition-colors font-label-md text-label-md uppercase px-6 h-[46px] flex items-center justify-center gap-2 rounded-2xl">
                                                                    <span>Ship Order</span>
                                                                    <span class="material-symbols-outlined text-[18px]">local_shipping</span>
                                                                </button>
                                                            </c:when>
                                                            <c:when test="${orderSummary.status == 'shipping'}">
                                                                <input type="hidden" name="status" value="completed">
                                                                <button type="button"
                                                                    onclick="document.getElementById('complete-modal').classList.remove('hidden')"
                                                                    class="w-[180px] border-[1.5px] border-emerald-600 text-white bg-emerald-600 hover:bg-emerald-700 transition-colors font-label-md text-label-md uppercase px-6 h-[46px] flex items-center justify-center gap-2 rounded-2xl">
                                                                    <span>Complete Order</span>
                                                                    <span class="material-symbols-outlined text-[18px]">check_circle</span>
                                                                </button>
                                                            </c:when>
                                                        </c:choose>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                </div>

                                <!-- Bento Grid Layout -->
                                <div class="grid grid-cols-1 lg:grid-cols-12 gap-gutter">
                                    <!-- Left Column: Items & Timeline (Spans 8 cols) -->
                                    <div class="lg:col-span-8 flex flex-col gap-gutter">
                                        <!-- Items Card -->
                                        <div
                                            class="bg-surface-container-lowest border border-outline-variant p-8 rounded-2xl">
                                            <h3
                                                class="font-label-md text-label-md uppercase text-primary border-b border-outline-variant pb-4 mb-6 tracking-widest">
                                                Line Items</h3>
                                            <div class="flex flex-col gap-6">
                                                <c:forEach var="item" items="${orderItems}">
                                                    <!-- Item -->
                                                    <div
                                                        class="flex gap-6 items-center pb-6 border-b border-surface-container-high last:border-0 last:pb-0">
                                                        <div
                                                            class="w-32 h-32 bg-surface-container flex-shrink-0 border border-outline-variant p-2">
                                                            <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" alt="${item.productName}"
                                                                class="w-full h-full object-cover mix-blend-multiply filter grayscale contrast-125"
                                                                src="<c:choose><c:when test='${not empty item.imageUrl}'>${item.imageUrl}</c:when><c:otherwise>https://via.placeholder.com/300</c:otherwise></c:choose>">
                                                        </div>
                                                        <div class="flex-1">
                                                            <h4
                                                                class="font-headline-md text-[18px] text-primary uppercase font-bold tracking-tight">
                                                                ${item.productName}</h4>
                                                            <p class="font-body-md text-body-md text-secondary mt-1">
                                                                SERIES: ${item.categoryName}</p>
                                                            <div class="flex items-center gap-4 mt-3">
                                                                <span
                                                                    class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Size
                                                                    ${item.size}</span>
                                                                <span
                                                                    class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Color:
                                                                    ${item.color}</span>
                                                                <span
                                                                    class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Qty:
                                                                    ${item.quantity}</span>
                                                            </div>
                                                        </div>
                                                        <div class="text-right">
                                                            <p class="font-label-md text-[18px] text-primary font-bold">
                                                                <fmt:formatNumber value="${item.priceAtPurchase}"
                                                                    pattern="#,##0" /> đ
                                                            </p>
                                                            <p class="font-label-sm text-secondary mt-1">Total:
                                                                <fmt:formatNumber value="${item.totalPrice}"
                                                                    pattern="#,##0" /> đ
                                                            </p>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </div>

                                    <!-- Right Column: Info Cards (Spans 4 cols) -->
                                    <div class="lg:col-span-4 flex flex-col gap-gutter">
                                        <!-- Customer Card -->
                                        <div
                                            class="bg-surface-container-lowest border border-outline-variant p-6 rounded-2xl">
                                            <div
                                                class="flex items-center justify-between mb-4 border-b border-outline-variant pb-4">
                                                <h3
                                                    class="font-label-md text-label-md uppercase tracking-widest text-primary">
                                                    Customer</h3>
                                            </div>
                                            <div class="space-y-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="w-10 h-10 bg-surface-container flex items-center justify-center border border-outline-variant">
                                                        <span
                                                            class="material-symbols-outlined text-secondary">person</span>
                                                    </div>
                                                    <div>
                                                        <p
                                                            class="font-label-md text-label-md text-primary uppercase font-bold">
                                                            ${orderSummary.customerFullName}</p>
                                                        <p class="font-body-md text-body-md text-secondary mt-0.5">
                                                            ${orderSummary.customerEmail}</p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Logistics Card -->
                                        <div
                                            class="bg-surface-container-lowest border border-outline-variant p-6 rounded-2xl">
                                            <h3
                                                class="font-label-md text-label-md uppercase tracking-widest text-primary border-b border-outline-variant pb-4 mb-4">
                                                Logistics</h3>
                                            <div class="space-y-6">
                                                <div>
                                                    <div class="flex items-center gap-2 mb-2">
                                                        <span
                                                            class="material-symbols-outlined text-[18px] text-secondary">local_shipping</span>
                                                        <h4
                                                            class="font-label-sm text-label-sm text-secondary uppercase">
                                                            Shipping Address</h4>
                                                    </div>
                                                    <p class="font-body-md text-body-md text-primary leading-relaxed">
                                                        <c:choose>
                                                            <c:when test="${not empty orderSummary.addressLine}">
                                                                ${orderSummary.customerFullName}<br>
                                                                ${orderSummary.addressLine}<br>
                                                                ${orderSummary.ward}, ${orderSummary.district}<br>
                                                                ${orderSummary.city}
                                                            </c:when>
                                                            <c:otherwise>No address provided.</c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Financials Card -->
                                        <div
                                            class="bg-surface-container-lowest border border-outline-variant p-6 rounded-2xl bg-surface-bright">
                                            <h3
                                                class="font-label-md text-label-md uppercase tracking-widest text-primary border-b border-outline-variant pb-4 mb-4">
                                                Financials</h3>
                                            <div class="space-y-3 font-body-md text-body-md">
                                                <div class="flex justify-between items-center text-secondary">
                                                    <span>Payment Method</span>
                                                    <span class="uppercase">${empty orderSummary.paymentMethod ? 'N/A' :
                                                        orderSummary.paymentMethod}</span>
                                                </div>
                                                <div class="flex justify-between items-center text-secondary">
                                                    <span>Payment Status</span>
                                                    <span class="uppercase">${empty orderSummary.paymentStatus ? 'N/A' :
                                                        orderSummary.paymentStatus}</span>
                                                </div>
                                                <div class="flex justify-between items-center text-secondary pt-2">
                                                    <span>Subtotal</span>
                                                    <span>
                                                        <fmt:formatNumber value="${orderSummary.totalAmount}"
                                                            pattern="#,##0" /> đ
                                                    </span>
                                                </div>
                                                <div
                                                    class="flex justify-between items-center text-primary font-bold pt-4 border-t border-outline-variant mt-2">
                                                    <span class="font-label-md uppercase tracking-widest">Total
                                                        Amount</span>
                                                    <span class="text-xl tracking-tight">
                                                        <fmt:formatNumber value="${orderSummary.totalAmount}"
                                                            pattern="#,##0" /> đ
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Cancel Order Modal -->
                            <div id="cancel-modal"
                                class="fixed inset-0 z-[9999] hidden bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 transition-all">
                                <div
                                    class="bg-white w-full max-w-lg shadow-2xl rounded-2xl overflow-hidden border border-gray-100 transform transition-all">
                                    <!-- Header -->
                                    <div
                                        class="flex justify-between items-center px-6 py-5 border-b border-gray-100 bg-red-50/60">
                                        <h3
                                            class="font-bold text-lg text-red-900 tracking-tight">
                                            <span>CANCEL ORDER #SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}</span>
                                        </h3>
                                        <button type="button"
                                            onclick="document.getElementById('cancel-modal').classList.add('hidden')"
                                            class="text-gray-400 hover:text-gray-700 hover:bg-red-100/50 p-1.5 rounded-full transition-all flex items-center justify-center">
                                            <i class="bi bi-x-lg text-lg"></i>
                                        </button>
                                    </div>

                                    <!-- Body -->
                                    <form action="${pageContext.request.contextPath}/staff/order/update-status"
                                        method="POST" class="p-6">
                                        <input type="hidden" name="orderId" value="${orderSummary.id}">
                                        <input type="hidden" name="status" value="cancelled">

                                        <p class="text-gray-600 text-sm leading-relaxed mb-6">
                                            Are you sure you want to cancel this order upon customer request?
                                            This action will halt fulfillment and notify the customer.
                                        </p>

                                        <div class="mb-6 p-4 rounded-xl bg-red-50 border border-red-200/80 text-red-900 text-xs flex items-start gap-3">
                                            <i class="bi bi-exclamation-triangle-fill text-red-600 text-lg flex-shrink-0 mt-0.5"></i>
                                            <div>
                                                <strong class="font-bold uppercase tracking-wider text-[11px] text-red-800 block mb-0.5">Warning</strong>
                                                <span>This action cannot be undone once confirmed.</span>
                                            </div>
                                        </div>

                                        <div class="mb-6">
                                            <label
                                                class="block text-xs font-bold uppercase tracking-wider text-gray-700 mb-2">
                                                Reason for Cancellation
                                            </label>
                                            <textarea name="reason" rows="3"
                                                class="w-full border border-gray-200 rounded-xl bg-gray-50/50 p-3 text-sm text-gray-900 focus:bg-white focus:border-red-500 focus:ring-2 focus:ring-red-500/20 outline-none transition-all resize-none"
                                                placeholder="Enter staff notes regarding the cancellation request..."></textarea>
                                        </div>

                                        <!-- Footer Buttons -->
                                        <div class="flex items-center gap-3 pt-2">
                                            <button type="submit"
                                                class="flex-1 bg-red-600 hover:bg-red-700 active:bg-red-800 text-white font-semibold text-sm py-3 px-5 rounded-xl shadow-sm transition-all flex items-center justify-center">
                                                <span>Yes, Cancel Order</span>
                                            </button>
                                            <button type="button"
                                                onclick="document.getElementById('cancel-modal').classList.add('hidden')"
                                                class="flex-1 bg-gray-100 hover:bg-gray-200 active:bg-gray-300 text-gray-700 font-semibold text-sm py-3 px-5 rounded-xl transition-all">
                                                Go Back
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- Complete Order Modal -->
                            <div id="complete-modal"
                                class="fixed inset-0 z-[9999] hidden bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-4 transition-all">
                                <div
                                    class="bg-white w-full max-w-lg shadow-2xl rounded-2xl overflow-hidden border border-gray-100 transform transition-all">
                                    <!-- Header -->
                                    <div
                                        class="flex justify-between items-center px-6 py-5 border-b border-gray-100 bg-emerald-50/60">
                                        <h3
                                            class="font-bold text-lg text-emerald-900 tracking-tight">
                                            CONFIRM COMPLETION
                                        </h3>
                                        <button type="button"
                                            onclick="document.getElementById('complete-modal').classList.add('hidden')"
                                            class="text-gray-400 hover:text-gray-700 hover:bg-emerald-100/50 p-1.5 rounded-full transition-all flex items-center justify-center">
                                            <i class="bi bi-x-lg text-lg"></i>
                                        </button>
                                    </div>

                                    <!-- Body -->
                                    <div class="p-6">
                                        <p class="text-gray-600 text-sm leading-relaxed mb-6">
                                            Are you sure you want to mark this order as <strong class="text-gray-900 font-semibold">Delivered / Completed</strong>?
                                        </p>

                                        <div class="mb-6 p-4 rounded-xl bg-amber-50 border border-amber-200/80 text-amber-900 text-xs flex items-start gap-3">
                                            <i class="bi bi-exclamation-triangle-fill text-amber-600 text-lg flex-shrink-0 mt-0.5"></i>
                                            <div>
                                                <strong class="font-bold uppercase tracking-wider text-[11px] text-amber-800 block mb-0.5">Important Notice</strong>
                                                <span>Once marked as completed, the status of this order <strong>cannot be changed again</strong>.</span>
                                            </div>
                                        </div>

                                        <!-- Footer Buttons -->
                                        <div class="flex items-center gap-3 pt-2">
                                            <button type="button" onclick="confirmComplete()"
                                                class="flex-1 bg-emerald-600 hover:bg-emerald-700 active:bg-emerald-800 text-white font-semibold text-sm py-3 px-5 rounded-xl shadow-sm transition-all flex items-center justify-center">
                                                <span>Yes, Mark Completed</span>
                                            </button>
                                            <button type="button"
                                                onclick="document.getElementById('complete-modal').classList.add('hidden')"
                                                class="flex-1 bg-gray-100 hover:bg-gray-200 active:bg-gray-300 text-gray-700 font-semibold text-sm py-3 px-5 rounded-xl transition-all">
                                                Go Back
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>

                        <script>
                            function confirmComplete() {
                                document.getElementById('update-status-form').submit();
                            }
                        </script>
                    </body>

                    </html>


