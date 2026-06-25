<%-- Author: PhucLHCE191132 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp" />

<%-- Cart Notification Modal --%>
<c:if test="${not empty sessionScope.cartMessage}">
    <div id="cartModal"
         class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg shadow-xl p-6 w-96 text-center">
            <h2 class="text-xl font-bold text-black mb-4">
                Notification
            </h2>
            <p class="text-black mb-6">
                ${sessionScope.cartMessage}
            </p>
            <button onclick="closeModal()"
                    class="bg-black text-white px-6 py-2 rounded hover:opacity-80 transition">
                OK
            </button>
        </div>
    </div>
    <script>
        function closeModal() {
            document.getElementById("cartModal").style.display = "none";
        }
        setTimeout(function () {
            const modal = document.getElementById("cartModal");
            if (modal) {
                modal.style.display = "none";
            }
        }, 3000);
    </script>
    <c:remove var="cartMessage" scope="session"/>
</c:if>

<main class="pt-16">
    <!-- Hero Section -->
    <section class="relative w-full overflow-hidden bg-surface-container-highest flex items-center min-h-[819px]">
        <div class="absolute inset-0 z-0 overflow-hidden">
            <img alt="Featured Sneaker"
                 class="w-full h-full object-cover object-center scale-105 transform hover:scale-100 transition-transform duration-1000"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuACutnihmQtYBPAKgXjECViT-c2SAHO6QxMztM7_A1ailOWnQSDhJ46jA80p7_WMAhR_gk13L4vm9CnscvlXGnv_FMwClS28RUaba1JXfp7qYeDjj2kntx4ewnJYNAf6114xHPQy0mWesAX1wwragktNmtwNNJoZnYzqirKQjjg_rGGFDpOImAjtZ4djhiB8aHrnZT1QE6VGfya3vRNVIvKOzmCqLWNZqyB3gnjTJZ91KvgWIjY2liRf-0NpCuryiThVjMc6Z_WZno" />
        </div>
        <div class="relative z-10 px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto">
            <div class="max-w-xl">
                <p class="text-label-md font-label-md uppercase tracking-widest text-primary mb-4">ELEVATE YOUR PERFORMANCE</p>
                <h1 class="text-display-lg-mobile md:text-display-lg font-display-lg text-primary mb-8 leading-[1.05]">
                    DISCOVER<br />YOUR EDGE
                </h1>
                <a href="${pageContext.request.contextPath}/products" class="inline-block bg-primary text-on-primary px-10 py-5 text-label-md font-label-md uppercase tracking-wider hover:opacity-90 transition-all active:scale-95">
                    SHOP NOW
                </a>
            </div>
        </div>
        <div class="absolute bottom-12 right-margin-desktop hidden lg:block">
            <div class="flex flex-col items-end gap-2 text-primary">
                <span class="text-label-sm font-label-sm opacity-50">DESIGNED IN LAB_04</span>
                <div class="h-px w-24 bg-primary"></div>
                <span class="text-label-md font-label-md font-bold italic">ENGINEERED FOR SPEED</span>
            </div>
        </div>
    </section>

    <!-- Product Grid Section -->
    <section class="py-24 px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto">
        <div class="flex justify-between items-end mb-16 border-b border-outline-variant pb-8">
            <div>
                <h2 class="text-headline-lg font-headline-lg text-primary">LATEST DROPS</h2>
                <p class="text-body-md text-secondary mt-2">Precision engineered for the urban athlete.</p>
            </div>
            <a class="text-label-md font-label-md text-primary border-b border-primary hover:pb-1 transition-all"
               href="${pageContext.request.contextPath}/products">VIEW ALL PRODUCTS</a>
        </div>

        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-gutter">
            <c:forEach var="product" items="${latestProducts}">
                <div class="product-card group relative cursor-pointer transition-transform duration-500 hover:-translate-y-2">
                    <div class="bg-surface-container aspect-square overflow-hidden mb-6 flex items-center justify-center p-8 relative">
                        <!-- Product Image -->
                        <c:choose>
                            <c:when test="${not empty product.firstImageUrl}">
                                <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}">
                                    <img alt="${product.name}"
                                         class="w-full h-full object-contain mix-blend-multiply transition-transform duration-500 group-hover:scale-110"
                                         src="${product.firstImageUrl}" />
                                </a>
                            </c:when>
                            <c:otherwise>
                                <img alt="${product.name}"
                                     class="w-full h-full object-contain mix-blend-multiply transition-transform duration-500 group-hover:scale-110"
                                     src="https://via.placeholder.com/300?text=No+Image" />
                            </c:otherwise>
                        </c:choose>

                        <!-- Add to Cart Form -->
                        <form action="${pageContext.request.contextPath}/AddToCart" method="post"
                              class="absolute bottom-0 left-0 w-full">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <input type="hidden" name="variantId" value="${variant.id}">
                            <input type="hidden" name="returnUrl"
                                   value="${pageContext.request.requestURI}?id=${product.id}">
                            <button type="submit"
                                    class="add-to-cart-btn w-full bg-primary text-on-primary py-4 text-label-md font-label-md uppercase opacity-0 transform translate-y-4 transition-all duration-300">
                                ADD TO CART
                            </button>
                        </form>
                    </div>

                    <div>
                        <h3 class="text-label-md font-label-md font-bold uppercase mb-1">
                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${product.id}"
                               class="hover:text-blue-600">
                                ${product.name}
                            </a>
                        </h3>
                        <p class="text-label-sm text-secondary mb-2">${product.category.name}</p>
                        <div class="flex items-center gap-1 mb-2">
                            <c:choose>
                                <c:when test="${product.reviewCount > 0}">
                                    <div class="relative inline-block text-gray-300 text-sm mr-1 whitespace-nowrap">
                                        ★★★★★
                                        <div class="absolute top-0 left-0 overflow-hidden text-yellow-500 whitespace-nowrap" style="width: ${product.averageRating / 5 * 100}%;">
                                            ★★★★★
                                        </div>
                                    </div>
                                    <span class="text-label-sm text-secondary">(${product.reviewCount})</span>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-gray-300 text-sm mr-1">★★★★★</div>
                                    <span class="text-label-sm text-secondary">No reviews</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <p class="text-label-md font-label-md text-primary">$${product.price}</p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>

    <!-- About Us Section -->
    <section class="py-24 bg-surface-container-high px-margin-mobile md:px-margin-desktop">
        <div class="max-w-container-max mx-auto grid grid-cols-1 md:grid-cols-2 gap-24 items-center">
            <div>
                <h2 class="text-headline-lg font-headline-lg text-primary mb-6">ABOUT ADIDIS</h2>
                <p class="text-body-lg text-on-surface-variant mb-6 max-w-md">
                    At ADIDIS, we blend cutting-edge engineering with urban aesthetics to create footwear that empowers your every step. Our mission is to push the boundaries of performance and style.
                </p>
                <p class="text-body-lg text-on-surface-variant mb-8 max-w-md">
                    Experience the perfect synergy of comfort and speed. We don't just design shoes; we engineer movement.
                </p>
                <a href="${pageContext.request.contextPath}/products" class="inline-block bg-primary text-on-primary px-8 py-4 text-label-md font-label-md uppercase whitespace-nowrap hover:opacity-90 transition-all">
                    DISCOVER MORE
                </a>
            </div>
            <div class="relative aspect-video overflow-hidden group">
                <img alt="About ADIDIS"
                     class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                     src="https://images.unsplash.com/photo-1556906781-9a412961c28c?q=80&w=1200&auto=format&fit=crop" />
            </div>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />