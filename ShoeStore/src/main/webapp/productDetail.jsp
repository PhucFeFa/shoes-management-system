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

                <div class="max-w-6xl mx-auto px-6">

                    <!-- Product Detail Card -->
                    <div class="bg-white rounded-2xl shadow-lg border p-10">

                        <div class="grid grid-cols-1 md:grid-cols-2 gap-12">

                            <!-- Product Image -->
                            <div class="flex items-center justify-center">

                                <img src="${product.firstImageUrl}" alt="${product.name}"
                                    class="max-h-[500px] w-auto object-contain">

                            </div>

                            <!-- Product Info -->
                            <div class="flex flex-col justify-center">

                                <h1 class="text-4xl font-bold uppercase mb-2">
                                    ${product.name}
                                </h1>

                                <c:choose>
                                    <c:when test="${not empty reviews}">
                                        <c:set var="totalRating" value="0" />
                                        <c:forEach var="r" items="${reviews}">
                                            <c:set var="totalRating" value="${totalRating + r.rating}" />
                                        </c:forEach>
                                        <c:set var="avgRating" value="${totalRating / reviews.size()}" />
                                        <div class="flex items-center mb-6">
                                            <div
                                                class="relative inline-block text-gray-300 font-bold text-xl mr-2 whitespace-nowrap">
                                                ★★★★★
                                                <div class="absolute top-0 left-0 overflow-hidden text-yellow-500 whitespace-nowrap"
                                                    style="width: ${avgRating / 5 * 100}%;">
                                                    ★★★★★
                                                </div>
                                            </div>
                                            <span class="text-gray-500 font-medium">
                                                <fmt:formatNumber value="${avgRating}" maxFractionDigits="1" /> / 5
                                                (${reviews.size()} reviews)
                                            </span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="flex items-center mb-6">
                                            <div class="text-gray-300 font-bold text-xl mr-2">★★★★★</div>
                                            <span class="text-gray-500 font-medium">No reviews yet</span>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

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
                                        <fmt:formatNumber value="${product.price}" pattern="#,##0"/> đ
                                    </span>

                                </div>

                                <div class="mb-4">
                                    <label class="block font-semibold mb-2">Size</label>
                                    <div class="flex flex-wrap gap-3" id="sizeContainer">
                                        <c:forEach var="size" items="${sizes}">
                                            <button type="button" class="size-btn border-2 border-gray-200 rounded-lg px-5 py-2 font-medium text-gray-700 transition" data-size="${size}">
                                                ${size}
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="mb-6">
                                    <label class="block font-semibold mb-2">Color</label>
                                    <div class="flex flex-wrap gap-3" id="colorContainer">
                                        <c:forEach var="color" items="${colors}">
                                            <button type="button" class="color-btn border-2 border-gray-200 rounded-lg px-5 py-2 font-medium text-gray-700 transition" data-color="${color}">
                                                ${color}
                                            </button>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="mb-6">
                                    <span id="stockInfo" class="font-semibold text-lg"></span>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty sessionScope.currentUser && (sessionScope.currentUser.roleName eq 'Admin' || sessionScope.currentUser.roleName eq 'Staff')}">
                                        <div class="flex flex-col gap-4 mt-4 w-full">
                                            <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4">
                                                <div class="flex">
                                                    <div class="flex-shrink-0">
                                                        <span class="material-symbols-outlined text-yellow-500">warning</span>
                                                    </div>
                                                    <div class="ml-3">
                                                        <p class="text-sm text-yellow-700">
                                                            Admin/Staff accounts are only permitted to view products, not to make purchases.
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="flex items-center gap-6 w-full">
                                                <button class="flex-1 bg-gray-300 text-gray-500 px-8 py-4 rounded-lg cursor-not-allowed font-bold" disabled>
                                                    READ ONLY VIEW
                                                </button>
                                                <a href="${pageContext.request.contextPath}/home" class="flex-1 flex items-center justify-center border border-black px-8 py-4 rounded-lg hover:bg-gray-100 transition font-bold">
                                                    BACK TO PRODUCTS
                                                </a>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="flex items-center gap-6 mt-4">
                                            <form action="${pageContext.request.contextPath}/AddToCart" method="post" class="flex-1">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input type="hidden" id="selectedVariantId" name="variantId">
                                                <input type="hidden" name="returnUrl" value="${pageContext.request.requestURI}?id=${product.id}">
                                                <button id="addToCartBtn" type="submit" class="w-full bg-black text-white px-8 py-4 rounded-lg hover:bg-gray-800 transition disabled:opacity-50" disabled>
                                                    ADD TO CART
                                                </button>
                                            </form>
                                            <a href="${pageContext.request.contextPath}/home" class="flex-1 flex items-center justify-center border border-black px-8 py-4 rounded-lg hover:bg-gray-100 transition">
                                                BACK TO PRODUCTS
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </div>

                        </div>

                        <!-- Reviews Section -->
                        <div class="mt-16 border-t pt-8">
                            <h2 class="text-2xl font-bold mb-6">Customer Reviews</h2>

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
                                                    class="bg-black text-white px-6 py-2 rounded-lg hover:bg-gray-800 transition">Submit
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
                                                                class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700 transition">Update</button>
                                                            <button type="submit" name="action" value="delete"
                                                                class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 transition"
                                                                onclick="return confirm('Are you sure you want to delete this review?');">Delete</button>
                                                        </div>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="bg-white p-4 rounded-lg border border-gray-200 mb-4">
                                                        <p class="text-gray-700 mb-2">
                                                            <c:out value="${myReview.comment}" />
                                                        </p>
                                                        <p class="text-sm text-gray-500 italic mb-4">You have already
                                                            updated this review once.</p>
                                                        <form action="${pageContext.request.contextPath}/review"
                                                            method="POST">
                                                            <input type="hidden" name="productId" value="${product.id}">
                                                            <input type="hidden" name="reviewId" value="${myReview.id}">
                                                            <button type="submit" name="action" value="delete"
                                                                class="bg-red-600 text-white px-6 py-2 rounded-lg hover:bg-red-700 transition"
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
                                <div class="mb-8">
                                    <h3 class="text-lg font-semibold mb-3">Filter Reviews</h3>
                                    <div class="flex flex-wrap gap-2">
                                        <button
                                            class="review-filter-btn px-4 py-2 bg-black text-white rounded-lg text-sm font-semibold transition"
                                            data-rating="all">All</button>
                                        <button
                                            class="review-filter-btn px-4 py-2 border rounded-lg text-sm hover:bg-gray-50 flex items-center gap-1 transition"
                                            data-rating="5">
                                            <span class="text-yellow-500">★★★★★</span> (5)
                                        </button>
                                        <button
                                            class="review-filter-btn px-4 py-2 border rounded-lg text-sm hover:bg-gray-50 flex items-center gap-1 transition"
                                            data-rating="4">
                                            <span class="text-yellow-500">★★★★<span
                                                    class="text-gray-300">★</span></span> (4)
                                        </button>
                                        <button
                                            class="review-filter-btn px-4 py-2 border rounded-lg text-sm hover:bg-gray-50 flex items-center gap-1 transition"
                                            data-rating="3">
                                            <span class="text-yellow-500">★★★<span
                                                    class="text-gray-300">★★</span></span> (3)
                                        </button>
                                        <button
                                            class="review-filter-btn px-4 py-2 border rounded-lg text-sm hover:bg-gray-50 flex items-center gap-1 transition"
                                            data-rating="2">
                                            <span class="text-yellow-500">★★<span
                                                    class="text-gray-300">★★★</span></span> (2)
                                        </button>
                                        <button
                                            class="review-filter-btn px-4 py-2 border rounded-lg text-sm hover:bg-gray-50 flex items-center gap-1 transition"
                                            data-rating="1">
                                            <span class="text-yellow-500">★<span
                                                    class="text-gray-300">★★★★</span></span> (1)
                                        </button>
                                    </div>
                                </div>
                            </c:if>

                            <!-- List of Reviews -->
                            <div class="space-y-6">
                                <c:choose>
                                    <c:when test="${empty reviews}">
                                        <p class="text-gray-500 italic">No reviews yet. Be the first to review!</p>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="r" items="${reviews}">
                                            <div class="review-item bg-gray-50 p-6 rounded-lg border shadow-sm"
                                                data-rating="${r.rating}">
                                                <div class="flex items-center justify-between mb-2">
                                                    <span class="font-bold text-lg">
                                                        <c:out value="${r.userName}" />
                                                    </span>
                                                    <span class="text-yellow-500 font-bold text-xl">
                                                        <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                                                        <c:forEach begin="${r.rating + 1}" end="5"><span
                                                                class="text-gray-300">★</span></c:forEach>
                                                    </span>
                                                </div>
                                                <p class="text-gray-700 mt-2 text-lg">
                                                    <c:out value="${r.comment}" />
                                                </p>

                                                <c:if test="${r.updated}">
                                                    <div
                                                        class="mt-3 p-3 bg-gray-100 rounded border-l-4 border-gray-300">
                                                        <p class="text-xs text-gray-500 font-semibold mb-1">Previous
                                                            Comment:</p>
                                                        <p class="text-sm text-gray-400 italic">
                                                            <c:out value="${r.previousComment}" />
                                                        </p>
                                                    </div>
                                                </c:if>

                                                <div class="flex justify-between items-center mt-4">
                                                    <span class="text-xs text-gray-400">Created:
                                                        <fmt:formatDate value="${r.createdAt}"
                                                            pattern="dd MMM yyyy, HH:mm" />
                                                    </span>
                                                    <c:if test="${r.updated}">
                                                        <span class="text-xs text-blue-400 italic">Updated:
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
                        </div>

                        <script>
                            document.querySelectorAll('.review-filter-btn').forEach(btn => {
                                btn.addEventListener('click', function () {
                                    // Update active button styling
                                    document.querySelectorAll('.review-filter-btn').forEach(b => {
                                        b.classList.remove('bg-black', 'text-white', 'font-semibold');
                                        b.classList.add('border');
                                    });
                                    this.classList.remove('border');
                                    this.classList.add('bg-black', 'text-white', 'font-semibold');

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
                                        const v = variants.find(x => x.color === selectedColor && x.size === size);
                                        isAvailable = v && v.stock > 0;
                                    } else {
                                        isAvailable = variants.some(x => x.size === size && x.stock > 0);
                                    }
                                    
                                    if (!isAvailable) {
                                        btn.classList.add('opacity-40', 'bg-gray-100', 'cursor-not-allowed', 'border-gray-200');
                                        btn.classList.remove('hover:border-black', 'border-black', 'text-white', 'bg-black');
                                    } else {
                                        btn.classList.remove('opacity-40', 'bg-gray-100', 'cursor-not-allowed');
                                        btn.classList.add('hover:border-black');
                                        
                                        if (selectedSize === size) {
                                            btn.classList.add('border-black', 'text-white', 'bg-black');
                                            btn.classList.remove('text-gray-700', 'border-gray-200');
                                        } else {
                                            btn.classList.remove('border-black', 'text-white', 'bg-black');
                                            btn.classList.add('text-gray-700', 'border-gray-200');
                                        }
                                    }
                                });

                                // Update Color buttons
                                colorBtns.forEach(btn => {
                                    const color = btn.getAttribute('data-color');
                                    let isAvailable = false;
                                    
                                    if (selectedSize) {
                                        const v = variants.find(x => x.size === selectedSize && x.color === color);
                                        isAvailable = v && v.stock > 0;
                                    } else {
                                        isAvailable = variants.some(x => x.color === color && x.stock > 0);
                                    }
                                    
                                    if (!isAvailable) {
                                        btn.classList.add('opacity-40', 'bg-gray-100', 'cursor-not-allowed', 'border-gray-200');
                                        btn.classList.remove('hover:border-black', 'border-black', 'text-white', 'bg-black');
                                    } else {
                                        btn.classList.remove('opacity-40', 'bg-gray-100', 'cursor-not-allowed');
                                        btn.classList.add('hover:border-black');
                                        
                                        if (selectedColor === color) {
                                            btn.classList.add('border-black', 'text-white', 'bg-black');
                                            btn.classList.remove('text-gray-700', 'border-gray-200');
                                        } else {
                                            btn.classList.remove('border-black', 'text-white', 'bg-black');
                                            btn.classList.add('text-gray-700', 'border-gray-200');
                                        }
                                    }
                                });

                                // Check valid variant to add to cart
                                if (selectedSize && selectedColor) {
                                    const v = variants.find(x => x.size === selectedSize && x.color === selectedColor);
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
                                    if (selectedSize === size) {
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
                                    if (selectedColor === color) {
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
            </main>

            <jsp:include page="/WEB-INF/include/footer.jsp" />