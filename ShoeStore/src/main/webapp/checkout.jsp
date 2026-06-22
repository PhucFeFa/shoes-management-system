<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-gray-50">

    ```
    <section class="max-w-7xl mx-auto px-6 lg:px-12 py-8">

        <div class="mb-8">
            <h1 class="text-4xl font-bold uppercase tracking-wide">
                Checkout
            </h1>
            <p class="text-gray-500 mt-2">
                Review your order before placing it.
            </p>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

            <!-- Product List -->
            <div class="lg:col-span-2">

                <div class="bg-white rounded-xl border p-6">

                    <h2 class="text-2xl font-bold mb-6">
                        Selected Products
                    </h2>

                    <c:if test="${empty checkoutItems}">
                        <div class="text-center py-10">

                            <p class="text-gray-500 mb-4">
                                No products selected.
                            </p>

                            <a href="${pageContext.request.contextPath}/cart"
                               class="inline-block px-6 py-3 bg-black text-white rounded-lg">
                                Back To Cart
                            </a>

                        </div>
                    </c:if>

                    <c:set var="total" value="0"/>

                    <c:forEach var="item" items="${checkoutItems}">

                        <c:set var="total"
                               value="${total + (item.price * item.quantity)}"/>

                        <div class="border rounded-xl p-5 mb-4">

                            <div class="flex flex-col md:flex-row gap-5">

                                <!-- Product Image -->
                                <div class="w-full md:w-32 h-32 bg-gray-100 rounded-lg overflow-hidden">

                                    <img src="${item.imageUrl}"
                                         alt="${item.productName}"
                                         class="w-full h-full object-cover">

                                </div>

                                <!-- Product Info -->
                                <div class="flex-1">

                                    <h3 class="text-xl font-bold uppercase">
                                        ${item.productName}
                                    </h3>

                                    <div class="mt-4 flex flex-wrap gap-8">

                                        <div>
                                            <span class="text-sm text-gray-500">
                                                Price
                                            </span>

                                            <p class="font-semibold">
                                                $${item.price}
                                            </p>
                                        </div>

                                        <div>
                                            <span class="text-sm text-gray-500">
                                                Quantity
                                            </span>

                                            <p class="font-semibold">
                                                ${item.quantity}
                                            </p>
                                        </div>

                                        <div>
                                            <span class="text-sm text-gray-500">
                                                Subtotal
                                            </span>

                                            <p class="font-bold text-lg">
                                                $${item.price * item.quantity}
                                            </p>
                                        </div>

                                    </div>

                                </div>

                                <!-- Remove -->
                                <div>

                                    <form action="${pageContext.request.contextPath}/remove-checkout-item"
                                          method="post">

                                        <input type="hidden"
                                               name="variantId"
                                               value="${item.productVariantId}">

                                        

                                    </form>

                                </div>

                            </div>

                        </div>

                    </c:forEach>

                </div>

            </div>

            <!-- Summary -->
            <div>

                <div class="bg-white border rounded-xl p-6 sticky top-24">

                    <h2 class="text-2xl font-bold mb-6 uppercase">
                        Order Summary
                    </h2>

                    <c:set var="subTotal" value="0"/>

                    <c:forEach var="item" items="${checkoutItems}">
                        <c:set var="subTotal"
                               value="${subTotal + (item.price * item.quantity)}"/>
                    </c:forEach>

                    <div class="space-y-4">
                        <div class="flex justify-between">
                            <span>Subtotal</span>
                            <span id="subTotalAmount">
                                ${subTotal}
                            </span>
                        </div>

                        <div class="flex justify-between">
                            <span>Shipping</span>
                            <span>
                                30000
                            </span>
                        </div>

                        <div class="flex justify-between">
                            <span>Discount</span>
                            <span id="discountAmount">
                                0
                            </span>
                        </div>

                        <hr>

                        <div class="flex justify-between text-xl font-bold">
                            <span>Total</span>
                            <span id="finalTotal">
                                ${subTotal + 30000}
                            </span>
                        </div>

                    </div>

                    <!-- Shipping Address -->
                    <div class="mt-8">

                        <label class="block mb-2 font-semibold">
                            Shipping Address
                        </label>

                        <select name="addressId"
                                form="placeOrderForm"
                                class="w-full border rounded-lg p-3">

                            <c:forEach var="address" items="${addresses}">

                                <option value="${address.id}">

                                    ${address.addressLine},
                                    ${address.ward},
                                    ${address.district},
                                    ${address.city}

                                </option>

                            </c:forEach>

                        </select>

                    </div>
                    <div class="mt-6">

                        <label class="font-semibold block mb-2">
                            Voucher
                        </label>

                        <select id="voucherSelect"
                                name="voucherId"
                                form="placeOrderForm"
                                class="w-full border rounded-lg p-3">

                            <option value="">
                                No Voucher
                            </option>

                            <c:forEach var="v"
                                       items="${vouchers}">

                                <option
                                    value="${v.id}"
                                    data-discount="${v.discountPercent}">

                                    ${v.code}
                                    (-${v.discountPercent}%)

                                </option>

                            </c:forEach>

                        </select>

                    </div>

                    <!-- Payment -->
                    <div class="mt-6">

                        <label class="block mb-2 font-semibold">
                            Payment Method
                        </label>

                        <select name="paymentMethod"
                                form="placeOrderForm"
                                class="w-full border rounded-lg p-3">

                            <option value="cod">
                                Cash On Delivery (COD)
                            </option>

                        </select>

                    </div>

                    <!-- Place Order -->
                    <form id="placeOrderForm"
                          action="${pageContext.request.contextPath}/place-order"
                          method="post">
                        <input type="hidden"
                               name="finalAmount"
                               id="finalAmountInput">

                        <input type="hidden"
                               name="voucherId"
                               id="voucherIdInput">
                        <button type="submit"
                                class="block w-full mt-8 text-center bg-black text-white py-4 uppercase tracking-wider hover:bg-gray-800 transition rounded-lg">
                            Place Order
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/Cart"
                       class="block w-full mt-3 text-center border py-4 uppercase tracking-wider hover:bg-gray-50 transition rounded-lg">

                        Back To Cart

                    </a>

                </div>

            </div>

        </div>

    </section>
    <script>

        document.addEventListener("DOMContentLoaded", function () {

            const subtotal =
                    Number("${subTotal}");

            const shipping =
                    30000;

            const voucherSelect =
                    document.getElementById("voucherSelect");

            const discountText =
                    document.getElementById("discountAmount");

            const totalText =
                    document.getElementById("finalTotal");

            const finalAmountInput =
                    document.getElementById("finalAmountInput");

            function calculateTotal() {

                let discountPercent = 0;

                const selected =
                        voucherSelect.options[
                                voucherSelect.selectedIndex];

                if (selected.dataset.discount) {

                    discountPercent =
                            Number(selected.dataset.discount);
                }

                const discountAmount =
                        subtotal * discountPercent / 100;

                const finalTotal =
                        subtotal + shipping - discountAmount;

                discountText.innerHTML =
                        discountAmount.toLocaleString();

                totalText.innerHTML =
                        finalTotal.toLocaleString();

                finalAmountInput.value =
                        finalTotal;
            }

            voucherSelect.addEventListener(
                    "change",
                    calculateTotal);

            calculateTotal();

        });
        voucherSelect.addEventListener("change", function () {

            document.getElementById("voucherIdInput").value =
                    this.value;

        });

    </script>

</main>

<jsp:include page="/WEB-INF/include/footer.jsp"/>
