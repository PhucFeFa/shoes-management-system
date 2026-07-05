<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">

<div class="w-[256px] h-screen fixed top-0 left-0 bg-[#f9f9f9] border-r border-[#e2e2e2] flex flex-col py-2 font-['Inter',sans-serif] z-[1000]">
    <div class="px-6 py-8 border-b border-[#e2e2e2]/50">
        <div class="text-[24px] font-bold tracking-[-0.02em] text-black uppercase">ADIDIS</div>
        <div class="text-[12px] text-[#5d5f5f] mt-1 font-medium">Staff Panel</div>
    </div>

    <ul class="list-none m-0 px-4 py-6 flex-1 flex flex-col gap-2">
        <li>
            <a href="${pageContext.request.contextPath}/staff/dashboard"
               class="flex items-center gap-3 px-4 py-3 text-[14px] font-semibold uppercase rounded transition-all duration-150 ${activePage eq 'dashboard' ? 'bg-black text-white font-bold' : 'text-[#5d5f5f] hover:text-black hover:bg-[#f3f3f4]'}">
                <span class="material-symbols-outlined text-[20px]">dashboard</span>
                <span>Dashboard</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/staff/orders"
               class="flex items-center gap-3 px-4 py-3 text-[14px] font-semibold uppercase rounded transition-all duration-150 ${activePage eq 'orders' ? 'bg-black text-white font-bold' : 'text-[#5d5f5f] hover:text-black hover:bg-[#f3f3f4]'}">
                <span class="material-symbols-outlined text-[20px]">local_shipping</span>
                <span>Orders</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/staff/manage-reviews"
               class="flex items-center gap-3 px-4 py-3 text-[14px] font-semibold uppercase rounded transition-all duration-150 ${activePage eq 'reviews' ? 'bg-black text-white font-bold' : 'text-[#5d5f5f] hover:text-black hover:bg-[#f3f3f4]'}">
                <span class="material-symbols-outlined text-[20px]">rate_review</span>
                <span>Reviews</span>
            </a>
        </li>
    </ul>

    <div class="px-4 py-6 border-t border-[#e2e2e2]/50">
        <form action="${pageContext.request.contextPath}/home" method="GET" class="m-0 w-full">
            <button type="submit" class="w-full text-left flex items-center gap-3 cursor-pointer px-4 py-2 text-[12px] font-medium uppercase text-[#5d5f5f] rounded transition-colors duration-150 hover:text-black hover:bg-[#f3f3f4] bg-transparent border-none">
                <span class="material-symbols-outlined text-[18px]">home</span>
                <span>Back to Website</span>
            </button>
        </form>
    </div>
</div>
