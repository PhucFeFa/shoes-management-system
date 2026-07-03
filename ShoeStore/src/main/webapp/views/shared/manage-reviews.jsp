<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>SOLE_LAB | Review Management</title>
    
    <!-- Fonts from code.html -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@700&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    "colors": {
                        "surface-dim": "#dadada",
                        "primary-fixed": "#e2e2e2",
                        "on-secondary": "#ffffff",
                        "tertiary-fixed": "#e2e2e2",
                        "inverse-surface": "#303030",
                        "on-error-container": "#93000a",
                        "surface": "#f9f9f9",
                        "error": "#ba1a1a",
                        "on-primary-fixed": "#1b1b1b",
                        "on-background": "#1b1b1b",
                        "surface-container-lowest": "#ffffff",
                        "on-secondary-container": "#636565",
                        "secondary-fixed-dim": "#c6c7c6",
                        "tertiary": "#000000",
                        "outline": "#7e7576",
                        "status-pending-text": "#854d0e",
                        "secondary-fixed": "#e2e3e2",
                        "status-shipped-text": "#1e40af",
                        "tertiary-fixed-dim": "#c6c6c6",
                        "surface-container": "#eeeeee",
                        "secondary-container": "#e2e3e2",
                        "background": "#f9f9f9",
                        "on-tertiary-fixed": "#1b1b1b",
                        "on-primary": "#ffffff",
                        "status-delivered-text": "#166534",
                        "on-primary-fixed-variant": "#474747",
                        "status-delivered-bg": "#dcfce7",
                        "surface-container-highest": "#e2e2e2",
                        "on-secondary-fixed": "#1a1c1c",
                        "surface-variant": "#e2e2e2",
                        "status-cancelled-text": "#991b1b",
                        "on-surface": "#1b1b1b",
                        "tertiary-container": "#1b1b1b",
                        "outline-variant": "#c4c7c7",
                        "on-tertiary": "#ffffff",
                        "error-container": "#ffdad6",
                        "on-secondary-fixed-variant": "#454747",
                        "primary": "#000000",
                        "status-pending-bg": "#fef08a",
                        "surface-tint": "#5e5e5e",
                        "status-cancelled-bg": "#fee2e2",
                        "primary-container": "#1b1b1b",
                        "inverse-primary": "#c6c6c6",
                        "on-error": "#ffffff",
                        "surface-container-low": "#f3f3f3",
                        "inverse-on-surface": "#f1f1f1",
                        "primary-fixed-dim": "#c6c6c6",
                        "on-tertiary-fixed-variant": "#474747",
                        "surface-bright": "#f9f9f9",
                        "status-shipped-bg": "#dbeafe",
                        "on-primary-container": "#848484",
                        "on-tertiary-container": "#848484",
                        "on-surface-variant": "#4c4546",
                        "secondary": "#5d5f5f",
                        "surface-container-high": "#e8e8e8"
                    },
                    "borderRadius": {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                    "spacing": {
                        "margin-tablet": "32px",
                        "container-max": "1440px",
                        "base": "8px",
                        "margin-mobile": "20px",
                        "gutter": "24px",
                        "margin-desktop": "64px",
                        "sidebar-width": "256px",
                        "header-height": "64px"
                    },
                    "fontFamily": {
                        "headline-md": ["Inter"],
                        "data-mono": ["JetBrains Mono"],
                        "headline-lg": ["Inter"],
                        "display-lg": ["Inter"],
                        "body-md": ["Inter"],
                        "label-sm": ["Inter"],
                        "body-lg": ["Inter"],
                        "label-md": ["Inter"]
                    },
                    "fontSize": {
                        "headline-md": ["24px", {"lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                        "data-mono": ["14px", {"lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "700"}],
                        "headline-lg": ["32px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                        "display-lg": ["72px", {"lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800"}],
                        "body-md": ["16px", {"lineHeight": "1.5", "letterSpacing": "0", "fontWeight": "400"}],
                        "label-sm": ["12px", {"lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "500"}],
                        "body-lg": ["18px", {"lineHeight": "1.6", "letterSpacing": "0", "fontWeight": "400"}],
                        "label-md": ["14px", {"lineHeight": "1.0", "letterSpacing": "0.05em", "fontWeight": "600"}]
                    }
                },
            },
        }
    </script>
    <style>
        .material-symbols-outlined {
            font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
        }
        
        .material-symbols-outlined.fill {
            font-variation-settings: 'FILL' 1;
        }

        ::-webkit-scrollbar { width: 4px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: #c4c7c7; border-radius: 2px; }
        
        .data-mono-text { font-family: 'JetBrains Mono', monospace; font-size: 11px; }

        .hidden-drawer {
            opacity: 0;
            pointer-events: none;
        }
        .translate-out {
            transform: translateX(100%);
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

        .main-content {
            margin-left: 220px;
        }
        
        .main-content.admin-view {
            margin-left: 256px;
        }
    </style>
</head>

<body class="bg-background text-on-surface font-body-md overflow-x-hidden antialiased selection:bg-primary selection:text-on-primary min-h-screen">

    <!-- Staff Sidebar -->
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
                <a href="${pageContext.request.contextPath}/staff/orders" class="">
                    <i class="bi bi-cart"></i>
                    <span>Orders</span>
                </a>
            </li>
            <li class="adidis-nav-item">
                <a href="${pageContext.request.contextPath}/manage-reviews" class="active">
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

    <!-- Main Wrapper -->
    <main class="main-content flex-1 flex flex-col min-h-screen">

        <!-- Header Section -->
        <header class="px-margin-desktop pt-margin-desktop pb-8 flex justify-between items-end border-b border-outline-variant/30">
            <div>
                <h2 class="font-headline-lg text-headline-lg text-primary tracking-tight">Review Management</h2>
                <p class="font-body-md text-body-md text-secondary mt-2 max-w-lg">
                    Monitor and moderate customer feedback across the athletic catalog.
                </p>
            </div>
        </header>

        <!-- Control Bar: Filters & Search (GET form) -->
        <section class="px-margin-desktop py-6 flex justify-between items-center bg-surface-bright sticky top-0 z-30 shadow-[0_1px_0_rgba(0,0,0,0.05)]">
            <form method="get" action="${pageContext.request.contextPath}/manage-reviews" class="flex items-center gap-4 flex-1">
                <!-- Search Input -->
                <div class="relative w-full max-w-md">
                    <span class="material-symbols-outlined absolute left-4 top-1/2 -translate-y-1/2 text-secondary pointer-events-none">search</span>
                    <input id="keyword-input" class="w-full bg-surface-container text-primary font-body-md text-body-md pl-12 pr-4 py-3 rounded-full border-none focus:ring-2 focus:ring-primary focus:outline-none transition-shadow placeholder:text-secondary" type="text" name="keyword" placeholder="Search by customer name..." value="${keyword}">
                </div>
                <!-- Status Filter -->
                <div class="flex gap-3">
                    <select id="status-select" name="filter" onchange="this.form.submit()" class="bg-surface border border-outline-variant text-primary font-label-md text-label-md uppercase py-3 pl-4 pr-10 rounded-lg focus:ring-1 focus:ring-primary focus:border-primary appearance-none cursor-pointer hover:border-outline transition-colors">
                        <option value="ALL" <c:if test="${empty currentFilter or currentFilter == 'ALL'}">selected</c:if>>All Reviews</option>
                        <option value="PENDING_HIDE" <c:if test="${currentFilter == 'PENDING_HIDE'}">selected</c:if>>Pending Approval</option>
                        <option value="VISIBLE" <c:if test="${currentFilter == 'VISIBLE'}">selected</c:if>>Approved / Visible</option>
                    </select>
                </div>
                <button type="submit" class="px-5 py-3 bg-primary text-on-primary font-label-md text-label-md uppercase rounded-lg hover:opacity-90 transition-opacity">
                    Search
                </button>
            </form>
        </section>

        <!-- Data Table -->
        <section class="px-margin-desktop py-6 flex-1">
            <div class="border border-outline-variant bg-surface overflow-hidden shadow-sm">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-surface-container-low border-b border-outline-variant">
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Product</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Customer</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Rating</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Comment</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Date</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider">Status</th>
                            <th class="py-4 px-6 font-label-sm text-label-sm uppercase text-secondary tracking-wider text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-outline-variant">
                        <c:forEach items="${reviews}" var="review">
                            <tr class="hover:bg-surface-container-low transition-colors group">
                                <td class="py-4 px-6">
                                    <div class="flex items-center gap-3">
                                        <div class="w-10 h-10 bg-surface-container flex-shrink-0 border border-outline-variant overflow-hidden">
                                            <img class="w-full h-full object-cover" src="${not empty review.productImage ? review.productImage : 'https://via.placeholder.com/50'}" alt="${review.productName}" />
                                        </div>
                                        <span class="data-mono-text uppercase">${review.productName}</span>
                                    </div>
                                </td>
                                <td class="py-4 px-6">
                                    <div class="flex items-center gap-2">
                                        <div class="w-6 h-6 rounded-full bg-primary-fixed flex items-center justify-center text-[10px] text-primary uppercase font-bold">
                                            ${review.userName.substring(0, 1)}
                                        </div>
                                        <span class="font-medium text-sm">${review.userName}</span>
                                    </div>
                                </td>
                                <td class="py-4 px-6">
                                    <div class="flex text-primary">
                                        <c:forEach begin="1" end="5" var="i">
                                            <span class="material-symbols-outlined text-[16px]" style="${i <= review.rating ? 'font-variation-settings: \'FILL\' 1;' : ''}">star</span>
                                        </c:forEach>
                                    </div>
                                </td>
                                <td class="py-4 px-6 max-w-xs">
                                    <p class="text-sm truncate opacity-80 italic">"${review.comment}"</p>
                                    <c:if test="${not empty review.replyComment}">
                                        <p class="text-xs text-secondary mt-1 truncate"><strong class="uppercase">Store Reply:</strong> ${review.replyComment}</p>
                                    </c:if>
                                </td>
                                <td class="py-4 px-6">
                                    <span class="data-mono-text opacity-60">
                                        <fmt:formatDate value="${review.createdAt}" pattern="dd/MM/yyyy" />
                                    </span>
                                </td>
                                <td class="py-4 px-6">
                                    <c:choose>
                                        <c:when test="${review.moderationStatus == 'VISIBLE'}">
                                            <span class="px-3 py-1 rounded-full text-[11px] font-black uppercase bg-status-delivered-bg text-status-delivered-text">Approved</span>
                                        </c:when>
                                        <c:when test="${review.moderationStatus == 'PENDING_HIDE'}">
                                            <span class="px-3 py-1 rounded-full text-[11px] font-black uppercase bg-status-pending-bg text-status-pending-text">Flagged</span>
                                        </c:when>
                                    </c:choose>
                                </td>
                                <td class="py-4 px-6 text-right">
                                    <div class="flex justify-end gap-2">
                                        <button type="button" data-review-id="${review.id}" class="p-2 hover:bg-primary hover:text-on-primary transition-all rounded" onclick="openDrawer('${review.id}', '${review.productImage}', '${review.productName}', '${review.userName}', '${review.rating}', '${review.comment.replace('\'', '\\\'')}', '${review.replyComment != null ? review.replyComment.replace('\'', '\\\'') : ''}', '${review.moderationStatus}', '${review.hideReason != null ? review.hideReason.replace('\'', '\\\'') : ''}')">
                                            <span class="material-symbols-outlined text-[18px]">chat_bubble_outline</span>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty reviews}">
                            <tr>
                                <td colspan="7" class="py-8 text-center text-on-surface-variant font-label-md">No reviews found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
    </main>

    <!-- Side Drawer -->
    <div class="fixed inset-0 bg-primary/40 backdrop-blur-sm z-50 transition-opacity hidden-drawer" id="reviewDrawer">
        <div class="absolute right-0 top-0 h-full w-full max-w-lg bg-surface flex flex-col shadow-2xl translate-out transition-transform duration-300" id="drawerPanel">
            <div class="p-8 border-b border-outline-variant flex justify-between items-center bg-surface-container-low">
                <div>
                    <h3 class="font-headline-md text-headline-md font-black uppercase tracking-tighter">Review Detail</h3>
                    <p class="data-mono-text uppercase text-on-surface-variant" id="d-id">ID: </p>
                </div>
                <button class="p-2 hover:bg-on-surface hover:text-surface transition-colors" onclick="closeDrawer()">
                    <span class="material-symbols-outlined" data-icon="close">close</span>
                </button>
            </div>

            <div class="p-8 flex-1 overflow-y-auto space-y-8">
                <!-- Alerts -->
                <c:if test="${not empty sessionScope.successMessage or not empty sessionScope.errorMessage}">
                    <div id="drawer-alerts">
                        <c:if test="${not empty sessionScope.successMessage}">
                            <div class="p-4 bg-status-delivered-bg text-status-delivered-text font-label-md rounded-lg border border-status-delivered-text/20">
                                ${sessionScope.successMessage}
                            </div>
                            <c:remove var="successMessage" scope="session" />
                        </c:if>
                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="p-4 bg-status-cancelled-bg text-status-cancelled-text font-label-md rounded-lg border border-status-cancelled-text/20">
                                ${sessionScope.errorMessage}
                            </div>
                            <c:remove var="errorMessage" scope="session" />
                        </c:if>
                    </div>
                </c:if>
                
                <section>
                    <label class="font-label-md text-label-md uppercase tracking-widest text-on-surface-variant block mb-3">Product Context</label>
                    <div class="p-4 border border-outline-variant bg-surface-container-low flex items-center gap-4">
                        <div class="w-16 h-16 bg-surface-container-highest flex-shrink-0">
                            <img class="w-full h-full object-cover" id="d-p-img" src="" />
                        </div>
                        <div>
                            <p class="font-label-md text-label-md font-bold uppercase" id="d-p-name"></p>
                        </div>
                    </div>
                </section>

                <section>
                    <label class="font-label-md text-label-md uppercase tracking-widest text-on-surface-variant block mb-3">Customer Feedback <span id="d-c-name" class="lowercase opacity-60"></span></label>
                    <div class="p-6 border border-outline-variant space-y-4">
                        <div class="flex text-primary" id="d-rating"></div>
                        <p class="font-body-lg text-primary italic leading-relaxed" id="d-comment"></p>
                    </div>
                </section>

                <div id="flag-reason-section" style="display: none;">
                    <label class="font-label-md text-label-md uppercase tracking-widest text-error block mb-3">Flag Reason</label>
                    <div class="p-4 border border-error bg-error-container text-on-error-container italic" id="d-hide-reason"></div>
                </div>

                <section>
                    <form action="${pageContext.request.contextPath}/manage-reviews/reply" method="post" id="replyForm">
                        <input type="hidden" name="reviewId" id="reply-review-id" />
                        <input type="hidden" name="filter" value="${currentFilter}" />
                        <label class="font-label-md text-label-md uppercase tracking-widest text-on-surface-variant block mb-3">Moderator Reply</label>
                        <textarea name="replyComment" id="d-reply" class="w-full bg-surface-container border-none focus:ring-1 focus:ring-primary h-32 p-4 font-body-md text-sm" placeholder="Type your public response here..."></textarea>
                        <p id="reply-error" class="text-error font-label-sm mt-2 hidden"></p>
                    </form>
                </section>

                <section id="flag-action-section">
                    <form action="${pageContext.request.contextPath}/manage-reviews/hide" method="post" id="hideForm">
                        <input type="hidden" name="reviewId" id="hide-review-id" />
                        <input type="hidden" name="filter" value="${currentFilter}" />
                        <label class="font-label-md text-label-md uppercase tracking-widest text-error block mb-3">Flag Content</label>
                        <textarea name="hideReason" id="d-hide-input" class="w-full bg-surface-container border-none focus:ring-1 focus:ring-error h-20 p-4 font-body-md text-sm" placeholder="Reason for flagging/hiding this review..."></textarea>
                        <p id="hide-error" class="text-error font-label-sm mt-2 hidden"></p>
                    </form>
                </section>
            </div>

            <div class="p-8 border-t border-outline-variant bg-surface-container-lowest grid grid-cols-2 gap-4">
                <button form="hideForm" type="submit" class="py-4 border border-error text-error uppercase font-label-md text-label-md tracking-widest hover:bg-error-container transition-colors" id="btn-flag">Flag Review</button>
                <button form="replyForm" type="submit" class="py-4 bg-primary text-on-primary uppercase font-label-md text-label-md tracking-widest hover:opacity-90 transition-opacity">Save Reply</button>
            </div>
        </div>
    </div>

    <script>
        <c:if test="${not empty param.open}">
        document.addEventListener("DOMContentLoaded", function() {
            const btn = document.querySelector("button[data-review-id='${param.open}']");
            if (btn) {
                btn.click();
            }
        });
        </c:if>

        document.getElementById('replyForm').addEventListener('submit', function(e) {
            e.preventDefault();
            submitAjaxForm(this, 'reply');
        });

        document.getElementById('hideForm').addEventListener('submit', function(e) {
            e.preventDefault();
            submitAjaxForm(this, 'hide');
        });

        function submitAjaxForm(form, actionType) {
            const formData = new FormData(form);
            const url = new URL(form.action, window.location.origin);
            url.searchParams.append('ajax', 'true');

            // Reset errors
            document.getElementById('reply-error').classList.add('hidden');
            document.getElementById('hide-error').classList.add('hidden');
            document.getElementById('d-reply').classList.remove('ring-1', 'ring-error');
            document.getElementById('d-hide-input').classList.remove('ring-1', 'ring-error');

            let alertsContainer = document.getElementById('drawer-alerts');
            if (!alertsContainer) {
                const drawerBody = document.querySelector('.p-8.flex-1.overflow-y-auto');
                alertsContainer = document.createElement('div');
                alertsContainer.id = 'drawer-alerts';
                drawerBody.insertBefore(alertsContainer, drawerBody.firstChild);
            }

            fetch(url, {
                method: 'POST',
                body: new URLSearchParams(formData)
            })
            .then(res => res.json())
            .then(data => {
                alertsContainer.innerHTML = ''; 
                
                if (data.success) {
                    alertsContainer.innerHTML = '<div class="p-4 bg-status-delivered-bg text-status-delivered-text font-label-md rounded-lg border border-status-delivered-text/20 mb-4">' + data.message + '</div>';
                    if (actionType === 'reply') {
                        document.getElementById('d-reply').value = data.reply;
                    } else if (actionType === 'hide') {
                        document.getElementById('flag-reason-section').style.display = 'block';
                        document.getElementById('d-hide-reason').innerText = data.reason;
                        document.getElementById('flag-action-section').style.display = 'none';
                        document.getElementById('btn-flag').style.display = 'none';
                    }
                } else {
                    if (actionType === 'reply') {
                        const errEl = document.getElementById('reply-error');
                        errEl.innerText = data.message;
                        errEl.classList.remove('hidden');
                        document.getElementById('d-reply').classList.add('ring-1', 'ring-error');
                    } else if (actionType === 'hide') {
                        const errEl = document.getElementById('hide-error');
                        errEl.innerText = data.message;
                        errEl.classList.remove('hidden');
                        document.getElementById('d-hide-input').classList.add('ring-1', 'ring-error');
                    }
                }
            })
            .catch(err => {
                alertsContainer.innerHTML = '<div class="p-4 bg-status-cancelled-bg text-status-cancelled-text font-label-md rounded-lg border border-status-cancelled-text/20 mb-4">An error occurred. Please try again.</div>';
            });
        }

        function openDrawer(id, pImg, pName, cName, rating, comment, reply, modStatus, hideReason) {
            document.getElementById('d-id').innerText = 'ID: ' + id;
            document.getElementById('d-p-img').src = pImg ? pImg : 'https://via.placeholder.com/50';
            document.getElementById('d-p-name').innerText = pName;
            document.getElementById('d-c-name').innerText = '- ' + cName;

            // Reset previous error states
            document.getElementById('reply-error').classList.add('hidden');
            document.getElementById('hide-error').classList.add('hidden');
            document.getElementById('d-reply').classList.remove('ring-1', 'ring-error');
            document.getElementById('d-hide-input').classList.remove('ring-1', 'ring-error');
            let alertsContainer = document.getElementById('drawer-alerts');
            if (alertsContainer) alertsContainer.innerHTML = '';

            let stars = '';
            for (let i = 1; i <= 5; i++) {
                if (i <= rating) stars += '<span class="material-symbols-outlined" style="font-variation-settings: \'FILL\' 1;">star</span>';
                else stars += '<span class="material-symbols-outlined">star</span>';
            }
            document.getElementById('d-rating').innerHTML = stars;
            document.getElementById('d-comment').innerText = '"' + comment + '"';

            document.getElementById('d-reply').value = reply;
            document.getElementById('reply-review-id').value = id;
            document.getElementById('hide-review-id').value = id;

            if (modStatus === 'PENDING_HIDE') {
                document.getElementById('flag-reason-section').style.display = 'block';
                document.getElementById('d-hide-reason').innerText = hideReason;
                document.getElementById('flag-action-section').style.display = 'none';
                document.getElementById('btn-flag').style.display = 'none';
            } else {
                document.getElementById('flag-reason-section').style.display = 'none';
                document.getElementById('flag-action-section').style.display = 'block';
                document.getElementById('btn-flag').style.display = 'block';
            }

            const drawer = document.getElementById('reviewDrawer');
            const panel = document.getElementById('drawerPanel');
            drawer.classList.remove('hidden-drawer');
            panel.classList.remove('translate-out');
        }

        function closeDrawer() {
            const drawer = document.getElementById('reviewDrawer');
            const panel = document.getElementById('drawerPanel');
            drawer.classList.add('hidden-drawer');
            panel.classList.add('translate-out');
            
            // Remove 'open' param from URL
            const url = new URL(window.location);
            if (url.searchParams.has('open')) {
                url.searchParams.delete('open');
                window.history.replaceState({}, document.title, url.toString());
            }
        }
    </script>
</body>
</html>