<%-- Author: PhucLHCE191132 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp" />
<main class="pt-16">
    <!-- Hero Section -->
    <section
        class="relative w-full overflow-hidden bg-surface-container-highest flex items-center min-h-[819px]">
        <div class="absolute inset-0 z-0 overflow-hidden">
            <img alt="Featured Sneaker"
                 class="w-full h-full object-cover object-center scale-105 transform hover:scale-100 transition-transform duration-1000"
                 src="https://lh3.googleusercontent.com/aida-public/AB6AXuACutnihmQtYBPAKgXjECViT-c2SAHO6QxMztM7_A1ailOWnQSDhJ46jA80p7_WMAhR_gk13L4vm9CnscvlXGnv_FMwClS28RUaba1JXfp7qYeDjj2kntx4ewnJYNAf6114xHPQy0mWesAX1wwragktNmtwNNJoZnYzqirKQjjg_rGGFDpOImAjtZ4djhiB8aHrnZT1QE6VGfya3vRNVIvKOzmCqLWNZqyB3gnjTJZ91KvgWIjY2liRf-0NpCuryiThVjMc6Z_WZno" />
        </div>
        <div class="relative z-10 px-margin-mobile md:px-margin-desktop w-full max-w-container-max mx-auto">
            <div class="max-w-xl">
                <p class="text-label-md font-label-md uppercase tracking-widest text-primary mb-4">SOLE_LAB // INITIATIVE 01</p>
                <h1
                    class="text-display-lg-mobile md:text-display-lg font-display-lg text-primary mb-8 leading-[1.05]">
                    PHANTOM<br />IGNITE_V2</h1>
                <button
                    class="bg-primary text-on-primary px-10 py-5 text-label-md font-label-md uppercase tracking-wider hover:opacity-90 transition-all active:scale-95">
                    SHOP NOW
                </button>
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
                <div
                    class="product-card group relative cursor-pointer transition-transform duration-500 hover:-translate-y-2">
                    <div
                        class="bg-surface-container aspect-square overflow-hidden mb-6 flex items-center justify-center p-8 relative">
                        <!-- Use the first image URL if available -->
                        <c:choose>
                            <c:when test="${not empty product.firstImageUrl}">
                                <img alt="${product.name}"
                                     class="w-full h-full object-contain mix-blend-multiply transition-transform duration-500 group-hover:scale-110"
                                     src="${product.firstImageUrl}" />
                            </c:when>
                            <c:otherwise>
                                <img alt="${product.name}"
                                     class="w-full h-full object-contain mix-blend-multiply transition-transform duration-500 group-hover:scale-110"
                                     src="https://via.placeholder.com/300?text=No+Image" />
                            </c:otherwise>
                        </c:choose>

                        <!-- Add to cart form -->
                        <form action="${pageContext.request.contextPath}/AddToCart" method="post"
                              class="absolute bottom-0 left-0 w-full">
                            <input type="hidden" name="productId" value="${product.id}" />
                            <input type="hidden"
                                   name="variantId"
                                   value="${variant.id}">
                            <input type="hidden" name="returnUrl"
                                   value="${pageContext.request.requestURI}?id=${product.id}">
                            <button type="submit"
                                    class="add-to-cart-btn w-full bg-primary text-on-primary py-4 text-label-md font-label-md uppercase opacity-0 transform translate-y-4 transition-all duration-300">
                                ADD TO CART
                            </button>
                        </form>
                    </div>
                    <div>
                        <h3 class="text-label-md font-label-md font-bold uppercase mb-1">${product.name}</h3>
                        <p class="text-label-sm text-secondary mb-2">${product.category.name}</p>
                        <p class="text-label-md font-label-md text-primary">$${product.price}</p>
                    </div>
                </div>
            </c:forEach>

        </div>
    </section>

    <!-- Newsletter / Lab Section -->
    <section class="py-24 bg-surface-container-high px-margin-mobile md:px-margin-desktop">
        <div class="max-w-container-max mx-auto grid grid-cols-1 md:grid-cols-2 gap-24 items-center">
            <div>
                <h2 class="text-headline-lg font-headline-lg text-primary mb-6">THE RESEARCH LAB</h2>
                <p class="text-body-lg text-on-surface-variant mb-8 max-w-md">Join the ADIDIS community to get
                    early access to clinical trials, limited drop notifications, and technical specs of our
                    upcoming performance silhouettes.</p>
                <div class="flex flex-col sm:flex-row gap-4">
                    <input
                        class="bg-surface px-6 py-4 border-none focus:ring-1 ring-primary w-full outline-none uppercase text-label-sm font-label-sm"
                        placeholder="Email Address" type="email" />
                    <button
                        class="bg-primary text-on-primary px-8 py-4 text-label-md font-label-md uppercase whitespace-nowrap hover:opacity-90 transition-all">SIGN
                        UP</button>
                </div>
            </div>
            <div class="relative aspect-video overflow-hidden group">
                <img alt="Lab Atmosphere"
                     class="w-full h-full object-cover transition-transform duration-700 group-hover:scale-105"
                     src="https://lh3.googleusercontent.com/aida-public/AB6AXuALitHG2_5Oy2ISbcyRbhrScu1yZd1SzUfmU7U8K4Ck83N3-PsFjGgDX0Cj5n5fdKnMJ98l6RQY44tljNSx3FXVOcC_rZg0qsN00T63dqkcQQdi3cRC5G4NWh4rbM16wwnnHtYUtcrwNlSXiSBF1UMOmGjCXiAPSM_l0TLXWsu6f4zu7-EM1X0eYegrRtFTLHTrCswQmRQSGWtNblv4sa2ZJzNMd77QzKkTXfOGiVl2prw7Zh0PpYI3HoV1_CzCDFA431R2gI2pd-I" />
                <div
                    class="absolute inset-0 bg-primary/10 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity duration-500">
                    <span
                        class="text-on-primary text-label-md font-label-md uppercase tracking-widest border border-on-primary px-6 py-3">ENTER
                        LAB_ACCESS</span>
                </div>
            </div>
        </div>
    </section>
</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />