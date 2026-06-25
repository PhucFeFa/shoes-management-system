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
            <main class="pt-32 pb-24 min-h-screen bg-gray-50">

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
                                        $${product.price}
                                    </span>

                                </div>

                                <div class="mb-4">

                                    <label class="block font-semibold mb-2">
                                        Size
                                    </label>

                                    <select id="sizeSelect" class="w-full border rounded-lg px-4 py-3">

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

                                    <select id="colorSelect" class="w-full border rounded-lg px-4 py-3">

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

                                    <form action="${pageContext.request.contextPath}/AddToCart" method="post">

                                        <input type="hidden" name="productId" value="${product.id}">

                                        <input type="hidden" id="selectedVariantId" name="variantId">

                                        <input type="hidden" name="returnUrl"
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

            <jsp:include page="/WEB-INF/include/footer.jsp" />