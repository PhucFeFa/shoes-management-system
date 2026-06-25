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
                        <h1 class="text-headline-lg font-headline-lg text-primary uppercase tracking-tighter">ADIDIS
                        </h1>
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
                                    <input type="text" name="search" value="${searchQuery}"
                                        placeholder="Search..."
                                        class="w-full bg-surface-container text-label-sm text-primary border-none py-2 px-3 rounded-none focus:ring-2 focus:ring-primary focus:outline-none placeholder:text-secondary/50">
                                    <span
                                        class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2 text-secondary text-[18px]">search</span>
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
                                                class="w-5 h-5 border-2 border-outline rounded-none text-primary focus:ring-primary focus:ring-offset-0 transition-colors"
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
                                                class="w-5 h-5 border-2 border-outline rounded-none text-primary focus:ring-primary focus:ring-offset-0 transition-colors"
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
                                    <input type="number" name="minPrice" value="${minPrice}" placeholder="Min" min="0"
                                        step="0.01"
                                        class="w-full bg-surface-container text-body-md text-primary border-none p-2 rounded-none focus:ring-2 focus:ring-primary focus:outline-none">
                                    <span class="text-secondary">-</span>
                                    <input type="number" name="maxPrice" value="${maxPrice}" placeholder="Max" min="0"
                                        step="0.01"
                                        class="w-full bg-surface-container text-body-md text-primary border-none p-2 rounded-none focus:ring-2 focus:ring-primary focus:outline-none">
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex flex-col space-y-3 pt-4">
                                <button type="submit"
                                    class="w-full bg-primary text-on-primary py-4 text-label-md font-label-md uppercase tracking-widest hover:bg-primary/90 transition-colors">
                                    APPLY FILTERS
                                </button>
                                <a href="${pageContext.request.contextPath}/products"
                                    class="w-full bg-transparent text-secondary py-3 text-center text-label-sm font-label-sm uppercase tracking-widest hover:text-primary transition-colors border border-outline-variant">
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
                                    class="flex flex-col items-center justify-center py-20 px-4 text-center bg-surface-container-low border border-surface-variant">
                                    <span
                                        class="material-symbols-outlined text-[64px] text-secondary mb-4">inventory_2</span>
                                    <h2 class="text-headline-md font-headline-md text-primary mb-2">No Products Found
                                    </h2>
                                    <p class="text-body-md text-secondary">Try adjusting your filters or search query to
                                        find what you're looking for.</p>
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="mt-6 border-b-2 border-primary text-label-md font-label-md uppercase text-primary pb-1 hover:opacity-80">
                                        Clear Filters
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="grid grid-cols-2 sm:grid-cols-3 xl:grid-cols-4 2xl:grid-cols-5 gap-4 md:gap-6">
                                    <c:forEach var="p" items="${products}">
                                        <div
                                            class="group flex flex-col relative bg-surface hover:bg-surface-container transition-colors duration-300">

                                            <!-- Product Image -->
                                            <a href="${pageContext.request.contextPath}/ProductDetail?id=${p.id}"
                                                class="relative aspect-square overflow-hidden bg-surface-container-high block">
                                                <c:choose>
                                                    <c:when test="${not empty p.firstImageUrl}">
                                                        <img src="${p.firstImageUrl}" alt="${p.name}"
                                                            class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div
                                                            class="w-full h-full flex items-center justify-center text-secondary">
                                                            <span
                                                                class="material-symbols-outlined text-4xl">image_not_supported</span>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </a>

                                            <!-- Product Info -->
                                            <div class="p-4 flex flex-col flex-1">
                                                <div class="flex justify-between items-start mb-2">
                                                    <span
                                                        class="text-label-sm text-secondary uppercase tracking-wider">${p.brand.name}</span>
                                                    <span class="text-label-sm font-label-sm text-primary font-bold">
                                                        $
                                                        <fmt:formatNumber value="${p.price}" pattern="#,##0.00" />
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
                                                            <div class="relative inline-block text-gray-300 text-sm mr-1 whitespace-nowrap">
                                                                ★★★★★
                                                                <div class="absolute top-0 left-0 overflow-hidden text-yellow-500 whitespace-nowrap" style="width: ${p.averageRating / 5 * 100}%;">
                                                                    ★★★★★
                                                                </div>
                                                            </div>
                                                            <span class="text-label-sm text-secondary">(${p.reviewCount})</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="text-gray-300 text-sm mr-1">★★★★★</div>
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
                                            <button onclick="goToPage(${currentPage - 1})" class="w-10 h-10 flex items-center justify-center border border-outline hover:border-primary hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                            </button>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages}" var="i">
                                            <button onclick="goToPage(${i})" class="w-10 h-10 flex items-center justify-center text-label-sm font-label-sm transition-colors ${i == currentPage ? 'bg-primary text-on-primary border border-primary' : 'border border-outline hover:border-primary hover:text-primary'}">
                                                ${i}
                                            </button>
                                        </c:forEach>

                                        <c:if test="${currentPage < totalPages}">
                                            <button onclick="goToPage(${currentPage + 1})" class="w-10 h-10 flex items-center justify-center border border-outline hover:border-primary hover:text-primary transition-colors">
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

                // Optional: Auto-submit form on checkbox change (for real-time filtering without clicking apply)
                // Uncomment if requested by client. Currently, it requires hitting 'APPLY FILTERS' for better UX on mobile.
                /*
                document.querySelectorAll('#filterForm input[type="checkbox"]').forEach(checkbox => {
                    checkbox.addEventListener('change', () => {
                        document.getElementById('pageInput').value = 1; // reset page on filter change
                        document.getElementById('filterForm').submit();
                    });
                });
                */
            </script>

            <jsp:include page="/WEB-INF/include/footer.jsp" />