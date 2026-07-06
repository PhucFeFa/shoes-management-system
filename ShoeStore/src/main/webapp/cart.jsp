<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-surface">

    <!-- Header -->
    <section class="max-w-7xl mx-auto px-6 lg:px-12 mb-12">
        <div class="border-b border-gray-200 pb-6">
            <h1 class="text-4xl font-bold tracking-wide uppercase text-black">
                Shopping Cart
            </h1>
            <p class="text-gray-500 mt-2">
                Review your selected products before checkout.
            </p>
        </div>
    </section>

    <!-- Empty Cart -->
    <c:if test="${empty cart}">
        <section class="max-w-4xl mx-auto px-6">
            <div class="bg-gray-50 rounded-xl p-12 text-center border">

                <svg xmlns="http://www.w3.org/2000/svg"
                     class="w-20 h-20 mx-auto text-gray-300 mb-6"
                     fill="none"
                     viewBox="0 0 24 24"
                     stroke="currentColor">
                    <path stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="1.5"
                          d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-1.2 6M17 13l1.2 6M9 19a1 1 0 100 2 1 1 0 000-2zm8 0a1 1 0 100 2 1 1 0 000-2z"/>
                </svg>

                <h2 class="text-2xl font-bold mb-3">
                    Your cart is empty
                </h2>

                <p class="text-gray-500 mb-8">
                    Looks like you haven't added any products yet.
                </p>

                <a href="${pageContext.request.contextPath}/products"
                   class="inline-flex items-center px-8 py-4 bg-black text-white uppercase tracking-wider hover:bg-gray-800 transition">
                    Continue Shopping
                </a>
            </div>
        </section>
    </c:if>

    <!-- Cart Items -->
    <c:if test="${not empty cart}">

        <section class="max-w-7xl mx-auto px-6 lg:px-12">

            <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">

                <!-- Left -->
                <div class="lg:col-span-2 space-y-5">

                    <c:set var="grandTotal" value="0"/>

                    <c:forEach var="item" items="${cart}">
                        <c:if test="${item.quantity <= 0}">
                            <span class="text-red-500 font-bold">
                                Out Of Stock
                            </span>
                        </c:if>


                        <div class="border rounded-xl p-5 hover:shadow-lg transition">

                            <div class="flex flex-col md:flex-row gap-5">

                                <!-- Select product checkbox -->
                                <div class="flex items-center">
                                    <input type="checkbox"
                                           class="cart-checkbox w-5 h-5"
                                           name="selectedItems"
                                           value="${item.productVariantId}"
                                           data-price="${item.price}"
                                           data-qty="${item.quantity}"
                                           checked>
                                </div>


                                <!-- Image -->
                                <div class="w-full md:w-32 h-32 bg-gray-100 rounded-lg overflow-hidden">

                                    <img src="${item.imageUrl}"
                                         alt="${item.productName}"
                                         class="w-full h-full object-cover">

                                </div>

                                <!-- Info -->
                                <div class="flex-1">

                                    <h3 class="text-xl font-bold uppercase">
                                        ${item.productName}
                                    </h3>
                                    <div class="flex gap-4 mt-2 text-sm text-gray-600">

                                        <span>
                                            Size:
                                            <strong>${item.size}</strong>
                                        </span>

                                        <span>
                                            Color:
                                            <strong>${item.color}</strong>
                                        </span>

                                    </div>

                                    <p class="text-gray-500 mt-1">
                                        Premium Sneaker Collection
                                    </p>

                                    <div class="mt-4 flex flex-wrap gap-8">

                                        <div>
                                            <span class="text-gray-500 text-sm">
                                                Price
                                            </span>

                                            <p class="font-semibold">
                                                <fmt:formatNumber value="${item.price}" type="number" maxFractionDigits="0"/> đ
                                            </p>
                                        </div>

                                        <div>
                                            <span class="text-gray-500 text-sm">
                                                Quantity
                                            </span>

                                            <div class="flex items-center mt-2 border rounded-lg overflow-hidden w-fit">

                                                <!-- Decrease button -->
                                                <form action="UpdateCart" method="post">
                                                    <input type="hidden"
                                                           name="variantId"
                                                           value="${item.productVariantId}">

                                                        <input type="hidden"
                                                               name="action"
                                                               value="decrease">

                                                            <button type="submit"
                                                                    class="w-10 h-10 bg-white hover:bg-gray-100 text-lg font-bold transition">
                                                                -
                                                            </button>
                                                            </form>

                                                            <!-- Quantity -->
                                                            <div class="w-14 h-10 flex items-center justify-center font-semibold border-x">
                                                                ${item.quantity}
                                                            </div>

                                                            <!-- Increase button -->
                                                            <form action="UpdateCart" method="post">
                                                                <input type="hidden"
                                                                       name="variantId"
                                                                       value="${item.productVariantId}">

                                                                    <input type="hidden"
                                                                           name="action"
                                                                           value="increase">

                                                                        <button type="submit"
                                                                                class="w-10 h-10 bg-white hover:bg-gray-100 text-lg font-bold transition">
                                                                            +
                                                                        </button>
                                                                        </form>

                                                                        </div>
                                                                        </div>

                                                                        <div>
                                                                            <span class="text-gray-500 text-sm">
                                                                                Total
                                                                            </span>

                                                                            <p class="font-bold text-lg">
                                                                                <fmt:formatNumber value="${item.price * item.quantity}" type="number" maxFractionDigits="0"/> đ
                                                                            </p>
                                                                        </div>

                                                                        </div>

                                                                        </div>

                                                                        <!-- Remove -->
                                                                        <div class="flex items-start">

                                                                            <form action="RemoveCart"
                                                                                  method="post">

                                                                                <input type="hidden"
                                                                                       name="variantId"
                                                                                       value="${item.productVariantId}">

                                                                                    <button type="submit"
                                                                                            class="px-4 py-2 border border-red-500 text-red-500 hover:bg-red-500 hover:text-white transition rounded-lg">
                                                                                        Remove
                                                                                    </button>

                                                                            </form>

                                                                        </div>

                                                                        </div>

                                                                        </div>

                                                                    </c:forEach>

                                                                    </div>

                                                                    <!-- Right Summary -->
                                                                    <div>

                                                                        <div class="border rounded-xl p-6 sticky top-24">

                                                                            <h2 class="text-2xl font-bold mb-6 uppercase">
                                                                                Order Summary
                                                                            </h2>

                                                                            <div class="space-y-4">

                                                                                <div class="flex justify-between">
                                                                                    <span>Products</span>
                                                                                    <span>${cart.size()}</span>
                                                                                </div>



                                                                                <hr>

                                                                                    <!-- Total amount -->
                                                                                    <c:set var="total" value="0"/>

                                                                                    <c:forEach var="item" items="${cart}">
                                                                                        <c:set var="total"
                                                                                               value="${total + (item.price * item.quantity)}"/>
                                                                                    </c:forEach>

                                                                                    <div class="flex justify-between text-xl font-bold">
                                                                                        <span>Total</span>
                                                                                        <span id="grandTotal"><fmt:formatNumber value="${total}" type="number" maxFractionDigits="0"/> đ</span>
                                                                                    </div>

                                                                            </div>

                                                                            <form id="checkoutForm"
                                                                                  action="${pageContext.request.contextPath}/checkout"
                                                                                  method ="POST">
                                                                                <div id="selectedProducts"></div>
                                                                                <button type="submit"
                                                                                        class="block w-full mt-8 text-center bg-black text-white py-4 uppercase tracking-wider hover:bg-gray-800 transition rounded-lg">
                                                                                    Proceed To Checkout
                                                                                </button>

                                                                            </form>

                                                                            <a href="${pageContext.request.contextPath}/products"
                                                                               class="block w-full mt-3 text-center border py-4 uppercase tracking-wider hover:bg-gray-50 transition rounded-lg">
                                                                                Continue Shopping
                                                                            </a>

                                                                        </div>

                                                                    </div>

                                                                    </div>

                                                                    </section>

                                                                </c:if>
                                                                <script>

                                                                    document.addEventListener("DOMContentLoaded", function () {

                                                                        const totalElement =
                                                                                document.getElementById("grandTotal");

                                                                        function calculateTotal() {

                                                                            let total = 0;

                                                                            document.querySelectorAll(".cart-checkbox")
                                                                                    .forEach(cb => {

                                                                                        if (cb.checked) {

                                                                                            total +=
                                                                                                    Number(cb.dataset.price)
                                                                                                    * Number(cb.dataset.qty);
                                                                                        }
                                                                                    });

                                                                            totalElement.innerHTML =
                                                                                    total.toLocaleString('vi-VN') + " đ";
                                                                        }

                                                                        document.querySelectorAll(".cart-checkbox")
                                                                                .forEach(cb => {

                                                                                    cb.addEventListener("change", calculateTotal);
                                                                                });

                                                                        calculateTotal();

                                                                    });
                                                                    document.getElementById("checkoutForm")
                                                                            .addEventListener("submit", function (e) {

                                                                                const container =
                                                                                        document.getElementById("selectedProducts");

                                                                                container.innerHTML = "";

                                                                                let checkedCount = 0;

                                                                                document.querySelectorAll(".cart-checkbox")
                                                                                        .forEach(cb => {

                                                                                            if (cb.checked) {

                                                                                                checkedCount++;

                                                                                                const input =
                                                                                                        document.createElement("input");

                                                                                                input.type = "hidden";
                                                                                                input.name = "selectedItems";
                                                                                                input.value = cb.value;

                                                                                                container.appendChild(input);
                                                                                            }
                                                                                        });

                                                                                if (checkedCount === 0) {

                                                                                    e.preventDefault();

                                                                                    alert("Please select at least one product.");
                                                                                }
                                                                            });
                                                                    function calculateTotal() {

                                                                        let total = 0;
                                                                        let count = 0;

                                                                        document.querySelectorAll(".cart-checkbox").forEach(cb => {

                                                                            if (cb.checked) {

                                                                                total += Number(cb.dataset.price)
                                                                                        * Number(cb.dataset.qty);

                                                                                count++;
                                                                            }
                                                                        });

                                                                        document.getElementById("grandTotal").innerHTML =
                                                                                total.toLocaleString('vi-VN') + " đ";

                                                                        document.getElementById("selectedCount").innerHTML =
                                                                                count;
                                                                    }
                                                                </script>

                                                                </main>

                                                                <jsp:include page="/WEB-INF/include/footer.jsp"/>