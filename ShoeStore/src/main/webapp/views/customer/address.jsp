<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp" />

<main class="pt-28 pb-20 px-4 min-h-screen bg-gray-50">

    <div class="max-w-5xl mx-auto">

        <!-- Back To Profile -->
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/profile"
               class="inline-flex items-center gap-2 border border-black px-5 py-3 uppercase text-sm font-semibold hover:bg-black hover:text-white transition-all">

                <span class="material-symbols-outlined text-[18px]">
                    arrow_back
                </span>

                Back To Profile
            </a>
        </div>

        <!-- Page Header -->
        <div class="text-center mb-10">

            <h1 class="text-4xl font-bold uppercase tracking-wider text-black mb-3">
                My Addresses
            </h1>

            <p class="text-gray-600 text-lg">
                Manage your shipping addresses
            </p>

        </div>

        <!-- Address Container -->
        <div class="bg-white border border-gray-200 rounded-2xl shadow-lg p-8">

            <!-- Header -->
            <div class="flex flex-col md:flex-row md:justify-between md:items-center gap-4 mb-8 border-b border-gray-200 pb-5">

                <h2 class="text-2xl font-bold uppercase flex items-center gap-2">

                    <span class="material-symbols-outlined text-[28px]">
                        location_on
                    </span>

                    My Addresses

                </h2>

                <a href="${pageContext.request.contextPath}/AddAddress"
                   class="inline-flex items-center justify-center gap-2 bg-black text-white px-6 py-3 rounded-lg uppercase font-semibold hover:opacity-90 transition-all">

                    <span class="material-symbols-outlined text-[18px]">
                        add
                    </span>

                    Add Address

                </a>

            </div>

            <!-- Address List -->
            <c:choose>

                <c:when test="${empty addresses}">

                    <div class="border-2 border-dashed border-gray-300 rounded-xl py-16 flex flex-col items-center justify-center">

                        <span class="material-symbols-outlined text-[64px] text-gray-400 mb-4">
                            location_off
                        </span>

                        <h3 class="text-xl font-semibold text-gray-700 mb-2">
                            No Address Found
                        </h3>

                        <p class="text-gray-500">
                            You haven't added any shipping address yet.
                        </p>

                    </div>

                </c:when>

                <c:otherwise>

                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

                        <c:forEach var="address" items="${addresses}">

                            <div
                                class="bg-white border border-gray-200 rounded-xl p-6 shadow-sm hover:shadow-xl hover:-translate-y-1 transition-all duration-300 flex flex-col justify-between">

                                <!-- Address Info -->
                                <div>

                                    <div class="flex items-center gap-2 mb-4">

                                        <span class="material-symbols-outlined text-gray-700">
                                            home_pin
                                        </span>

                                        <h3 class="font-bold text-lg uppercase">
                                            Delivery Address
                                        </h3>

                                    </div>

                                    <p class="font-semibold text-black mb-2">
                                        ${address.addressLine}
                                    </p>

                                    <p class="text-gray-600">
                                        ${address.ward}, ${address.district}
                                    </p>

                                    <p class="text-gray-600">
                                        ${address.city}
                                    </p>

                                </div>

                                <!-- Actions -->
                                <div class="flex items-center gap-6 mt-6 pt-4 border-t border-gray-200">

                                    <a href="${pageContext.request.contextPath}/EditAddress?id=${address.id}"
                                       class="inline-flex items-center gap-1 text-blue-600 hover:text-blue-800 font-medium uppercase text-sm">

                                        <span class="material-symbols-outlined text-[18px]">
                                            edit
                                        </span>

                                        Edit

                                    </a>

                                    <a href="${pageContext.request.contextPath}/DeleteAddress?id=${address.id}"
                                       onclick="return confirm('Delete this address?')"
                                       class="inline-flex items-center gap-1 text-red-600 hover:text-red-800 font-medium uppercase text-sm">

                                        <span class="material-symbols-outlined text-[18px]">
                                            delete
                                        </span>

                                        Delete

                                    </a>

                                </div>

                            </div>

                        </c:forEach>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </div>

</main>

<jsp:include page="/WEB-INF/include/footer.jsp" />