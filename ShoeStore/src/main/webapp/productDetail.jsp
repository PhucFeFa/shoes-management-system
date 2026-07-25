<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <jsp:include page="/WEB-INF/include/header.jsp" />

            <style>
                .star-rating {
                    display: inline-flex;
                    flex-direction: row-reverse;
                }

                .star-rating input {
                    display: none;
                }

                .star-rating label {
                    cursor: pointer;
                    font-size: 2rem;
                    color: #d1d5db;
                    /* Tailwind gray-300 */
                    transition: color 0.2s ease-in-out;
                    margin-right: 0.25rem;
                }

                .star-rating input:checked~label {
                    color: #eab308;
                    /* Tailwind yellow-500 */
                }

                .star-rating label:hover,
                .star-rating label:hover~label {
                    color: #eab308;
                }
            </style>
            <main class="pt-24 pb-24 min-h-screen bg-surface">

                <div class="max-w-container-max mx-auto px-margin-mobile md:px-margin-desktop">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-12 lg:gap-24 mb-16">

                        <!-- Product Image Column -->
                        <div class="flex flex-col gap-6 self-start">
                            <div class="flex items-center justify-center bg-surface-container-high rounded-3xl p-12">
                                <img onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/assets/fallback.png';" src="${product.firstImageUrl}" alt="${product.name}"
                                    class="w-full h-auto object-contain mix-blend-multiply">
                            </div>

                            <!-- Description -->
                            <div class="mt-6 pt-6 border-t border-outline-variant/30">
                                <h3 class="text-headline-md font-headline-md font-bold text-primary mb-4">Description</h3>
                                <p class="text-body-md text-secondary leading-relaxed">
                                    ${product.description}
                                </p>
                            </div>
                        </div>

                        <!-- Product Info -->
                        <div class="flex flex-col py-8">
                            
                            <!-- Brand & Category -->
                            <div class="mb-4 text-secondary text-label-md uppercase tracking-widest font-label-md">
                                ${product.brand.name} • ${product.category.name}
                            </div>

                            <!-- Title -->
                            <h1 class="text-display-lg-mobile md:text-display-lg font-display-lg font-bold uppercase text-primary tracking-tight leading-none mb-6">
                                ${product.name}
                            </h1>

                            <!-- Price -->
                            <div class="text-headline-lg font-headline-lg font-bold text-primary mb-8">
                                <fmt:formatNumber value="${product.price}" pattern="#,##0"/> đ
                            </div>

                            <!-- Rating -->
                            <c:choose>
                                <c:when test="${not empty reviews}">
                                    <c:set var="totalRating" value="0" />
                                    <c:forEach var="r" items="${reviews}">
                                        <c:set var="totalRating" value="${totalRating + r.rating}" />
                                    </c:forEach>
                                    <c:set var="avgRating" value="${totalRating / reviews.size()}" />
                                    <div class="flex items-center gap-2 mb-8 border-b border-outline-variant/30 pb-8">
                                        <div class="relative inline-block text-outline-variant text-xl tracking-widest mr-2 whitespace-nowrap">
                                            ★★★★★
                                            <div class="absolute top-0 left-0 overflow-hidden text-primary whitespace-nowrap"
                                                style="width: ${avgRating / 5 * 100}%;">
                                                ★★★★★
                                            </div>
                                        </div>
                                        <span class="text-body-md font-body-md text-secondary">
                                            <fmt:formatNumber value="${avgRating}" maxFractionDigits="1" /> / 5
                                            (${reviews.size()} reviews)
                                        </span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="flex items-center gap-2 mb-8 border-b border-outline-variant/30 pb-8">
                                        <div class="text-outline-variant text-xl tracking-widest mr-2">★★★★★</div>
                                        <span class="text-body-md font-body-md text-secondary">No reviews yet</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                            <!-- Size & Color Selection -->
                            <div class="space-y-8 mb-8 border-b border-outline-variant/30 pb-8">
                                
                                <div>
                                    <div class="flex justify-between items-end mb-4">
                                        <label class="block font-headline-md text-headline-md font-bold text-primary">Select Size</label>
                                        <span class="text-label-sm font-label-sm uppercase tracking-widest text-secondary hover:text-primary cursor-pointer transition-colors">Size Guide</span>
                                    </div>
                                    <div class="grid grid-cols-3 sm:grid-cols-4 gap-3" id="sizeContainer">
                                        <c:forEach var="size" items="${sizes}">
                                            <button type="button" class="size-btn border border-outline-variant rounded-lg py-3 px-4 font-label-md text-label-md uppercase text-primary hover:border-primary transition-colors focus:ring-2 focus:ring-primary focus:outline-none" data-size="${size}">
                                                ${size}
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div>
                                    <label class="block font-headline-md text-headline-md font-bold text-primary mb-4">Select Color</label>
                                    <div class="flex flex-wrap gap-3" id="colorContainer">
                                        <c:forEach var="color" items="${colors}">
                                            <button type="button" class="color-btn border border-outline-variant rounded-lg px-6 py-3 font-label-md text-label-md uppercase text-primary hover:border-primary transition-colors focus:ring-2 focus:ring-primary focus:outline-none" data-color="${color}">
                                                ${color}
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>
                                
                            </div>

                            <div class="mb-8">
                                <span id="stockInfo" class="font-label-md text-error tracking-wide"></span>
                            </div>

                            <!-- Add to Cart / Actions -->
                            <c:choose>
                                <c:when test="${not empty sessionScope.currentUser && (sessionScope.currentUser.roleName eq 'Admin' || sessionScope.currentUser.roleName eq 'Staff')}">
                                    <div class="bg-error-container text-on-error-container p-4 rounded-2xl mb-4 font-body-md text-body-md">
                                        Admin/Staff accounts are only permitted to view products, not to make purchases.
                                    </div>
                                    <button class="w-full bg-surface-container-highest text-on-surface-variant py-5 rounded-full font-label-md text-label-md uppercase tracking-wider cursor-not-allowed opacity-50" disabled>
                                        Read Only View
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/AddToCart" method="post" class="w-full">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" id="selectedVariantId" name="variantId">
                                        <input type="hidden" name="returnUrl" value="${pageContext.request.requestURI}?id=${product.id}">
                                        <button id="addToCartBtn" type="submit" class="w-full bg-primary text-on-primary py-5 rounded-full font-label-md text-label-md uppercase tracking-wider hover:opacity-90 active:scale-95 transition-all disabled:opacity-50 disabled:cursor-not-allowed" disabled>
                                            Add to Cart
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>

                        </div> <!-- End Product Info -->
                    </div> <!-- End Grid -->

                    <!-- Reviews Section -->
                        <div class="w-full mt-16 pt-16 border-t border-outline-variant/30">
                            <h2 class="text-headline-md font-headline-md font-bold text-primary mb-8">Customer Reviews</h2>

                            <!-- Display messages -->
                            <c:if test="${not empty sessionScope.success}">
                                <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
                                    ${sessionScope.success}
                                </div>
                                <c:remove var="success" scope="session" />
                            </c:if>
                            <c:if test="${not empty sessionScope.error}">
                                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                                    ${sessionScope.error}
                                </div>
                                <c:remove var="error" scope="session" />
                            </c:if>

                            <!-- Review Form -->
                            <c:if test="${canReview}">
                                <div class="bg-gray-50 p-6 rounded-lg mb-8 border">
                                    <c:choose>
                                        <c:when test="${empty myReview}">
                                            <h3 class="text-lg font-semibold mb-4">Write a Review</h3>
                                            <form action="${pageContext.request.contextPath}/review" method="POST">
                                                <input type="hidden" name="action" value="add">
                                                <input type="hidden" name="productId" value="${product.id}">

                                                <div class="mb-4">
                                                    <label class="block font-semibold mb-2">Rating</label>
                                                    <div class="star-rating">
                                                        <input type="radio" id="star5" name="rating" value="5" required
                                                            checked /><label for="star5" title="5 stars">★</label>
                                                        <input type="radio" id="star4" name="rating" value="4" /><label
                                                            for="star4" title="4 stars">★</label>
                                                        <input type="radio" id="star3" name="rating" value="3" /><label
                                                            for="star3" title="3 stars">★</label>
                                                        <input type="radio" id="star2" name="rating" value="2" /><label
                                                            for="star2" title="2 stars">★</label>
                                                        <input type="radio" id="star1" name="rating" value="1" /><label
                                                            for="star1" title="1 star">★</label>
                                                    </div>
                                                </div>
                                                <div class="mb-4">
                                                    <label class="block font-semibold mb-2">Comment</label>
                                                    <textarea id="addComment" name="comment" rows="3" required
                                                        maxlength="200" class="w-full border rounded-lg px-4 py-2"
                                                        placeholder="Tell us what you think..."
                                                        oninput="document.getElementById('addCount').innerText = this.value.length + '/200'"></textarea>
                                                    <div class="text-right text-sm text-gray-500 mt-1"><span
                                                            id="addCount">0/200</span></div>
                                                </div>
                                                <button type="submit"
                                                    class="bg-primary text-on-primary px-8 py-4 rounded-full font-label-md text-label-md uppercase tracking-wider hover:opacity-90 transition-opacity">Submit
                                                    Review</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <h3 class="text-lg font-semibold mb-4">Your Review</h3>
                                            <c:choose>
                                                <c:when test="${not myReview.updated}">
                                                    <form action="${pageContext.request.contextPath}/review"
                                                        method="POST">
                                                        <input type="hidden" name="productId" value="${product.id}">
                                                        <input type="hidden" name="reviewId" value="${myReview.id}">

                                                        <div class="mb-4">
                                                            <label class="block font-semibold mb-2">Rating</label>
                                                            <div class="star-rating">
                                                                <input type="radio" id="ustar5" name="rating" value="5"
                                                                    required ${myReview.rating==5 ? 'checked' : ''
                                                                    } /><label for="ustar5" title="5 stars">★</label>
                                                                <input type="radio" id="ustar4" name="rating" value="4"
                                                                    ${myReview.rating==4 ? 'checked' : '' } /><label
                                                                    for="ustar4" title="4 stars">★</label>
                                                                <input type="radio" id="ustar3" name="rating" value="3"
                                                                    ${myReview.rating==3 ? 'checked' : '' } /><label
                                                                    for="ustar3" title="3 stars">★</label>
                                                                <input type="radio" id="ustar2" name="rating" value="2"
                                                                    ${myReview.rating==2 ? 'checked' : '' } /><label
                                                                    for="ustar2" title="2 stars">★</label>
                                                                <input type="radio" id="ustar1" name="rating" value="1"
                                                                    ${myReview.rating==1 ? 'checked' : '' } /><label
                                                                    for="ustar1" title="1 star">★</label>
                                                            </div>
                                                        </div>
                                                        <div class="mb-4">
                                                            <label class="block font-semibold mb-2">Comment</label>
                                                            <textarea id="updateComment" name="comment" rows="3"
                                                                required maxlength="200"
                                                                class="w-full border rounded-lg px-4 py-2"
                                                                oninput="document.getElementById('updateCount').innerText = this.value.length + '/200'"><c:out value="${myReview.comment}"/></textarea>
                                                            <div class="text-right text-sm text-gray-500 mt-1"><span
                                                                    id="updateCount"></span></div>
                                                            <script>document.getElementById('updateCount').innerText = document.getElementById('updateComment').value.length + '/200';</script>
                                                        </div>
                                                        <div class="flex gap-4">
                                                            <button type="submit" name="action" value="update"
                                                                class="bg-primary text-on-primary px-8 py-3 rounded-full font-label-md text-label-md uppercase tracking-wider hover:opacity-90 transition-opacity">Update</button>
                                                            <button type="submit" name="action" value="delete"
                                                                class="bg-error text-on-error px-8 py-3 rounded-full font-label-md text-label-md uppercase tracking-wider hover:opacity-90 transition-opacity"
                                                                onclick="return confirm('Are you sure you want to delete this review?');">Delete</button>
                                                        </div>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="bg-surface-container-low p-6 rounded-3xl border border-outline-variant mb-4">
                                                        <p class="text-body-md text-secondary mb-2">
                                                            <c:out value="${myReview.comment}" />
                                                        </p>
                                                        <p class="text-label-sm font-label-sm text-outline-variant uppercase tracking-widest mb-6">You have already
                                                            updated this review once.</p>
                                                        <form action="${pageContext.request.contextPath}/review"
                                                            method="POST">
                                                            <input type="hidden" name="productId" value="${product.id}">
                                                            <input type="hidden" name="reviewId" value="${myReview.id}">
                                                            <button type="submit" name="action" value="delete"
                                                                class="bg-error text-on-error px-8 py-3 rounded-full font-label-md text-label-md uppercase tracking-wider hover:opacity-90 transition-opacity"
                                                                onclick="return confirm('Are you sure you want to delete this review?');">Delete
                                                                Review</button>
                                                        </form>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>

                            <!-- Filter Reviews -->
                            <c:if test="${not empty reviews}">
                                <div class="mb-12">
                                    <h3 class="text-headline-sm font-headline-sm font-bold text-primary mb-6">Filter by Rating</h3>
                                    <div class="flex flex-wrap gap-3">
                                        <button
                                            class="review-filter-btn px-6 py-3 bg-primary text-on-primary border border-transparent rounded-full text-label-md font-label-md transition-all active:scale-95"
                                            data-rating="all">All Reviews</button>
                                        <button
                                            class="review-filter-btn px-6 py-3 border border-outline-variant rounded-full text-label-md font-label-md text-primary hover:border-primary transition-colors flex items-center gap-2 active:scale-95"
                                            data-rating="5">
                                            <span class="tracking-widest text-lg leading-none">★★★★★</span> (5)
                                        </button>
                                        <button
                                            class="review-filter-btn px-6 py-3 border border-outline-variant rounded-full text-label-md font-label-md text-primary hover:border-primary transition-colors flex items-center gap-2 active:scale-95"
                                            data-rating="4">
                                            <span class="tracking-widest text-lg leading-none">★★★★<span
                                                    class="opacity-30">★</span></span> (4)
                                        </button>
                                        <button
                                            class="review-filter-btn px-6 py-3 border border-outline-variant rounded-full text-label-md font-label-md text-primary hover:border-primary transition-colors flex items-center gap-2 active:scale-95"
                                            data-rating="3">
                                            <span class="tracking-widest text-lg leading-none">★★★<span
                                                    class="opacity-30">★★</span></span> (3)
                                        </button>
                                        <button
                                            class="review-filter-btn px-6 py-3 border border-outline-variant rounded-full text-label-md font-label-md text-primary hover:border-primary transition-colors flex items-center gap-2 active:scale-95"
                                            data-rating="2">
                                            <span class="tracking-widest text-lg leading-none">★★<span
                                                    class="opacity-30">★★★</span></span> (2)
                                        </button>
                                        <button
                                            class="review-filter-btn px-6 py-3 border border-outline-variant rounded-full text-label-md font-label-md text-primary hover:border-primary transition-colors flex items-center gap-2 active:scale-95"
                                            data-rating="1">
                                            <span class="tracking-widest text-lg leading-none">★<span
                                                    class="opacity-30">★★★★</span></span> (1)
                                        </button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- List of Reviews -->
                            <div class="space-y-8">
                                <c:choose>
                                    <c:when test="${empty reviews}">
                                        <p class="text-body-md text-secondary italic text-center py-8">No reviews yet. Be the first to review!</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="r" items="${reviews}">
                                            <div class="review-item bg-surface-container-low p-8 rounded-3xl"
                                                data-rating="${r.rating}">
                                                <div class="flex items-center justify-between mb-4">
                                                    <span class="font-headline-sm text-headline-sm font-bold text-primary">
                                                        <c:out value="${r.userName}" />
                                                    </span>
                                                    <span class="text-primary tracking-widest text-xl leading-none">
                                                        <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                                        <c:forEach begin="${r.rating + 1}" end="5"><span
                                                                class="text-outline-variant">★</span></c:forEach>
                                                    </span>
                                                </div>
                                                <p class="text-body-lg text-secondary leading-relaxed">
                                                    <c:out value="${r.comment}" />
                                                </p>

                                                <c:if test="${r.updated}">
                                                    <div
                                                        class="mt-6 p-4 bg-surface-container rounded-2xl border-l-4 border-outline-variant">
                                                        <p class="text-label-sm font-label-sm text-secondary mb-2 uppercase tracking-widest">Previous
                                                            Comment:</p>
                                                        <p class="text-body-md text-on-surface-variant italic">
                                                            <c:out value="${r.previousComment}" />
                                                        </p>
                                                    </div>
                                                </c:if>

                                                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mt-6 gap-2">
                                                    <span class="text-label-sm font-label-sm text-secondary">Created:
                                                        <fmt:formatDate value="${r.createdAt}"
                                                            pattern="dd MMM yyyy, HH:mm" />
                                                    </span>
                                                    <c:if test="${r.updated}">
                                                        <span class="text-label-sm font-label-sm text-primary italic">Updated:
                                                            <fmt:formatDate value="${r.updatedAt}"
                                                                pattern="dd MMM yyyy, HH:mm" />
                                                        </span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div> <!-- End of Reviews Section -->

                    </div> <!-- End of max-w-container-max -->

                    <script>
                            document.querySelectorAll('.review-filter-btn').forEach(btn => {
                                btn.addEventListener('click', function () {
                                    // Update active button styling
                                    document.querySelectorAll('.review-filter-btn').forEach(b => {
                                        b.classList.remove('bg-primary', 'text-on-primary', 'font-semibold', 'border-transparent');
                                        b.classList.add('border-outline-variant', 'text-primary');
                                    });
                                    this.classList.remove('border-outline-variant', 'text-primary');
                                    this.classList.add('bg-primary', 'text-on-primary', 'font-semibold', 'border-transparent');

                                    const rating = this.getAttribute('data-rating');
                                    document.querySelectorAll('.review-item').forEach(item => {
                                        if (rating === 'all' || item.getAttribute('data-rating') === rating) {
                                            item.style.display = 'block';
                                        } else {
                                            item.style.display = 'none';
                                        }
                                    });
                                });
                            });
                        </script>

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

                            const stockInfo = document.getElementById("stockInfo");
                            const addBtn = document.getElementById("addToCartBtn");
                            const sizeBtns = document.querySelectorAll('.size-btn');
                            const colorBtns = document.querySelectorAll('.color-btn');

                            let selectedSize = null;
                            let selectedColor = null;

                            function updateUI() {
                                // Update Size buttons
                                sizeBtns.forEach(btn => {
                                    const size = btn.getAttribute('data-size');
                                    let isAvailable = false;
                                    
                                    if (selectedColor) {
                                        const v = variants.find(x => x.color.trim() === selectedColor.trim() && x.size.trim() === size.trim());
                                        isAvailable = v && v.stock > 0;
                                    } else {
                                        isAvailable = variants.some(x => x.size.trim() === size.trim() && x.stock > 0);
                                    }
                                    
                                    if (!isAvailable) {
                                        btn.classList.add('opacity-40', 'bg-surface-container', 'cursor-not-allowed', 'border-outline-variant');
                                        btn.classList.remove('hover:border-primary', 'border-primary', 'text-on-primary', 'bg-primary', 'text-primary');
                                    } else {
                                        btn.classList.remove('opacity-40', 'bg-surface-container', 'cursor-not-allowed');
                                        btn.classList.add('hover:border-primary');
                                        
                                        if (selectedSize === size) {
                                            btn.classList.add('border-primary', 'text-on-primary', 'bg-primary');
                                            btn.classList.remove('text-primary', 'border-outline-variant');
                                        } else {
                                            btn.classList.remove('border-primary', 'text-on-primary', 'bg-primary');
                                            btn.classList.add('text-primary', 'border-outline-variant');
                                        }
                                    }
                                });

                                // Update Color buttons
                                colorBtns.forEach(btn => {
                                    const color = btn.getAttribute('data-color');
                                    let isAvailable = false;
                                    
                                    if (selectedSize) {
                                        const v = variants.find(x => x.size.trim() === selectedSize.trim() && x.color.trim() === color.trim());
                                        isAvailable = v && v.stock > 0;
                                    } else {
                                        isAvailable = variants.some(x => x.color.trim() === color.trim() && x.stock > 0);
                                    }
                                    
                                    if (!isAvailable) {
                                        btn.classList.add('opacity-40', 'bg-surface-container', 'cursor-not-allowed', 'border-outline-variant');
                                        btn.classList.remove('hover:border-primary', 'border-primary', 'text-on-primary', 'bg-primary', 'text-primary');
                                    } else {
                                        btn.classList.remove('opacity-40', 'bg-surface-container', 'cursor-not-allowed');
                                        btn.classList.add('hover:border-primary');
                                        
                                        if (selectedColor === color) {
                                            btn.classList.add('border-primary', 'text-on-primary', 'bg-primary');
                                            btn.classList.remove('text-primary', 'border-outline-variant');
                                        } else {
                                            btn.classList.remove('border-primary', 'text-on-primary', 'bg-primary');
                                            btn.classList.add('text-primary', 'border-outline-variant');
                                        }
                                    }
                                });

                                // Check valid variant to add to cart
                                if (selectedSize && selectedColor) {
                                    const v = variants.find(x => x.size.trim() === selectedSize.trim() && x.color.trim() === selectedColor.trim());
                                    if (v && v.stock > 0) {
                                        stockInfo.innerHTML = `<span class="text-green-600">Available: ${v.stock} items</span>`;
                                        const variantIdField = document.getElementById("selectedVariantId");
                                        if (variantIdField) variantIdField.value = v.id;
                                        if (addBtn) addBtn.disabled = false;
                                    } else {
                                        stockInfo.innerHTML = `<span class="text-red-500">Out Of Stock</span>`;
                                        if (addBtn) addBtn.disabled = true;
                                    }
                                } else {
                                    stockInfo.innerHTML = "";
                                    if (addBtn) addBtn.disabled = true;
                                }
                            }

                            sizeBtns.forEach(btn => {
                                btn.addEventListener('click', () => {
                                    if (btn.classList.contains('cursor-not-allowed')) return;
                                    const size = btn.getAttribute('data-size');
                                    if (selectedSize && selectedSize.trim() === size.trim()) {
                                        selectedSize = null;
                                    } else {
                                        selectedSize = size;
                                    }
                                    updateUI();
                                });
                            });

                            colorBtns.forEach(btn => {
                                btn.addEventListener('click', () => {
                                    if (btn.classList.contains('cursor-not-allowed')) return;
                                    const color = btn.getAttribute('data-color');
                                    if (selectedColor && selectedColor.trim() === color.trim()) {
                                        selectedColor = null;
                                    } else {
                                        selectedColor = color;
                                    }
                                    updateUI();
                                });
                            });

                            // Initial call
                            updateUI();
                        </script>
                </div>
            </main>

            <jsp:include page="/WEB-INF/include/footer.jsp" />

