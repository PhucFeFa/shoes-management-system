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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
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
                        "body-md": ["16px", {"lineHeight": "1.5", "letterSpacing": "0", "fontWeight": "400"}],
                        "label-sm": ["12px", {"lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "500"}],
                        "display-lg": ["72px", {"lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800"}],
                        "body-lg": ["18px", {"lineHeight": "1.6", "letterSpacing": "0", "fontWeight": "400"}],
                        "headline-lg": ["32px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "display-lg-mobile": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                        "label-md": ["14px", {"lineHeight": "1.0", "letterSpacing": "0.05em", "fontWeight": "600"}],
                        "headline-md": ["24px", {"lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "600"}]
                    }
                }
            }
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        .material-symbols-outlined[style*="'FILL' 1"] {
            font-variation-settings: 'FILL' 1, 'wght' 400, 'GRAD' 0, 'opsz' 24;
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
            margin-left: 220px;
        }
        /* Custom scrollbar for minimal aesthetic */
        ::-webkit-scrollbar {
            width: 8px;
            height: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #f9f9f9; 
        }
        ::-webkit-scrollbar-thumb {
            background: #c4c7c7; 
            border-radius: 0px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #5d5f5f; 
        }
        .status-pending  { background-color: #e2e2e2; color: #1a1c1c; }
        .status-confirmed { background-color: #1a1c1c; color: #ffffff; }
        .status-shipping { background-color: #000000; color: #ffffff; }
        .status-completed { background-color: #d1fae5; color: #065f46; border-color: #065f46; }
        .status-cancelled { background-color: #ffdad6; color: #93000a; border-color: #93000a; }
        .status-returned { background-color: #fef08a; color: #854d0e; border-color: #854d0e; }
    </style>
</head>
<body class="bg-background text-on-surface font-body-md text-body-md antialiased overflow-hidden flex h-screen">
<!-- SideNavBar (Shared Component) -->
<div class="adidis-sidebar">
    <div class="adidis-brand">
        <div class="adidis-brand-name">Adidis</div>
        <div class="adidis-brand-sub">Staff Portal</div>
    </div>

    <ul class="adidis-nav">
        <li class="adidis-nav-item">
            <a href="${pageContext.request.contextPath}/home" class="">
                <i class="bi bi-speedometer2"></i>
                <span>Dashboard</span>
            </a>
        </li>
        <li class="adidis-nav-item">
            <a href="${pageContext.request.contextPath}/staff/orders" class="active">
                <i class="bi bi-cart"></i>
                <span>Orders</span>
            </a>
        </li>
        <li class="adidis-nav-item">
            <a href="${pageContext.request.contextPath}/manage-reviews" class="">
                <span class="material-symbols-outlined text-[18px]">rate_review</span>
                <span>Reviews</span>
            </a>
        </li>
        <li class="adidis-nav-item">
            <a href="#" class="">
                <i class="bi bi-box-seam"></i>
                <span>Inventory</span>
            </a>
        </li>
        <li class="adidis-nav-item">
            <a href="#" class="">
                <i class="bi bi-people"></i>
                <span>Customers</span>
            </a>
        </li>
        <li class="adidis-nav-item">
            <a href="#" class="">
                <i class="bi bi-gear"></i>
                <span>Settings</span>
            </a>
        </li>
    </ul>

    <div class="adidis-footer">
        <a href="${pageContext.request.contextPath}/home">
            <i class="bi bi-box-arrow-left"></i>
            <span>Back to Website</span>
        </a>
    </div>
</div>

<!-- Main Content Canvas -->
<main class="main-content flex-1 h-full overflow-y-auto bg-background">
    <div class="max-w-container-max mx-auto px-margin-desktop py-margin-desktop">
        
        <c:if test="${not empty sessionScope.successMessage}">
            <div class="bg-d1fae5 text-065f46 p-4 mb-6 border border-065f46 flex justify-between">
                <span>${sessionScope.successMessage}</span>
            </div>
            <c:remove var="successMessage" scope="session" />
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="bg-error-container text-error p-4 mb-6 border border-error flex justify-between">
                <span>${sessionScope.errorMessage}</span>
            </div>
            <c:remove var="errorMessage" scope="session" />
        </c:if>

        <!-- Page Header & Action Bar -->
        <div class="flex flex-col md:flex-row md:items-end justify-between gap-6 mb-12 border-b border-outline-variant pb-6">
            <div>
                <div class="flex items-center gap-2 text-secondary font-label-md text-label-md uppercase mb-4 tracking-widest">
                    <a class="hover:text-primary transition-colors" href="${pageContext.request.contextPath}/staff/orders">Orders</a>
                    <span class="material-symbols-outlined text-[16px]">chevron_right</span>
                    <span class="text-primary">Details</span>
                </div>
                <div class="flex items-center gap-4">
                    <h2 class="font-headline-lg text-headline-lg text-primary uppercase tracking-tighter">ORDER #SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}</h2>
                    <span class="px-3 py-1 font-label-sm text-label-sm uppercase tracking-widest border status-${orderSummary.status}">${orderSummary.status}</span>
                </div>
                <p class="font-body-md text-body-md text-secondary mt-2">Placed on <fmt:formatDate value="${orderSummary.createdAt}" pattern="MMM dd, yyyy 'at' HH:mm" /></p>
            </div>
            <div class="flex items-center gap-3">
                <c:if test="${orderSummary.status != 'cancelled'}">
                    <c:if test="${orderSummary.status == 'pending' || orderSummary.status == 'confirmed'}">
                        <button type="button" onclick="document.getElementById('cancel-modal').classList.remove('hidden')" class="border-[1.5px] border-primary text-primary bg-transparent hover:bg-primary hover:text-on-primary transition-colors font-label-md text-label-md uppercase px-6 py-3 flex items-center gap-2 rounded-none">
                            Cancel Order
                        </button>
                    </c:if>
                    
                    <c:choose>
                        <c:when test="${orderSummary.status == 'completed' || orderSummary.status == 'delivered' || orderSummary.status == 'returned'}">
                            <span class="px-6 py-3 font-label-md text-label-md uppercase text-065f46 bg-d1fae5 border border-065f46 cursor-not-allowed">
                                Order ${orderSummary.status == 'returned' ? 'Returned' : 'Completed'}
                            </span>
                        </c:when>
                        <c:otherwise>
                            <form id="update-status-form" action="${pageContext.request.contextPath}/staff/order/update-status" method="POST" class="flex items-center gap-2" onsubmit="return handleStatusUpdate(event)">
                                <input type="hidden" name="orderId" value="${orderSummary.id}">
                                <select name="status" class="border-[1.5px] border-primary bg-surface-container-lowest text-primary font-label-md text-label-md uppercase pl-4 pr-10 py-3 outline-none focus:ring-0 cursor-pointer">
                                    <option value="pending" ${orderSummary.status == 'pending' ? 'selected' : ''}>Pending</option>
                                    <option value="confirmed" ${orderSummary.status == 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                    <option value="shipping" ${orderSummary.status == 'shipping' ? 'selected' : ''}>Shipped</option>
                                    <option value="completed" ${orderSummary.status == 'completed' ? 'selected' : ''}>Delivered / Completed</option>
                                    <option value="returned" ${orderSummary.status == 'returned' ? 'selected' : ''}>Returned</option>
                                </select>
                                <button type="submit" class="border-[1.5px] border-primary text-on-primary bg-primary hover:bg-opacity-90 transition-colors font-label-md text-label-md uppercase px-6 py-3 flex items-center gap-2 rounded-none">
                                    Save
                                </button>
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
                <div class="bg-surface-container-lowest border border-outline-variant p-8 rounded-none">
                    <h3 class="font-label-md text-label-md uppercase text-primary border-b border-outline-variant pb-4 mb-6 tracking-widest">Line Items</h3>
                    <div class="flex flex-col gap-6">
                        <c:forEach var="item" items="${orderItems}">
                            <!-- Item -->
                            <div class="flex gap-6 items-center pb-6 border-b border-surface-container-high last:border-0 last:pb-0">
                                <div class="w-32 h-32 bg-surface-container flex-shrink-0 border border-outline-variant p-2">
                                    <img alt="${item.productName}" class="w-full h-full object-cover mix-blend-multiply filter grayscale contrast-125" src="<c:choose><c:when test='${not empty item.imageUrl}'>${item.imageUrl}</c:when><c:otherwise>https://via.placeholder.com/300</c:otherwise></c:choose>">
                                </div>
                                <div class="flex-1">
                                    <h4 class="font-headline-md text-[18px] text-primary uppercase font-bold tracking-tight">${item.productName}</h4>
                                    <p class="font-body-md text-body-md text-secondary mt-1">SERIES: ${item.categoryName}</p>
                                    <div class="flex items-center gap-4 mt-3">
                                        <span class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Size ${item.size}</span>
                                        <span class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Color: ${item.color}</span>
                                        <span class="bg-surface-container px-2 py-1 font-label-sm text-label-sm text-primary uppercase border border-outline-variant">Qty: ${item.quantity}</span>
                                    </div>
                                </div>
                                <div class="text-right">
                                    <p class="font-label-md text-[18px] text-primary font-bold"><fmt:formatNumber value="${item.priceAtPurchase}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></p>
                                    <p class="font-label-sm text-secondary mt-1">Total: <fmt:formatNumber value="${item.totalPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>

            <!-- Right Column: Info Cards (Spans 4 cols) -->
            <div class="lg:col-span-4 flex flex-col gap-gutter">
                <!-- Customer Card -->
                <div class="bg-surface-container-lowest border border-outline-variant p-6 rounded-none">
                    <div class="flex items-center justify-between mb-4 border-b border-outline-variant pb-4">
                        <h3 class="font-label-md text-label-md uppercase tracking-widest text-primary">Customer</h3>
                    </div>
                    <div class="space-y-4">
                        <div class="flex items-center gap-3">
                            <div class="w-10 h-10 bg-surface-container flex items-center justify-center border border-outline-variant">
                                <span class="material-symbols-outlined text-secondary">person</span>
                            </div>
                            <div>
                                <p class="font-label-md text-label-md text-primary uppercase underline underline-offset-4 decoration-outline-variant/50 cursor-pointer hover:text-secondary">${orderSummary.customerFullName}</p>
                                <p class="font-body-md text-body-md text-secondary mt-0.5">${orderSummary.customerEmail}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Logistics Card -->
                <div class="bg-surface-container-lowest border border-outline-variant p-6 rounded-none">
                    <h3 class="font-label-md text-label-md uppercase tracking-widest text-primary border-b border-outline-variant pb-4 mb-4">Logistics</h3>
                    <div class="space-y-6">
                        <div>
                            <div class="flex items-center gap-2 mb-2">
                                <span class="material-symbols-outlined text-[18px] text-secondary">local_shipping</span>
                                <h4 class="font-label-sm text-label-sm text-secondary uppercase">Shipping Address</h4>
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
                <div class="bg-surface-container-lowest border border-outline-variant p-6 rounded-none bg-surface-bright">
                    <h3 class="font-label-md text-label-md uppercase tracking-widest text-primary border-b border-outline-variant pb-4 mb-4">Financials</h3>
                    <div class="space-y-3 font-body-md text-body-md">
                        <div class="flex justify-between items-center text-secondary">
                            <span>Payment Method</span>
                            <span class="uppercase">${empty orderSummary.paymentMethod ? 'N/A' : orderSummary.paymentMethod}</span>
                        </div>
                        <div class="flex justify-between items-center text-secondary">
                            <span>Payment Status</span>
                            <span class="uppercase">${empty orderSummary.paymentStatus ? 'N/A' : orderSummary.paymentStatus}</span>
                        </div>
                        <div class="flex justify-between items-center text-secondary pt-2">
                            <span>Subtotal</span>
                            <span><fmt:formatNumber value="${orderSummary.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                        </div>
                        <div class="flex justify-between items-center text-primary font-bold pt-4 border-t border-outline-variant mt-2">
                            <span class="font-label-md uppercase tracking-widest">Total Amount</span>
                            <span class="text-xl tracking-tight"><fmt:formatNumber value="${orderSummary.totalAmount}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Cancel Order Modal -->
    <div id="cancel-modal" class="fixed inset-0 z-[100] hidden bg-black/50 backdrop-blur-sm flex items-center justify-center p-4">
        <div class="bg-surface-container-lowest w-full max-w-lg shadow-2xl relative border border-primary">
            <!-- Header -->
            <div class="flex justify-between items-center p-6 border-b border-outline-variant bg-surface-bright">
                <h3 class="font-headline-md text-headline-md font-bold uppercase flex items-center gap-2 tracking-tighter">
                    CANCEL ORDER #SL-${fn:toUpperCase(fn:substring(orderSummary.id, 0, 8))}
                </h3>
                <button type="button" onclick="document.getElementById('cancel-modal').classList.add('hidden')" class="text-secondary hover:text-primary transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            
            <!-- Body -->
            <form action="${pageContext.request.contextPath}/staff/order/update-status" method="POST" class="p-6">
                <input type="hidden" name="orderId" value="${orderSummary.id}">
                <input type="hidden" name="status" value="cancelled">
                
                <p class="font-body-md text-body-md text-secondary mb-6 leading-relaxed">
                    Are you sure you want to cancel this order upon customer request? 
                    This action will halt fulfillment and notify the customer. <strong class="text-primary underline decoration-error underline-offset-2">This action cannot be undone.</strong>
                </p>
                
                <div class="mb-8">
                    <label class="block font-label-sm text-label-sm font-bold uppercase tracking-widest mb-2 text-primary">
                        REASON FOR CANCELLATION
                    </label>
                    <textarea name="reason" rows="4" class="w-full border-2 border-outline-variant bg-surface-container-lowest p-3 font-body-md text-body-md text-primary focus:border-primary focus:ring-0 outline-none transition-all resize-none" placeholder="Staff notes regarding the cancellation request..."></textarea>
                </div>
                
                <!-- Footer -->
                <div class="flex gap-4">
                    <button type="submit" class="flex-1 bg-[#ba1a1a] text-white py-4 font-label-md text-label-md uppercase tracking-widest font-bold hover:bg-[#93000a] transition-colors rounded-none border border-[#ba1a1a]">
                        YES, CANCEL ORDER
                    </button>
                    <button type="button" onclick="document.getElementById('cancel-modal').classList.add('hidden')" class="flex-1 border-[1.5px] border-primary text-primary py-4 font-label-md text-label-md uppercase tracking-widest font-bold hover:bg-surface-container-low transition-colors rounded-none">
                        GO BACK
                    </button>
                </div>
            </form>
        </div>
    </div>
    <!-- Complete Order Modal -->
    <div id="complete-modal" class="fixed inset-0 z-[100] hidden bg-black/50 backdrop-blur-sm flex items-center justify-center p-4">
        <div class="bg-surface-container-lowest w-full max-w-lg shadow-2xl relative border border-primary">
            <div class="flex justify-between items-center p-6 border-b border-outline-variant bg-surface-bright">
                <h3 class="font-headline-md text-headline-md font-bold uppercase flex items-center gap-2 tracking-tighter text-065f46">
                    <span class="material-symbols-outlined">check_circle</span>
                    CONFIRM COMPLETION
                </h3>
                <button type="button" onclick="document.getElementById('complete-modal').classList.add('hidden')" class="text-secondary hover:text-primary transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            
            <div class="p-6">
                <p class="font-body-md text-body-md text-secondary mb-6 leading-relaxed">
                    Are you sure you want to mark this order as <strong class="text-primary">Delivered / Completed</strong>? 
                    <br><br>
                    <strong class="text-error uppercase">Important:</strong> Once marked as completed, the status of this order <strong>cannot be changed again</strong>.
                </p>
                
                <div class="flex gap-4">
                    <button type="button" onclick="confirmComplete()" class="flex-1 bg-[#065f46] text-white py-4 font-label-md text-label-md uppercase tracking-widest font-bold hover:bg-opacity-90 transition-colors rounded-none border border-[#065f46]">
                        YES, MARK COMPLETED
                    </button>
                    <button type="button" onclick="document.getElementById('complete-modal').classList.add('hidden')" class="flex-1 border-[1.5px] border-primary text-primary py-4 font-label-md text-label-md uppercase tracking-widest font-bold hover:bg-surface-container-low transition-colors rounded-none">
                        GO BACK
                    </button>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    function handleStatusUpdate(event) {
        const select = document.querySelector('select[name="status"]');
        if (select.value === 'completed') {
            event.preventDefault();
            document.getElementById('complete-modal').classList.remove('hidden');
            return false;
        }
        return true;
    }

    function confirmComplete() {
        document.getElementById('update-status-form').submit();
    }
</script>
</body>
</html>
