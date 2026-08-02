<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <jsp:include page="/WEB-INF/include/header.jsp" />

            <!-- Main Layout with padding for fixed header -->
            <div class="pt-24 min-h-screen w-full max-w-container-max mx-auto px-4 md:px-8 mb-16">

                <!-- Title and Top Section -->
                <div
                    class="flex flex-col md:flex-row justify-between items-start md:items-center mb-8 border-b border-surface-variant pb-6">
                    <div>
                        <p class="text-body-md text-secondary mt-2">Discover the latest in engineered speed and
                            performance.</p>
                    </div>
                    <div class="text-label-md font-label-md text-secondary mt-4 md:mt-0">
                        ${totalProducts} PRODUCTS FOUND
                    </div>
                </div>

                <div class="flex flex-col lg:flex-row gap-8">

                    <!-- Sidebar Filters -->
                    <aside class="w-full lg:w-1/5 lg:max-w-[220px]">
                        <form action="${pageContext.request.contextPath}/products" method="GET"
                            class="sticky top-24 flex flex-col space-y-6" id="filterForm">
                            <input type="hidden" name="page" id="pageInput" value="1">

                            <!-- Search -->
                            <div>
                                <h3
                                    class="text-label-sm font-bold tracking-wider uppercase text-primary mb-4 border-b border-surface-variant pb-2">
                                    SEARCH</h3>
                                <div class="relative">
                                    <input type="text" name="search" value="${searchQuery}" placeholder="Search..."
                                        class="w-full bg-surface-container text-label-sm text-primary border-none py-2 px-4 rounded-full focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50">
                                    <span
                                        class="material-symbols-outlined absolute right-3 top-1/2 -translate-y-1/2 text-secondary text-[18px]">search</span>
                                </div>
                            </div>

                            <!-- Category Filter -->
                            <div>
                                <h3
                                    class="text-label-sm font-bold tracking-wider uppercase text-primary mb-4 border-b border-surface-variant pb-2">
                                    CATEGORY</h3>
                                <div class="flex flex-col space-y-3">
                                    <c:forEach var="cat" items="${categories}">
                                        <label class="flex items-center space-x-3 cursor-pointer group">
                                            <input type="checkbox" name="category" value="${cat.id}"
                                                class="w-4 h-4 border-2 border-outline rounded text-primary focus:ring-primary focus:ring-offset-0 transition-colors"
                                                ${selectedCategories !=null && selectedCategories.contains(cat.id)
                                                ? 'checked' : '' }>
                                            <span
                                                class="text-body-md text-secondary group-hover:text-primary transition-colors">${cat.name}</span>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Brand Filter -->
                            <div>
                                <h3
                                    class="text-label-sm font-bold tracking-wider uppercase text-primary mb-4 border-b border-surface-variant pb-2">
                                    BRAND</h3>
                                <div class="flex flex-col space-y-3">
                                    <c:forEach var="brand" items="${brands}">
                                        <label class="flex items-center space-x-3 cursor-pointer group">
                                            <input type="checkbox" name="brand" value="${brand.id}"
                                                class="w-4 h-4 border-2 border-outline rounded text-primary focus:ring-primary focus:ring-offset-0 transition-colors"
                                                ${selectedBrands !=null && selectedBrands.contains(brand.id) ? 'checked'
                                                : '' }>
                                            <span
                                                class="text-body-md text-secondary group-hover:text-primary transition-colors">${brand.name}</span>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>

                            <!-- Price Range Filter -->
                            <div>
                                <h3
                                    class="text-label-sm font-bold tracking-wider uppercase text-primary mb-4 border-b border-surface-variant pb-2">
                                    PRICE</h3>
                                <div class="flex items-center space-x-4">
                                    <input type="number" name="minPrice" value="<fmt:formatNumber value='${minPrice}' pattern='0.##'/>" placeholder="Min" min="0"
                                        step="0.01"
                                        class="w-full bg-surface-container text-body-md text-primary border-none p-2 rounded-xl focus:ring-2 focus:ring-primary focus:outline-none">
                                    <span class="text-secondary">-</span>
                                    <input type="number" name="maxPrice" value="<fmt:formatNumber value='${maxPrice}' pattern='0.##'/>" placeholder="Max" min="0"
                                        step="0.01"
                                        class="w-full bg-surface-container text-body-md text-primary border-none p-2 rounded-xl focus:ring-2 focus:ring-primary focus:outline-none">
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex flex-col space-y-3 pt-4">
                                <button type="submit"
                                    class="w-full bg-primary text-on-primary py-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors rounded-full">
                                    APPLY FILTERS
                                </button>
                                <a href="${pageContext.request.contextPath}/products"
                                    class="w-full bg-transparent text-secondary py-3 text-center text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors border border-outline-variant rounded-full">
                                    CLEAR ALL
                                </a>
                            </div>

                        </form>
                    </aside>

                    <!-- Product Grid -->
                    <main class="w-full lg:w-4/5">
                        <c:choose>
                            <c:when test="${empty products}">
                                <div
                                    class="flex flex-col items-center justify-center py-20 px-4 text-center bg-surface-container-low border border-surface-variant rounded-2xl">
                                    <span
                                        class="material-symbols-outlined text-[64px] text-secondary mb-4">inventory_2</span>
                                    <h2 class="text-headline-md font-headline-md text-primary mb-2">No Products Found
                                    </h2>
                                    <p class="text-body-md text-secondary">Try adjusting your filters or search query to
                                        find what you're looking for.</p>
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="mt-6 bg-primary text-on-primary px-6 py-3 text-label-md font-label-md uppercase rounded-full hover:opacity-80 transition-all">
                                        Clear Filters
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div
                                    class="grid grid-cols-2 sm:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-4 md:gap-6">
                                    <c:forEach var="p" items="${products}">
                                        <div
                                            class="group flex flex-col relative bg-surface hover:bg-surface-container transition-colors duration-300 rounded-2xl overflow-hidden shadow-sm hover:shadow-md">

                                            <!-- Product Image -->
                                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${p.id}"
                                                class="relative aspect-square overflow-hidden bg-surface-container-high block rounded-t-2xl">
                                                <c:choose>
                                                    <c:when test="${not empty p.firstImageUrl}">
                                                        <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${p.firstImageUrl}" alt="${p.name}"
                                                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/assets/fallback.png" alt="${p.name}" class="w-full h-full object-cover">
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>

                                            <!-- Product Info -->
                                            <div class="p-4 flex flex-col flex-1">
                                                <div class="flex justify-between items-start mb-2">
                                                    <span
                                                        class="text-label-sm text-secondary uppercase tracking-wider">${p.brand.name}</span>
                                                    <span class="text-label-sm font-label-sm text-primary font-bold">
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                                                    </span>
                                                </div>
                                                <a href="${pageContext.request.contextPath}/ProductDetail?id=${p.id}"
                                                    class="text-body-lg font-bold text-primary group-hover:underline underline-offset-4 decoration-2">
                                                    ${p.name}
                                                </a>
                                                <span
                                                    class="text-label-sm text-secondary mt-1 mb-2">${p.category.name}</span>
                                                <div class="flex items-center gap-1 mt-auto">
                                                    <c:choose>
                                                        <c:when test="${p.reviewCount > 0}">
                                                            <div
                                                                class="relative inline-block text-outline-variant text-sm mr-1 whitespace-nowrap">
                                                                ★★★★★
                                                                <div class="absolute top-0 left-0 overflow-hidden text-primary whitespace-nowrap"
                                                                    style="width: ${p.averageRating / 5 * 100}%;">
                                                                    ★★★★★
                                                                </div>
                                                            </div>
                                                            <span
                                                                class="text-label-sm text-secondary">(${p.reviewCount})</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="text-outline-variant text-sm mr-1">★★★★★</div>
                                                            <span class="text-label-sm text-secondary">No reviews</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="mt-12 flex justify-center items-center space-x-2">
                                        <c:if test="${currentPage > 1}">
                                            <button onclick="goToPage(${currentPage - 1})"
                                                class="w-10 h-10 flex items-center justify-center border border-outline rounded-full hover:border-primary hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                            </button>
                                        </c:if>

                                        <c:set var="startPage" value="${currentPage - 2}" />
