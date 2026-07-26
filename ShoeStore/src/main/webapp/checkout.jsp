
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-gray-100">

    <div class="max-w-7xl mx-auto px-4 lg:px-8 py-8">

        <h1 class="text-3xl font-bold mb-8">
            Checkout
        </h1>

        <c:if test="${not empty sessionScope.error}">
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4 text-center">
                ${sessionScope.error}
            </div>
            <c:remove var="error" scope="session"/>
        </c:if>

        <form action="${pageContext.request.contextPath}/place-order" method="post">

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <!-- LEFT -->
                <div class="lg:col-span-2 space-y-6">

                    <!-- ADDRESS -->
                    <div class="bg-white rounded-2xl shadow p-6">

                        <h2 class="text-xl font-semibold mb-4">
                            Shipping Address
                        </h2>

                        <c:choose>
                            <c:when test="${empty addresses}">
                                <a href="${pageContext.request.contextPath}/profile/addresses" class="w-full border rounded-lg p-4 text-left flex justify-between items-center bg-red-50 hover:bg-red-100 transition outline-none block text-red-600 border-red-200">
                                    <span class="truncate font-semibold text-sm">No addresses found. Click here to add a new address.</span>
                                    <span class="material-symbols-outlined">add_location</span>
                                </a>
                                <input type="hidden" name="addressId" id="addressIdInput" value="">
                            </c:when>
                            <c:otherwise>
                                <div class="relative" id="addressDropdown">
                                    <input type="hidden" name="addressId" id="addressIdInput" value="${defaultAddress.id}">
                                    <button type="button" class="dropdown-btn w-full border rounded-lg p-3 text-left flex justify-between items-center bg-white hover:border-gray-400 transition outline-none">
                                        <span class="dropdown-label truncate text-gray-700">
                                            ${defaultAddress.addressLine}, ${defaultAddress.ward}, ${defaultAddress.district}, ${defaultAddress.city}
                                        </span>
                                        <span class="material-symbols-outlined text-gray-400 dropdown-icon transition-transform">expand_more</span>
                                    </button>
                                    
                                    <ul class="dropdown-menu absolute z-50 w-full mt-2 bg-white border rounded-xl shadow-lg max-h-64 overflow-y-auto hidden">
                                        <c:forEach items="${addresses}" var="a">
                                            <li class="dropdown-item p-4 hover:bg-gray-50 cursor-pointer transition border-b last:border-b-0"
                                                data-value="${a.id}"
                                                data-label="${a.addressLine}, ${a.ward}, ${a.district}, ${a.city}">
                                                <div class="font-semibold text-gray-800">${a.addressLine}</div>
                                                <div class="text-sm text-gray-500 mt-1">${a.ward}, ${a.district}, ${a.city}</div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>

                    <!-- PRODUCTS -->
                    <div class="bg-white rounded-2xl shadow p-6">

                        <h2 class="text-xl font-semibold mb-6">
                            Order Items
                        </h2>

                        <div class="space-y-6">

                            <c:forEach items="${checkoutItems}" var="item">

                                <div class="flex gap-4 border-b pb-5">

                                    <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${empty item.imageUrl ? pageContext.request.contextPath.concat('/assets/fallback.png') : item.imageUrl}"
                                         alt="${item.productName}"
                                         class="w-24 h-24 object-cover rounded-lg border">

                                    <div class="flex-1">

                                        <h3 class="font-semibold text-lg">
                                            ${item.productName}
                                        </h3>

                                        <div class="text-gray-500 mt-1">

                                            <c:if test="${not empty item.size}">
                                                Size: ${item.size}
                                            </c:if>

                                            <c:if test="${not empty item.color}">
                                                Color: ${item.color}
                                            </c:if>

                                        </div>

                                        <div class="mt-2 text-gray-600">
                                            Quantity: ${item.quantity}
                                        </div>

                                    </div>

                                    <div class="text-right">

                                        <div class="font-bold text-red-500">
                                            <fmt:formatNumber value="${item.price}" pattern="#,##0"/>₫
                                        </div>
                                        <div class="text-sm text-gray-500 mt-2">
                                            Total:
                                            <fmt:formatNumber value="${item.totalPrice}" pattern="#,##0"/>₫
                                        </div>

                                    </div>

                                </div>

                            </c:forEach>

                        </div>

                    </div>

                </div>

                <!-- RIGHT -->
                <div>

                    <div class="bg-white rounded-2xl shadow p-6 sticky top-28">

                        <h2 class="text-xl font-semibold mb-6">
                            Order Summary
                        </h2>

                        <!-- Voucher -->

                        <div class="mb-4">

                            <label class="block font-medium mb-2">

                                Voucher

                            </label>

                            <div class="relative" id="voucherDropdown">
                                <input type="hidden" name="voucherId" id="voucherIdInput" value="">
                                <button type="button" 
                                        ${empty addresses ? 'disabled' : ''}
                                        class="dropdown-btn w-full border rounded-lg p-3 text-left flex justify-between items-center transition outline-none 
                                        ${empty addresses ? 'bg-gray-100 text-gray-400 cursor-not-allowed' : 'bg-white hover:border-gray-400'}">
                                    <span class="dropdown-label truncate ${empty addresses ? 'text-gray-400' : 'text-gray-700'}">No Voucher</span>
                                    <span class="material-symbols-outlined text-gray-400 dropdown-icon transition-transform">expand_more</span>
                                </button>
                                
                                <ul class="dropdown-menu absolute z-50 w-full mt-2 bg-white border rounded-xl shadow-lg max-h-64 overflow-y-auto hidden">
                                    <li class="dropdown-item p-4 hover:bg-gray-50 cursor-pointer transition border-b"
                                        data-value=""
                                        data-label="No Voucher"
                                        data-percent="0">
                                        <div class="font-semibold text-gray-800">No Voucher</div>
                                    </li>
                                    <c:forEach items="${vouchers}" var="v">
                                        <li class="dropdown-item p-4 hover:bg-gray-50 cursor-pointer transition border-b last:border-b-0 flex justify-between items-center"
                                            data-value="${v.id}"
                                            data-label="${v.code} (-${v.discountValue}%)"
                                            data-percent="${v.discountValue}">
                                            <div>
                                                <div class="font-bold text-gray-900">${v.code}</div>
                                                <div class="text-xs text-gray-500 mt-1">Limited quantity</div>
                                            </div>
                                            <div class="text-sm font-semibold text-green-600 bg-green-50 px-2 py-1 rounded">-${v.discountValue}%</div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>

                        </div>


                            <!-- Summary -->

                            <div class="space-y-4">

                                <div class="flex justify-between">

                                    <span class="text-gray-600">

                                        Subtotal

                                    </span>

                                    <span id="subtotalDisplay">

                                        ${subTotal}

                                    </span>

                                </div>



                                <div class="flex justify-between">

                                    <span class="text-gray-600">

                                        Discount

                                    </span>

                                    <span id="discountDisplay">

                                        0₫

                                    </span>

                                </div>

                                <hr>

                                <div class="flex justify-between text-xl font-bold">

                                    <span>

                                        Total

                                    </span>

                                    <span id="totalDisplay">
                                        <fmt:formatNumber value="${subTotal}" pattern="#,##0"/>
                                    </span>

                                </div>

                            </div>

                            <input type="hidden"
                                   name="finalAmount"
                                   id="finalAmountInput"
                                   value="${subTotal}">

                            <button type="submit"
                                    ${empty addresses ? 'disabled' : ''}
                                    class="w-full mt-6 bg-black text-white py-3 rounded-xl transition ${empty addresses ? 'opacity-50 cursor-not-allowed' : 'hover:bg-gray-800'}">

                                Place Order

                            </button>
                            <c:if test="${empty addresses}">
                                <p class="text-red-500 text-sm text-center mt-3">Please add a shipping address in your profile to continue.</p>
                            </c:if>


                    </div>

                </div>

        </form>

    </div>
    <script>

        const subtotal =
                Number("${subTotal}");



        const discountDisplay = document.getElementById("discountDisplay");
        const totalDisplay = document.getElementById("totalDisplay");
        const finalAmountInput = document.getElementById("finalAmountInput");

        // Universal Custom Dropdown Logic
        document.addEventListener('click', function(e) {
            // Close all dropdowns if clicked outside
            if (!e.target.closest('.relative')) {
                document.querySelectorAll('.dropdown-menu').forEach(menu => {
                    menu.classList.add('hidden');
                    menu.previousElementSibling.querySelector('.dropdown-icon').classList.remove('rotate-180');
                });
            }
        });

        document.querySelectorAll('.relative').forEach(dropdown => {
            const btn = dropdown.querySelector('.dropdown-btn');
            const menu = dropdown.querySelector('.dropdown-menu');
            const label = dropdown.querySelector('.dropdown-label');
            const icon = dropdown.querySelector('.dropdown-icon');
            const input = dropdown.querySelector('input[type="hidden"]');
            
            if(!btn || !menu) return;

            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                // Close others
                document.querySelectorAll('.dropdown-menu').forEach(m => {
                    if (m !== menu) {
                        m.classList.add('hidden');
                        m.previousElementSibling.querySelector('.dropdown-icon').classList.remove('rotate-180');
                    }
                });

                // Toggle current
                if (menu.classList.contains('hidden')) {
                    menu.classList.remove('hidden');
                    icon.classList.add('rotate-180');
                } else {
                    menu.classList.add('hidden');
                    icon.classList.remove('rotate-180');
                }
            });

            menu.querySelectorAll('.dropdown-item').forEach(item => {
                item.addEventListener('click', (e) => {
                    e.stopPropagation();
                    const val = item.getAttribute('data-value');
                    const text = item.getAttribute('data-label');
                    
                    label.textContent = text;
                    input.value = val;
                    
                    // Close menu
                    menu.classList.add('hidden');
                    icon.classList.remove('rotate-180');

                    // Trigger voucher change if it's the voucher dropdown
                    if(dropdown.id === 'voucherDropdown') {
                        const percent = Number(item.getAttribute('data-percent') || 0);
                        const discount = subtotal * percent / 100;
                        let total = subtotal - discount;
                        if (total < 0) total = 0;

                        discountDisplay.innerText = discount.toLocaleString('vi-VN') + "₫";
                        totalDisplay.innerText = total.toLocaleString('vi-VN') + "₫";
                        finalAmountInput.value = total;
                    }
                });
            });
        });

    </script>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp"/>



