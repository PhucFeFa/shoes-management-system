<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-gray-50">
    <div class="max-w-2xl mx-auto px-6 py-16 text-center">
        <div class="bg-white rounded-2xl shadow-xl p-10">
            <div class="w-24 h-24 mx-auto bg-green-100 rounded-full flex items-center justify-center mb-8">
                <svg xmlns="http://www.w3.org/2000/svg" class="w-12 h-12 text-green-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                </svg>
            </div>
            
            <h1 class="text-4xl font-bold text-black mb-4">Order Successfully Placed!</h1>
            <p class="text-gray-600 mb-8">Thank you for your purchase. We will contact you soon to confirm.</p>
            
            <div class="bg-gray-100 rounded-xl p-6 mb-8">
                <p class="text-sm text-gray-500">Order ID</p>
                <p class="text-2xl font-bold text-black">${orderId}</p>
            </div>
            
            <div class="flex flex-col items-center gap-4">

                
                <a href="${pageContext.request.contextPath}/profile/order/details?id=${orderId}" 
                   class="text-black hover:underline">
                    View order details →
                </a>
            </div>
        </div>
    </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp"/>