<c:set var="endPage" value="${currentPage + 2}" />
<c:if test="${startPage < 1}">
    <c:set var="endPage" value="${endPage + (1 - startPage)}" />
    <c:set var="startPage" value="1" />
</c:if>
<c:if test="${endPage > totalPages}">
    <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
    <c:set var="endPage" value="${totalPages}" />
</c:if>
<c:if test="${startPage < 1}">
    <c:set var="startPage" value="1" />
</c:if>

<c:if test="${startPage > 1}">
    <c:set var="i" value="1" />
    <button onclick="goToPage(${i})"
                                                class="w-10 h-10 flex items-center justify-center text-label-sm font-label-sm transition-colors rounded-full ${i == currentPage ? 'bg-primary text-on-primary border border-primary' : 'border border-outline hover:border-primary hover:text-primary'}">
                                                ${i}
                                            </button>
    <c:if test="${startPage > 2}">
        <span class="px-2">...</span>
    </c:if>
</c:if>

<c:forEach begin="${startPage}" end="${endPage}" var="i">
    <button onclick="goToPage(${i})"
                                                class="w-10 h-10 flex items-center justify-center text-label-sm font-label-sm transition-colors rounded-full ${i == currentPage ? 'bg-primary text-on-primary border border-primary' : 'border border-outline hover:border-primary hover:text-primary'}">
                                                ${i}
                                            </button>
</c:forEach>

<c:if test="${endPage < totalPages}">
    <c:if test="${endPage < totalPages - 1}">
        <span class="px-2">...</span>
    </c:if>
    <c:set var="i" value="${totalPages}" />
    <button onclick="goToPage(${i})"
                                                class="w-10 h-10 flex items-center justify-center text-label-sm font-label-sm transition-colors rounded-full ${i == currentPage ? 'bg-primary text-on-primary border border-primary' : 'border border-outline hover:border-primary hover:text-primary'}">
                                                ${i}
                                            </button>
</c:if>

                                        <c:if test="${currentPage < totalPages}">
                                            <button onclick="goToPage(${currentPage + 1})"
                                                class="w-10 h-10 flex items-center justify-center border border-outline rounded-full hover:border-primary hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                                            </button>
                                        </c:if>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </main>

                </div>
            </div>

            <script>
                function goToPage(page) {
                    document.getElementById('pageInput').value = page;
                    document.getElementById('filterForm').submit();
                }
            </script>

            <jsp:include page="/WEB-INF/include/footer.jsp" />

