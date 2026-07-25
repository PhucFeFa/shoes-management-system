<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-24 min-h-screen bg-surface">

    <!-- Header -->
    <section class="max-w-7xl mx-auto px-6 lg:px-12 mb-12">
        <div class="border-b border-outline-variant pb-6">
            <h1 class="font-headline-lg text-headline-lg text-primary uppercase tracking-tight">
                Shopping Cart
            </h1>
            <p class="text-secondary font-body-md text-body-md mt-2">
                Review your selected products before checkout.
            </p>
        </div>
    </section>

    <!-- Empty Cart -->
    <c:if test="${empty cart}">
        <section class="max-w-4xl mx-auto px-6">
            <div class="bg-surface-container-low rounded-2xl p-12 text-center border border-outline-variant">

                <span class="material-symbols-outlined text-[80px] text-secondary mb-6 block">shopping_cart</span>

                <h2 class="font-headline-md text-headline-md text-primary mb-3">
                    Your cart is empty
                </h2>

                <p class="text-secondary font-body-md text-body-md mb-8">
                    Looks like you haven't added any products yet.
                </p>

                <a href="${pageContext.request.contextPath}/products"
                   class="inline-flex items-center gap-2 px-8 py-4 bg-primary text-on-primary font-label-md text-label-md uppercase tracking-wider rounded-full hover:bg-primary/90 transition-all active:scale-95">
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
                            <span class="text-error font-bold">
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
                                <div class="w-full md:w-36 h-36 bg-surface-container rounded-2xl overflow-hidden flex-shrink-0">

                                    <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${item.imageUrl}"
                                         alt="${item.productName}"
                                         class="w-full h-full object-cover">

                                </div>

                                <!-- Info -->
                                <div class="flex-1">

                                    <h3 class="font-headline-md text-headline-md uppercase text-primary">
                                        ${item.productName}
                                    </h3>
                                    <div class="flex gap-4 mt-2 text-label-sm font-label-sm text-secondary">

                                        <span>
                                            Size:
                                            <strong>${item.size}</strong>
                                        </span>

                                        <span>
                                            Color:
                                            <strong>${item.color}</strong>
                                        </span>

                                    </div>

                                    <p class="text-secondary font-label-sm text-label-sm mt-1">
                                        Premium Sneaker Collection
                                    </p>

                                    <div class="mt-4 flex flex-wrap gap-8">

                                        <div>
                                            <span class="text-secondary text-sm">
                                                Price
                                            </span>

                                            <p class="font-semibold">
                                                <fmt:formatNumber value="${item.price}" pattern="#,##0"/> đ
                                            </p>
                                        </div>

                                        <div>
                                            <span class="text-secondary text-sm">
                                                Quantity
                                            </span>

                                            <div class="flex items-center mt-2 border border-outline-variant rounded-full overflow-hidden w-fit">

                                                <!-- Decrease button -->
                                                <form action="UpdateCart" method="post">
                                                    <input type="hidden"
                                                           name="variantId"
                                                           value="${item.productVariantId}">

                                                        <input type="hidden"
                                                               name="action"
                                                               value="decrease">

                                                            <button type="submit"
                                                                    class="w-10 h-10 bg-surface hover:bg-surface-container text-lg font-bold transition">
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
                                                                                class="w-10 h-10 bg-white hover:bg-surface-container text-lg font-bold transition">
                                                                            +
                                                                        </button>
                                                                        </form>

                                                                        </div>
                                                                        </div>

                                                                        <div>
                                                                            <span class="text-secondary text-sm">
                                                                                Total
                                                                            </span>

                                                                            <p class="font-bold text-lg">
                                                                                <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,##0"/> đ
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
                                                                    class="px-5 py-2 border border-error text-error hover:bg-error hover:text-on-primary transition-all rounded-full font-label-sm text-label-sm">
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
                                                                                        <span id="grandTotal"><fmt:formatNumber value="${total}" pattern="#,##0"/> đ</span>
                                                                                    </div>

                                                                            </div>

                                                                            <form id="checkoutForm"
                                                                                  action="${pageContext.request.contextPath}/checkout"
                                                                                  method ="POST">
                                                                                <div id="selectedProducts"></div>
                                                                                <button type="submit"
                                                                        class="block w-full mt-8 text-center bg-primary text-on-primary py-4 font-label-md text-label-md uppercase tracking-wider hover:bg-primary/90 transition-all rounded-full active:scale-[0.98]">
                                                                    Proceed To Checkout
                                                                </button>

                                                                            </form>

                                                                            <a href="${pageContext.request.contextPath}/products"
                                                               class="block w-full mt-3 text-center border border-outline-variant py-4 font-label-md text-label-md uppercase tracking-wider hover:bg-surface-container-low transition-all rounded-full">
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
                                                                                    total.toLocaleString('en-US') + " đ";
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
                                                                                total.toLocaleString('en-US') + " đ";

                                                                        document.getElementById("selectedCount").innerHTML =
                                                                                count;
                                                                    }
                                                                </script>

                                                                </main>

                                                                <jsp:include page="/WEB-INF/include/footer.jsp"/>


