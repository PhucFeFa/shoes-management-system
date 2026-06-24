
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-gray-100">

    <div class="max-w-7xl mx-auto px-4 lg:px-8 py-8">

        <h1 class="text-3xl font-bold mb-8">
            Checkout
        </h1>

        <form action="${pageContext.request.contextPath}/place-order"
              method="post">

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

                <!-- LEFT -->
                <div class="lg:col-span-2 space-y-6">

                    <!-- ADDRESS -->
                    <div class="bg-white rounded-2xl shadow p-6">

                        <h2 class="text-xl font-semibold mb-4">
                            Shipping Address
                        </h2>

                        <select name="addressId"
                                class="w-full border rounded-lg p-3">

                            <c:forEach items="${addresses}" var="a">

                                <option value="${a.id}"
                                        ${defaultAddress.id == a.id ? 'selected' : ''}>

                                    ${a.addressLine},
                                    ${a.ward},
                                    ${a.district},
                                    ${a.city}

                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <!-- PRODUCTS -->
                    <div class="bg-white rounded-2xl shadow p-6">

                        <h2 class="text-xl font-semibold mb-6">
                            Order Items
                        </h2>

                        <div class="space-y-6">

                            <c:forEach items="${checkoutItems}" var="item">

                                <div class="flex gap-4 border-b pb-5">

                                    <img src="${item.imageUrl}"
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

                                            ${item.price}₫

                                        </div>

                                        <div class="text-sm text-gray-500 mt-2">

                                            Total:
                                            ${item.totalPrice}₫

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

                            <select id="voucherSelect"
                                    name="voucherId"
                                    class="w-full border rounded-lg p-3">

                                <option value=""
                                        data-percent="0">

                                    No Voucher

                                </option>

                                <c:forEach items="${vouchers}" var="v">

                                    <option value="${v.id}"
                                            data-percent="${v.discountPercent}">

                                        ${v.code}
                                        (-${v.discountPercent}%)

                                    </option>

                                </c:forEach>

                            </select>

                        </div>
                        <!-- Payment Method -->
                        <div class="mb-8">

                            <label class="block font-medium mb-2">
                                Payment Method
                            </label>

                            <select name="paymentMethod"
                                    class="w-full border rounded-lg p-3">

                                <option value="cod">
                                    Cash On Delivery (COD)
                                </option>

                                <option value="vnpay">
                                    VNPay
                                </option>

                            </select>

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

                                        Shipping

                                    </span>

                                    <span id="shippingDisplay">

                                        ${shippingFee}

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

                                        ${finalTotal}

                                    </span>

                                </div>

                            </div>

                            <input type="hidden"
                                   name="finalAmount"
                                   id="finalAmountInput"
                                   value="${finalTotal}">

                            <button type="submit"
                                    class="w-full mt-6 bg-black text-white py-3 rounded-xl hover:bg-gray-800 transition">

                                Place Order

                            </button>
                            <a href="${pageContext.request.contextPath}/Cart"
                               class="block w-full mt-3 text-center border border-black py-3 rounded-xl hover:bg-gray-100 transition">

                                Back To Cart

                            </a>

                        </div>

                    </div>

                </div>

        </form>

    </div>
    <script>

        const subtotal =
                Number("${subTotal}");

        const shipping =
                Number("${shippingFee}");

        const voucherSelect =
                document.getElementById("voucherSelect");

        const discountDisplay =
                document.getElementById("discountDisplay");

        const totalDisplay =
                document.getElementById("totalDisplay");

        const finalAmountInput =
                document.getElementById("finalAmountInput");

        voucherSelect.addEventListener("change", function () {

            const percent =
                    Number(
                            this.options[this.selectedIndex]
                            .dataset.percent
                            );

            const discount =
                    subtotal * percent / 100;

            let total =
                    subtotal + shipping - discount;

            if (total < 0) {
                total = 0;
            }

            discountDisplay.innerText =
                    discount.toLocaleString('vi-VN') + "₫";

            totalDisplay.innerText =
                    total.toLocaleString('vi-VN') + "₫";

            finalAmountInput.value =
                    total;
        });

    </script>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp"/>

