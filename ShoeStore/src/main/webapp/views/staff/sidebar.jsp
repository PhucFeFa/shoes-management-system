<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'dashboard' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="${pageContext.request.contextPath}/home">
            <span class="material-symbols-outlined text-[20px]">dashboard</span>
            Dashboard
        </a>
        <!-- Orders -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'orders' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="${pageContext.request.contextPath}/staff/orders">
            <span class="material-symbols-outlined text-[20px]">shopping_cart</span>
            Orders
        </a>
        <!-- Inventory -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'inventory' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="#">
            <span class="material-symbols-outlined text-[20px]">inventory_2</span>
            Inventory
        </a>
        <!-- Customers -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'customers' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="#">
            <span class="material-symbols-outlined text-[20px]">group</span>
            Customers
        </a>
        <!-- Settings -->
        <a class="flex items-center gap-3 px-4 py-3 rounded-lg font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'settings' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
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
