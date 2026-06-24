<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/include/header.jsp"/>

<main class="pt-32 pb-24 min-h-screen bg-gray-50">
    <div class="max-w-6xl mx-auto px-6">
        <div class="bg-white rounded-2xl shadow-lg border p-10">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12">

                <!-- Image -->
                <div class="flex items-center justify-center">
                    <img src="${product.firstImageUrl}" alt="${product.name}" 
                         class="max-h-[500px] w-auto object-contain">
                </div>

                <!-- Info -->
                <div class="flex flex-col justify-center">
                    <h1 class="text-4xl font-bold uppercase mb-6">${product.name}</h1>

                    <div class="space-y-4 mb-8">
                        <div class="flex"><span class="font-semibold w-32">Category:</span><span>${product.category.name}</span></div>
                        <div class="flex"><span class="font-semibold w-32">Brand:</span><span>${product.brand.name}</span></div>
                        <div class="flex"><span class="font-semibold w-32">Status:</span><span class="text-green-600 font-semibold">${product.status}</span></div>
                    </div>

                    <div class="mb-8">
                        <h3 class="text-xl font-semibold mb-3">Description</h3>
                        <p class="text-gray-700 leading-relaxed">${product.description}</p>
                    </div>

                    <div class="mb-6">
                        <span class="text-gray-500 block mb-2">Price</span>
                        <span class="text-5xl font-bold">$${product.price}</span>
                    </div>

                    <!-- Size -->
                    <div class="mb-4">
                        <label class="block font-semibold mb-2">Size</label>
                        <select id="sizeSelect" class="w-full border rounded-lg px-4 py-3">
                            <option value="">Chọn Size</option>
                            <c:forEach var="size" items="${sizes}">
                                <option value="${size}">${size}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Color -->
                    <div class="mb-6">
                        <label class="block font-semibold mb-2">Color</label>
                        <select id="colorSelect" class="w-full border rounded-lg px-4 py-3" disabled>
                            <option value="">Chọn Màu</option>
                        </select>
                    </div>

                    <!-- Stock Info -->
                    <div class="mb-6">
                        <span id="stockInfo" class="font-semibold text-lg"></span>
                    </div>

                    <div class="flex items-center gap-6 mt-4">

                        <form action="${pageContext.request.contextPath}/AddToCart"
                              method="post"
                              class="flex-1">

                            <input type="hidden" name="productId" value="${product.id}">
                            <input type="hidden" id="selectedVariantId" name="variantId">

                            <button id="addToCartBtn"
                                    type="submit"
                                    class="w-full bg-black text-white px-8 py-4 rounded-lg hover:bg-gray-800 transition disabled:opacity-50"
                                    disabled>
                                ADD TO CART
                            </button>
                        </form>

                        <a href="${pageContext.request.contextPath}/home"
                           class="flex-1 flex items-center justify-center border border-black px-8 py-4 rounded-lg hover:bg-gray-100 transition">
                            BACK TO PRODUCTS
                        </a>

                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    const variants = [
    <c:forEach var="v" items="${variants}" varStatus="s">
    {
    id: "${v.id}",
            size: "${v.size}",
            color: "${v.color}",
            stock: ${v.stockQuantity}
    }<c:if test="${!s.last}">,</c:if>
    </c:forEach>
    ];

    const sizeSelect = document.getElementById("sizeSelect");
    const colorSelect = document.getElementById("colorSelect");
    const stockInfo = document.getElementById("stockInfo");
    const addBtn = document.getElementById("addToCartBtn");

    sizeSelect.addEventListener("change", function () {
        const selectedSize = this.value;
        colorSelect.innerHTML = '<option value="">Chọn Màu</option>';
        colorSelect.disabled = true;
        stockInfo.textContent = "";
        addBtn.disabled = true;

        if (!selectedSize)
            return;

        const availableColors = new Set();
        variants.forEach(v => {
            if (v.size === selectedSize)
                availableColors.add(v.color);
        });

        availableColors.forEach(color => {
            const opt = document.createElement("option");
            opt.value = color;
            opt.textContent = color;
            colorSelect.appendChild(opt);
        });
        colorSelect.disabled = false;
    });

    colorSelect.addEventListener("change", function () {
        const size = sizeSelect.value;
        const color = this.value;

        if (!size || !color)
            return;

        const variant = variants.find(v => v.size === size && v.color === color);
        if (!variant)
            return;

        document.getElementById("selectedVariantId").value = variant.id;

        if (variant.stock <= 0) {
            stockInfo.innerHTML = '<span class="text-red-600">Out Of Stock</span>';
            addBtn.disabled = true;
        } else {
            stockInfo.innerHTML = `<span class="text-green-600">Available: ${variant.stock} items</span>`;
            addBtn.disabled = false;
        }
    });
</script>

<jsp:include page="/WEB-INF/include/footer.jsp"/>