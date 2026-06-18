<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<<<<<<< Updated upstream
<main class="pt-32 pb-24 min-h-screen bg-gray-50">

    <div class="max-w-6xl mx-auto px-6">

        <!-- Product Detail Card -->
        <div class="bg-white rounded-2xl shadow-lg border p-10">

            <div class="grid grid-cols-1 md:grid-cols-2 gap-12">

                <!-- Product Image -->
                <div class="flex items-center justify-center">

                    <img src="${product.firstImageUrl}"
                         alt="${product.name}"
                         class="max-h-[500px] w-auto object-contain">

                </div>

                <!-- Product Info -->
                <div class="flex flex-col justify-center">

                    <h1 class="text-4xl font-bold uppercase mb-6">
                        ${product.name}
                    </h1>

                    <div class="space-y-4 mb-8">

                        <div class="flex">
                            <span class="font-semibold w-32">
                                Category:
                            </span>
                            <span>
                                ${product.category.name}
                            </span>
                        </div>

                        <div class="flex">
                            <span class="font-semibold w-32">
                                Brand:
                            </span>
                            <span>
                                ${product.brand.name}
                            </span>
                        </div>

                        <div class="flex">
                            <span class="font-semibold w-32">
                                Status:
                            </span>

                            <span class="text-green-600 font-semibold">
                                ${product.status}
                            </span>
                        </div>

                    </div>

                    <!-- Description -->
                    <div class="mb-8">

                        <h3 class="text-xl font-semibold mb-3">
                            Description
                        </h3>

                        <p class="text-gray-700 leading-relaxed">
                            ${product.description}
                        </p>

                    </div>

                    <!-- Price -->
                    <div class="mb-10">

                        <span class="text-gray-500 block mb-2">
                            Price
                        </span>

                        <span class="text-5xl font-bold text-black">
                            $${product.price}
                        </span>

                    </div>

                    <!-- Buttons -->
                    <div class="flex flex-wrap gap-4">

                        <form action="${pageContext.request.contextPath}/AddToCart"
                              method="post">

                            <input type="hidden"
                                   name="productId"
                                   value="${product.id}">

                            <input type="hidden"
                                   name="returnUrl"
                                   value="${pageContext.request.requestURI}?id=${product.id}">

                            <button type="submit"
                                    class="bg-black text-white px-8 py-4 rounded-lg hover:bg-gray-800 transition">
                                ADD TO CART
                            </button>

                        </form>

                        <a href="${pageContext.request.contextPath}/home"
                           class="border border-black px-8 py-4 rounded-lg hover:bg-gray-100 transition">
                            BACK TO PRODUCTS
                        </a>

                    </div>

                </div>

            </div>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp"/>