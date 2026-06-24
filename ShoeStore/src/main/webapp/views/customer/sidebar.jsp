<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<aside class="fixed left-0 top-0 h-full w-64 border-r border-outline-variant bg-surface flex flex-col py-base z-40">
    <div class="px-6 py-8 border-b border-outline-variant/50">
        <a href="${pageContext.request.contextPath}/home">
            <h1 class="font-headline-md text-headline-md font-bold text-primary tracking-tighter uppercase">ADIDIS</h1>
        </a>
        <p class="font-label-sm text-label-sm text-secondary mt-1">My Account</p>
    </div>

    <nav class="flex-1 px-4 py-6 space-y-2 overflow-y-auto">
        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'profile' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="${pageContext.request.contextPath}/profile">
            <span class="material-symbols-outlined text-[20px]">manage_accounts</span>
            Profile
        </a>
        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'orders' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="${pageContext.request.contextPath}/profile/orders">
            <span class="material-symbols-outlined text-[20px]">receipt_long</span>
            Orders
        </a>
        <a class="flex items-center gap-3 px-4 py-3 rounded-DEFAULT font-label-md text-label-md uppercase active:scale-95 transition-transform ${param.activePage == 'address' ? 'bg-primary text-on-primary font-bold' : 'text-secondary hover:bg-surface-container-low transition-colors'}"
           href="${pageContext.request.contextPath}/Address">
            <span class="material-symbols-outlined text-[20px]">location_on</span>
            Addresses
        </a>
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
