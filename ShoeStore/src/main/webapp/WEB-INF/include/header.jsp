<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="scroll-smooth" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>ADIDIS | ENGINEERED SPEED</title>
        <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&amp;display=swap"
              rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
            rel="stylesheet" />

        <script id="tailwind-config">
            tailwind.config = {
                darkMode: "class",
                theme: {
                    extend: {
                        "colors": {
                            "surface-container-lowest": "#ffffff",
                            "primary-fixed": "#e2e2e2",
                            "on-surface-variant": "#4c4546",
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
                        "borderRadius": {
                            "DEFAULT": "0.25rem",
                            "lg": "0.5rem",
                            "xl": "0.75rem",
                            "full": "9999px"
                        },
                        "spacing": {
                            "margin-mobile": "20px",
                            "margin-desktop": "64px",
                            "margin-tablet": "32px",
                            "gutter": "24px",
                            "base": "8px",
                            "container-max": "1440px"
                        },
                        "fontFamily": {
                            "label-md": ["Inter"],
                            "display-lg": ["Inter"],
                            "label-sm": ["Inter"],
                            "headline-md": ["Inter"],
                            "body-md": ["Inter"],
                            "headline-lg": ["Inter"],
                            "display-lg-mobile": ["Inter"],
                            "body-lg": ["Inter"]
                        },
                        "fontSize": {
                            "label-md": ["14px", {"lineHeight": "1.0", "letterSpacing": "0.05em", "fontWeight": "600"}],
                            "display-lg": ["72px", {"lineHeight": "1.1", "letterSpacing": "-0.04em", "fontWeight": "800"}],
                            "label-sm": ["12px", {"lineHeight": "1.0", "letterSpacing": "0", "fontWeight": "500"}],
                            "headline-md": ["24px", {"lineHeight": "1.3", "letterSpacing": "-0.01em", "fontWeight": "600"}],
                            "body-md": ["16px", {"lineHeight": "1.5", "letterSpacing": "0", "fontWeight": "400"}],
                            "headline-lg": ["32px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "700"}],
                            "display-lg-mobile": ["40px", {"lineHeight": "1.2", "letterSpacing": "-0.02em", "fontWeight": "800"}],
                            "body-lg": ["18px", {"lineHeight": "1.6", "letterSpacing": "0", "fontWeight": "400"}]
                        }
                    },
                },
            }
        </script>
        <style>
            .material-symbols-outlined {
                font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
            }

            .no-scrollbar::-webkit-scrollbar {
                display: none;
            }

            .no-scrollbar {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }

            .product-card:hover .add-to-cart-btn {
                opacity: 1;
                transform: translateY(0);
            }
        </style>
    </head>

    <body class="bg-background text-on-background font-body-md selection:bg-primary selection:text-on-primary">

        <!-- TopNavBar -->
        <header class="fixed top-0 w-full z-50 bg-surface/80 dark:bg-surface/80 backdrop-blur-xl">
            <nav
                class="flex justify-between items-center px-margin-mobile md:px-margin-desktop h-16 w-full max-w-container-max mx-auto">
                <div class="flex items-center gap-8">
                    <a class="text-headline-md font-headline-md font-extrabold tracking-tighter text-primary dark:text-on-surface"
                       href="${pageContext.request.contextPath}/home">ADIDIS</a>
                    <div class="hidden md:flex gap-6">
                        <a class="text-label-md font-label-md uppercase text-primary dark:text-on-surface border-b-2 border-primary dark:border-on-surface pb-1"
                           href="${pageContext.request.contextPath}/home">SHOP</a>
                        <a class="text-label-md font-label-md uppercase text-secondary dark:text-on-surface-variant hover:opacity-90 transition-opacity"
                           href="#">NEW ARRIVALS</a>
                        <a class="text-label-md font-label-md uppercase text-secondary dark:text-on-surface-variant hover:opacity-90 transition-opacity"
                           href="#">LABS</a>
                        <a class="text-label-md font-label-md uppercase text-secondary dark:text-on-surface-variant hover:opacity-90 transition-opacity"
                           href="#">COLLECTIONS</a>
                    </div>
                </div>
                <div class="flex items-center gap-4">
                    <div
                        class="hidden lg:flex items-center bg-surface-container rounded-full px-4 py-2 gap-2 w-64 group focus-within:ring-1 ring-outline">
                        <span class="material-symbols-outlined text-on-surface-variant">search</span>
                        <input class="bg-transparent border-none focus:ring-0 text-label-sm w-full outline-none"
                               placeholder="Search sneakers..." type="text" />
                    </div>
                    <a href="${pageContext.request.contextPath}/Cart"
                       class="relative text-primary hover:opacity-90 transition-opacity active:scale-95 flex items-center">
                        <span class="material-symbols-outlined">shopping_cart</span>
                        <c:set var="cartCount" value="0"/>
                        <c:if test="${not empty sessionScope.currentUser}">
                            <%
                                try {
                                    com.mycompany.shoestore.models.User u = (com.mycompany.shoestore.models.User) session.getAttribute("currentUser");
                                    com.mycompany.shoestore.dao.CartDAO headerCartDao = new com.mycompany.shoestore.dao.CartDAO();
                                    java.util.List<com.mycompany.shoestore.models.CartItem> hc = headerCartDao.getCart(u.getId());
                                    int totalItems = 0;
                                    for(com.mycompany.shoestore.models.CartItem ci : hc) {
                                        totalItems += ci.getQuantity();
                                    }
                                    pageContext.setAttribute("cartCount", totalItems);
                                } catch(Exception e) {}
                            %>
                        </c:if>
                        <c:if test="${cartCount > 0}">
                            <span class="absolute -top-1.5 -right-2 bg-error text-white text-[10px] font-bold px-1.5 py-0.5 rounded-full">${cartCount}</span>
                        </c:if>
                    </a>

                    <c:if test="${empty sessionScope.currentUser}">
                        <a href="${pageContext.request.contextPath}/login" class="text-label-md font-label-md uppercase text-primary hover:opacity-80">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="bg-primary text-on-primary px-4 py-2 rounded-full text-label-md font-label-md uppercase hover:bg-primary/90 transition-colors">Signup</a>
                    </c:if>

                    <c:if test="${not empty sessionScope.currentUser}">
                        <a href="profile" class="relative group cursor-pointer block mt-1">
                            <span class="material-symbols-outlined text-[32px] text-primary">account_circle</span>
                        </a>

                        <form action="Logout" method="get">
                            <button
                                class="material-symbols-outlined text-primary hover:opacity-90 transition-opacity active:scale-95 flex items-center justify-center"
                                title="Logout">logout</button>
                        </form>
                    </c:if>
                    <button class="md:hidden material-symbols-outlined text-primary">menu</button>

                </div>
            </nav>
        </header>