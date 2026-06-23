<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
                    <div class="mb-6">

                        <span class="text-gray-500 block mb-2">
                            Price
                        </span>

                        <span class="text-5xl font-bold text-black">
                            $${product.price}
                        </span>

                    </div>

                    <div class="mb-4">

                        <label class="block font-semibold mb-2">
                            Size
                        </label>

                        <select id="sizeSelect"
                                class="w-full border rounded-lg px-4 py-3">

                            <option value="">
                                Select Size
                            </option>

                            <c:forEach var="size" items="${sizes}">
                                <option value="${size}">
                                    ${size}
                                </option>
                            </c:forEach>

                        </select>

                    </div>
                    <div class="mb-6">

                        <label class="block font-semibold mb-2">
                            Color
                        </label>

                        <select id="colorSelect"
                                class="w-full border rounded-lg px-4 py-3">

                            <option value="">
                                Select Color
                            </option>

                            <c:forEach var="color" items="${colors}">
                                <option value="${color}">
                                    ${color}
                                </option>
                            </c:forEach>

                        </select>

                    </div>

                    <div class="flex flex-wrap gap-4">

                        <form action="${pageContext.request.contextPath}/AddToCart"
                              method="post">

                            <input type="hidden"
                                   name="productId"
                                   value="${product.id}">

                            <input type="hidden"
                                   id="selectedVariantId"
                                   name="variantId">

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
            <script>

                const variants = [

                <c:forEach var="v" items="${variants}" varStatus="s">
                {
                id : "${v.id}",
                        size : "${v.size}",
                        color : "${v.color}"
                }
                    <c:if test="${!s.last}">,</c:if>
                </c:forEach>

                ];

                document.getElementById("sizeSelect")
                        .addEventListener("change", updateVariant);

                document.getElementById("colorSelect")
                        .addEventListener("change", updateVariant);

                function updateVariant() {

                    let size =
                            document.getElementById("sizeSelect").value;

                    let color =
                            document.getElementById("colorSelect").value;

                    let variant = variants.find(v =>
                        v.size === size &&
                                v.color === color
                    );

                    if (variant) {

                        document.getElementById("selectedVariantId")
                                .value = variant.id;
                    }
                }

            </script>
            </main>

            <jsp:include page="/WEB-INF/include/footer.jsp"/>