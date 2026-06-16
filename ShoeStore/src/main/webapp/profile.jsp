<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<div class="max-w-5xl mx-auto mt-24 p-8">

    <!-- User Information -->
    <div class="bg-white shadow-lg rounded-xl p-6 mb-8">

        <h2 class="text-2xl font-bold mb-4">
            My Profile
        </h2>

        <p>
            <strong>Username:</strong>
            ${sessionScope.currentUser.fullName}
        </p>

        <p>
            <strong>Email:</strong>
            ${sessionScope.currentUser.email}
        </p>

    </div>

    <!-- Add Address Button -->
    <div class="mb-6">
        <a href="${pageContext.request.contextPath}/AddAddress"
           class="bg-black text-white px-6 py-3 rounded-lg hover:bg-gray-800">
            Add Address
        </a>
    </div>

    <!-- Address List -->
    <div class="bg-white shadow-lg rounded-xl p-6">

        <h2 class="text-2xl font-bold mb-6">
            My Addresses
        </h2>

        <c:if test="${empty addresses}">
            <p class="text-gray-500">
                No address found.
            </p>
        </c:if>

        <c:forEach var="address" items="${addresses}">

            <div class="border rounded-lg p-4 mb-4">

                <div class="flex justify-between items-center">

                    <div>
                        <p class="font-semibold">
                            ${address.addressLine}
                        </p>

                        <p class="text-gray-600">
                            ${address.ward},
                            ${address.district},
                            ${address.city}
                        </p>
                    </div>

                    <div class="flex gap-4">

                        <a href="${pageContext.request.contextPath}/EditAddress?id=${address.id}"
                           class="text-blue-600 text-xl"
                           title="Edit">
                            ✏️
                        </a>

                        <a href="${pageContext.request.contextPath}/DeleteAddress?id=${address.id}"
                           onclick="return confirm('Delete this address?')"
                           class="text-red-600 text-xl"
                           title="Delete">
                            🗑️
                        </a>

                    </div>

                </div>

            </div>

        </c:forEach>

    </div>

</div>

<jsp:include page="/WEB-INF/include/footer.jsp"/>