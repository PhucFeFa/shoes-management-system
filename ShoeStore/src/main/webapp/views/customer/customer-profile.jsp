<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <%@ page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html class="light" lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <title>ADIDIS | Profile</title>
                    <meta name="description" content="Manage your ADIDIS profile." />

                    <link href="https://fonts.googleapis.com" rel="preconnect" />
                    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
                    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
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
                                <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase bg-primary text-on-primary font-bold active:scale-95 transition-transform"
                                    href="${pageContext.request.contextPath}/profile">
                                    <span class="material-symbols-outlined text-[20px]">manage_accounts</span>
                                    Profile
                                </a>
                                <c:choose>
                                    <c:when test="${sessionScope.currentUser.roleName eq 'Admin'}">
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/dashboard">
                                            <span class="material-symbols-outlined text-[20px]">dashboard</span>
                                            Dashboard
                                        </a>
                                    </c:when>
                                    <c:when test="${sessionScope.currentUser.roleName eq 'Staff'}">
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/staff/orders">
                                            <span class="material-symbols-outlined text-[20px]">dashboard</span>
                                            Dashboard
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/profile/orders">
                                            <span class="material-symbols-outlined text-[20px]">receipt_long</span>
                                            Orders
                                        </a>
                                        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase text-secondary hover:bg-surface-container-low transition-colors active:scale-95 transition-transform"
                                            href="${pageContext.request.contextPath}/profile/addresses">
                                            <span class="material-symbols-outlined text-[20px]">location_on</span>
                                            Addresses
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </nav>

                            <div class="px-4 py-6 border-t border-outline-variant/50 flex flex-col gap-4">

                                <div class="space-y-1">
                                    <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-DEFAULT transition-colors"
                                        href="${pageContext.request.contextPath}/home">
                                        <span class="material-symbols-outlined text-[18px]">arrow_back</span>
                                        Back to Shop
                                    </a>
                                    <a class="flex items-center gap-3 px-4 py-2 font-label-sm text-label-sm uppercase text-secondary hover:bg-surface-container-low rounded-DEFAULT transition-colors"
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
                                <h2 class="font-headline-lg text-headline-lg text-primary tracking-tight">Profile</h2>
                                <p class="font-body-md text-body-md text-secondary mt-2 max-w-lg">
                                    Manage your account details and addresses.
                                </p>
                            </div>
                            <div class="flex gap-4">
                            </div>
                        </header>

                        <section class="px-margin-desktop py-12 flex-1 max-w-5xl">
                            <!-- Flash Messages -->
                            <c:if test="${not empty sessionScope.successMessage}">
                                <div class="mb-8 p-4 bg-status-delivered-bg border border-status-delivered-text/20 text-status-delivered-text font-label-md flex items-center gap-3">
                                    <span class="material-symbols-outlined">check_circle</span>
                                    ${sessionScope.successMessage}
                                </div>
                                <c:remove var="successMessage" scope="session"/>
                            </c:if>
                            <c:if test="${not empty sessionScope.errorMessage}">
                                <div class="mb-8 p-4 bg-status-cancelled-bg border border-status-cancelled-text/20 text-status-cancelled-text font-label-md flex items-center gap-3">
                                    <span class="material-symbols-outlined">error</span>
                                    ${sessionScope.errorMessage}
                                </div>
                                <c:remove var="errorMessage" scope="session"/>
                            </c:if>

                            <!-- User Information -->
                            <div class="border border-outline-variant bg-surface p-8 mb-12 shadow-sm">
                                <h3
                                    class="font-headline-md text-headline-md uppercase tracking-tight mb-6 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[24px]">person</span>
                                    Account Info
                                </h3>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                                    <div>
                                        <p class="font-label-sm text-label-sm text-secondary uppercase mb-1">Full Name
                                        </p>
                                        <p class="font-body-lg text-body-lg font-bold">
                                            ${sessionScope.currentUser.fullName}</p>
                                    </div>
                                    <div>
                                        <p class="font-label-sm text-label-sm text-secondary uppercase mb-1">Email
                                            Address</p>
                                        <p class="font-body-lg text-body-lg font-bold">${sessionScope.currentUser.email}
                                        </p>
                                    </div>
                                </div>
                            </div>

                            <!-- Change Password -->
                            <div class="border border-outline-variant bg-surface p-8 mb-12 shadow-sm">
                                <h3 class="font-headline-md text-headline-md uppercase tracking-tight mb-6 flex items-center gap-2">
                                    <span class="material-symbols-outlined text-[24px]">lock</span>
                                    Security
                                </h3>
                                <form action="${pageContext.request.contextPath}/profile/change-password" method="POST" class="max-w-md space-y-6">
                                    <div>
                                        <label for="oldPassword" class="block font-label-md text-label-md text-primary uppercase mb-2">Current Password</label>
                                        <input type="password" id="oldPassword" name="oldPassword" required
                                            class="w-full bg-surface-container-lowest border border-outline-variant text-primary font-body-md text-body-md px-4 py-3 focus:ring-2 focus:ring-primary focus:border-primary transition-shadow placeholder:text-secondary/50 rounded-none"
                                            placeholder="Enter current password">
                                    </div>
                                    <div>
                                        <label for="newPassword" class="block font-label-md text-label-md text-primary uppercase mb-2">New Password</label>
                                        <input type="password" id="newPassword" name="newPassword" required minlength="6" pattern="(?=.*\d)(?=.*[A-Z]).{6,}" title="Must contain at least one uppercase letter and one number"
                                            class="w-full bg-surface-container-lowest border border-outline-variant text-primary font-body-md text-body-md px-4 py-3 focus:ring-2 focus:ring-primary focus:border-primary transition-shadow placeholder:text-secondary/50 rounded-none"
                                            placeholder="Enter new password">
                                        <p class="font-label-sm text-label-sm text-secondary mt-1">Must be at least 6 characters, contain 1 uppercase letter and 1 number.</p>
                                    </div>
                                    <div>
                                        <label for="confirmPassword" class="block font-label-md text-label-md text-primary uppercase mb-2">Confirm New Password</label>
                                        <input type="password" id="confirmPassword" name="confirmPassword" required minlength="6"
                                            class="w-full bg-surface-container-lowest border border-outline-variant text-primary font-body-md text-body-md px-4 py-3 focus:ring-2 focus:ring-primary focus:border-primary transition-shadow placeholder:text-secondary/50 rounded-none"
                                            placeholder="Confirm new password">
                                    </div>
                                    <button type="submit"
                                        class="w-full bg-primary text-on-primary font-label-md text-label-md uppercase tracking-widest py-4 hover:opacity-90 active:scale-[0.98] transition-all">
                                        Update Password
                                    </button>
                                </form>
                            </div>
                        </section>
                    </main>
                </body>

                </html>