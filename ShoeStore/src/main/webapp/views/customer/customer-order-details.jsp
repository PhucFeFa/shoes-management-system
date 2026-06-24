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
                        <title>ADIDIS | Order Details</title>
                        <meta name="description" content="View details of your order at ADIDIS." />

                        <link href="https://fonts.googleapis.com" rel="preconnect" />
                        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
                        <link
                            href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
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
                        </style>
                    </head>

                    <body
                        class="bg-background text-on-background font-body-md text-body-md antialiased flex selection:bg-primary selection:text-on-primary min-h-screen">

                        <jsp:include page="sidebar.jsp">
                            <jsp:param name="activePage" value="orders" />
                        </jsp:include>

                        <main class="ml-64 flex-1 flex flex-col min-h-screen px-margin-desktop py-12">
                            <!-- Header & Summary Section -->
                            <header class="mb-12 border-b border-outline-variant pb-8">
                                <div class="flex flex-col md:flex-row md:items-end justify-between gap-6">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/profile/orders"
                                            class="text-label-sm font-label-sm text-secondary uppercase hover:text-primary mb-6 inline-flex items-center gap-1 transition-colors">
                                            <span class="material-symbols-outlined text-[16px]">arrow_back</span>
                                            Back to Orders
                                        </a>
                                        <span
                                            class="text-label-md font-label-md text-secondary tracking-widest uppercase mb-2 block">Order
                                            Confirmed</span>
                                        <c:if test="${not empty sessionScope.errorMessage}">
                                            <div class="mb-4 p-4 bg-[#ba1a1a]/10 border-l-4 border-[#ba1a1a] text-[#ba1a1a] font-label-md">
                                                ${sessionScope.errorMessage}
                                            </div>
                                            <c:remove var="errorMessage" scope="session"/>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.warningMessage}">
                                            <div class="mb-4 p-4 bg-yellow-100 border-l-4 border-yellow-500 text-yellow-800 font-label-md">
                                                ${sessionScope.warningMessage}
                                            </div>
                                            <c:remove var="warningMessage" scope="session"/>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.successMessage}">
                                            <div class="mb-4 p-4 bg-green-100 border-l-4 border-green-600 text-green-800 font-label-md">
                                                ${sessionScope.successMessage}
                                            </div>
                                            <c:remove var="successMessage" scope="session"/>
                                        </c:if>
                                        <h1 class="text-display-lg-mobile md:text-headline-lg font-headline-lg uppercase mb-4">
                                            Order SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}
                                        </h1>
                                        <div class="flex flex-wrap gap-x-8 gap-y-4">
                                            <div>
                                                <p class="text-label-sm font-label-sm text-secondary uppercase mb-1">
                                                    Order Date</p>
                                                <p class="text-body-md font-body-md font-semibold">
                                                    <fmt:formatDate value="${orderSummary.createdAt}"
                                                        pattern="MMMM dd, yyyy" />
                                                </p>
                                            </div>
                                            <div>
                                                <p class="text-label-sm font-label-sm text-secondary uppercase mb-1">
                                                    Status</p>
                                                <span
                                                    class="inline-flex items-center px-3 py-1 text-label-sm font-label-sm font-bold border border-outline-variant/30 status-${orderSummary.status}">
                                                    <c:if test="${orderSummary.status == 'pending'}">
                                                        <span
                                                            class="w-2 h-2 bg-primary rounded-full mr-2 animate-pulse"></span>
                                                    </c:if>
                                                    ${fn:toUpperCase(orderSummary.status)}
                                                </span>
                                            </div>
                                            <div>
                                                <p class="text-label-sm font-label-sm text-secondary uppercase mb-1">
                                                    Total Amount</p>
                                                <p class="text-body-md font-body-md font-semibold">
                                                    <fmt:formatNumber value="${orderSummary.totalAmount}"
                                                        type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <c:if test="${orderSummary.status == 'pending'}">
                                            <c:choose>
                                                <c:when test="${cancellationCount >= 5}">
                                                    <p class="text-[#ba1a1a] font-label-md uppercase tracking-widest border border-[#ba1a1a] px-6 py-3 bg-[#ba1a1a]/10 inline-block text-center w-full md:w-auto">
                                                        Cancellation Limit Reached
                                                    </p>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button"
                                                        onclick="document.getElementById('cancel-modal').classList.remove('hidden')"
                                                        class="bg-primary text-on-primary px-8 py-4 text-label-md font-label-md uppercase tracking-widest hover:opacity-90 active:scale-95 transition-all w-full md:w-auto">
                                                        Cancel Order
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </div>
                                </div>
                            </header>

                            <!-- Details Grid -->
                            <div class="grid grid-cols-1 xl:grid-cols-12 gap-gutter items-start">
                                <!-- Left Column: Items List -->
                                <div class="xl:col-span-8 space-y-8">
                                    <section>
                                        <h3
                                            class="text-label-md font-label-md uppercase tracking-widest mb-6 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-[20px]">inventory_2</span>
                                            Items (${fn:length(orderItems)})
                                        </h3>
                                        <div class="space-y-4">
                                            <c:forEach var="item" items="${orderItems}">
                                                <!-- Item -->
                                                <div
                                                    class="flex gap-6 p-4 bg-surface-container-lowest border border-outline-variant hover:border-primary transition-colors group">
                                                    <div
                                                        class="w-32 h-32 bg-surface-container overflow-hidden flex-shrink-0">
                                                        <img src="<c:choose><c:when test='${not empty item.imageUrl}'>${item.imageUrl}</c:when><c:otherwise>https://via.placeholder.com/300?text=No+Image</c:otherwise></c:choose>"
                                                            alt="${item.productName}"
                                                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                    </div>
                                                    <div class="flex flex-col justify-between flex-grow">
                                                        <div class="flex justify-between items-start">
                                                            <div>
                                                                <h4 class="text-body-lg font-bold uppercase mb-1">
                                                                    ${item.productName}</h4>
                                                                <p
                                                                    class="text-label-sm font-label-sm text-secondary uppercase">
                                                                    SERIES: ${empty item.categoryName ? 'N/A' :
                                                                    item.categoryName}</p>
                                                            </div>
                                                            <p class="text-body-md font-bold">
                                                                <fmt:formatNumber value="${item.priceAtPurchase}"
                                                                    type="currency" currencySymbol="₫"
                                                                    maxFractionDigits="0" />
                                                            </p>
                                                        </div>
                                                        <div class="flex justify-between items-end">
                                                            <div class="flex gap-6">
                                                                <div>
                                                                    <p
                                                                        class="text-label-sm font-label-sm text-secondary uppercase">
                                                                        Size</p>
                                                                    <p class="text-label-md font-bold uppercase">
                                                                        ${item.size}</p>
                                                                </div>
                                                                <div>
                                                                    <p
                                                                        class="text-label-sm font-label-sm text-secondary uppercase">
                                                                        Color</p>
                                                                    <p class="text-label-md font-bold uppercase">
                                                                        ${item.color}</p>
                                                                </div>
                                                                <div>
                                                                    <p
                                                                        class="text-label-sm font-label-sm text-secondary uppercase">
                                                                        Quantity</p>
                                                                    <p class="text-label-md font-bold uppercase">
                                                                        ${item.quantity}</p>
                                                                </div>
                                                            </div>
                                                            <p
                                                                class="text-label-sm font-label-sm text-secondary font-bold">
                                                                Total:
                                                                <fmt:formatNumber value="${item.totalPrice}"
                                                                    type="currency" currencySymbol="₫"
                                                                    maxFractionDigits="0" />
                                                            </p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </section>


                                </div>

                                <!-- Right Column: Shipping & Payment -->
                                <div class="xl:col-span-4 space-y-6">
                                    <!-- Shipping Address -->
                                    <section class="p-6 bg-surface-container border border-outline-variant">
                                        <h3
                                            class="text-label-md font-label-md uppercase tracking-widest mb-4 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-[20px]">location_on</span>
                                            Delivery Address
                                        </h3>
                                        <div class="space-y-1">
                                            <p class="text-body-md font-bold uppercase">${orderSummary.customerFullName}
                                            </p>
                                            <c:if test="${not empty orderSummary.addressLine}">
                                                <p class="text-body-md text-secondary uppercase">
                                                    ${orderSummary.addressLine}</p>
                                                <p class="text-body-md text-secondary uppercase">${orderSummary.ward},
                                                    ${orderSummary.district}</p>
                                                <p class="text-body-md text-secondary uppercase">${orderSummary.city}
                                                </p>
                                            </c:if>
                                            <c:if test="${empty orderSummary.addressLine}">
                                                <p class="text-body-md text-secondary">Address not available.</p>
                                            </c:if>
                                        </div>
                                    </section>

                                    <!-- Payment Method -->
                                    <section class="p-6 bg-surface-container border border-outline-variant">
                                        <h3
                                            class="text-label-md font-label-md uppercase tracking-widest mb-4 flex items-center gap-2">
                                            <span class="material-symbols-outlined text-[20px]">credit_card</span>
                                            Payment Method
                                        </h3>
                                        <div class="flex items-center gap-4">
                                            <div
                                                class="w-16 h-10 bg-primary flex items-center justify-center rounded-sm">
                                                <span class="text-on-primary font-bold italic uppercase text-xs">${empty
                                                    orderSummary.paymentMethod ? 'N/A' :
                                                    orderSummary.paymentMethod}</span>
                                            </div>
                                            <div>
                                                <p class="text-body-md font-bold uppercase">${empty
                                                    orderSummary.paymentMethod ? 'Not Specified' :
                                                    orderSummary.paymentMethod}</p>
                                                <p class="text-label-sm font-label-sm text-secondary uppercase">Status:
                                                    ${empty orderSummary.paymentStatus ? 'N/A' :
                                                    orderSummary.paymentStatus}</p>
                                            </div>
                                        </div>
                                    </section>

                                    <!-- Pricing Summary Card -->
                                    <section class="p-6 border-2 border-primary">
                                        <h3 class="text-label-md font-label-md uppercase tracking-widest mb-6">Order
                                            Calculation</h3>
                                        <div class="space-y-3">
                                            <div class="flex justify-between text-body-md">
                                                <span class="text-secondary">Subtotal</span>
                                                <span>
                                                    <fmt:formatNumber value="${orderSummary.totalAmount}"
                                                        type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                </span>
                                            </div>
                                            <div class="flex justify-between text-body-md">
                                                <span class="text-secondary">Shipping</span>
                                                <span class="uppercase">Included</span>
                                            </div>
                                            <div class="flex justify-between text-body-md">
                                                <span class="text-secondary">Voucher</span>
                                                <span class="uppercase">${not empty orderSummary.voucherId ? 'Applied' :
                                                    'None'}</span>
                                            </div>
                                            <div
                                                class="border-t border-outline-variant pt-4 mt-4 flex justify-between items-end">
                                                <span class="text-label-md font-bold uppercase">Grand Total</span>
                                                <span class="text-headline-md font-black text-primary">
                                                    <fmt:formatNumber value="${orderSummary.totalAmount}"
                                                        type="currency" currencySymbol="₫" maxFractionDigits="0" />
                                                </span>
                                            </div>
                                        </div>
                                    </section>
                                </div>
                            </div>

                            <!-- Cancel Order Modal -->
                            <div id="cancel-modal"
                                class="fixed inset-0 z-50 hidden bg-black/50 backdrop-blur-sm flex items-center justify-center p-4">
                                <div class="bg-surface-container-lowest w-full max-w-lg shadow-2xl relative">
                                    <!-- Header -->
                                    <div class="flex justify-between items-center p-6 border-b border-outline-variant">
                                        <h3 class="font-headline-sm text-headline-sm uppercase tracking-tighter">
                                            CANCEL ORDER
                                            SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}
                                        </h3>
                                        <button type="button"
                                            onclick="document.getElementById('cancel-modal').classList.add('hidden')"
                                            class="text-secondary hover:text-primary transition-colors">
                                            <span class="material-symbols-outlined">close</span>
                                        </button>
                                    </div>

                                    <!-- Body -->
                                    <form action="${pageContext.request.contextPath}/profile/order/cancel"
                                        method="POST" class="p-6">
                                        <input type="hidden" name="orderId" value="${orderSummary.id}">

                                        <p class="font-body-md text-body-md text-secondary mb-6">
                                            Are you sure you want to cancel this order?
                                            <strong class="text-primary">This action cannot be undone.</strong>
                                        </p>

                                        <div class="mb-8">
                                            <label
                                                class="block font-label-sm text-label-sm font-bold uppercase tracking-widest mb-2">
                                                REASON FOR CANCELLATION
                                            </label>
                                            <textarea name="reason" rows="4"
                                                class="w-full border border-outline-variant bg-surface p-3 font-body-md text-body-md text-primary focus:border-primary focus:ring-1 focus:ring-primary outline-none transition-all resize-none"
                                                placeholder="Additional notes for your cancellation request (optional)..."></textarea>
                                        </div>

                                        <!-- Footer -->
                                        <div class="flex gap-4">
                                            <button type="submit"
                                                class="flex-1 bg-[#ba1a1a] text-white py-4 font-label-md text-label-md uppercase tracking-widest font-bold hover:bg-[#93000a] transition-colors">
                                                YES, CANCEL ORDER
                                            </button>
                                            <button type="button"
                                                onclick="document.getElementById('cancel-modal').classList.add('hidden')"
                                                class="flex-1 border border-primary text-primary py-4 font-label-md text-label-md uppercase tracking-widest hover:bg-surface-container-low transition-colors">
                                                GO BACK
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </main>
                    </body>

                    </html>