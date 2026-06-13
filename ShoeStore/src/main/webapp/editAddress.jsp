<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<div class="max-w-xl mx-auto mt-24 bg-white p-8 shadow rounded">

    <h2 class="text-2xl font-bold mb-6">
        Update Address
    </h2>

    <form action="EditAddressServlet" method="post">

        <input type="hidden"
               name="id"
               value="${address.id}"/>

        <input type="text"
               name="city"
               value="${address.city}"
               class="border p-2 w-full mb-4">

        <input type="text"
               name="district"
               value="${address.district}"
               class="border p-2 w-full mb-4">

        <input type="text"
               name="ward"
               value="${address.ward}"
               class="border p-2 w-full mb-4">

        <input type="text"
               name="addressLine"
               value="${address.addressLine}"
               class="border p-2 w-full mb-4">

        <button type="submit"
                class="bg-black text-white px-6 py-3 rounded">
            Update Address
        </button>
        <a href="profile.jsp"
           class="border border-gray-400 text-gray-700 px-6 py-3 rounded hover:bg-gray-100">
            Back
        </a>

    </form>

</div>

<jsp:include page="/WEB-INF/include/footer.jsp"/>