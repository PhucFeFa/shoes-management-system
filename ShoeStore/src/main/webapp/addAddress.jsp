<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<div class="max-w-xl mx-auto mt-24 mb-24 bg-white p-8 shadow-lg rounded-xl">

    <h2 class="text-2xl font-bold mb-6">
        Add New Address
    </h2>

    <!-- Success Message -->
    <% if(request.getAttribute("message") != null){ %>
        <div class="bg-green-100 text-green-700 border border-green-300 p-3 rounded-lg mb-4">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <!-- Error Message -->
    <% if(request.getAttribute("error") != null){ %>
        <div class="bg-red-100 text-red-700 border border-red-300 p-3 rounded-lg mb-4">
            <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <form action="AddAddress" method="post">

        <div class="mb-4">
            <label class="block mb-2 font-medium">
                City
            </label>
            <input type="text"
                   name="city"
                   required
                   class="border border-gray-300 rounded-lg p-3 w-full focus:outline-none focus:ring-2 focus:ring-black">
        </div>

        <div class="mb-4">
            <label class="block mb-2 font-medium">
                District
            </label>
            <input type="text"
                   name="district"
                   required
                   class="border border-gray-300 rounded-lg p-3 w-full focus:outline-none focus:ring-2 focus:ring-black">
        </div>

        <div class="mb-4">
            <label class="block mb-2 font-medium">
                Ward
            </label>
            <input type="text"
                   name="ward"
                   required
                   class="border border-gray-300 rounded-lg p-3 w-full focus:outline-none focus:ring-2 focus:ring-black">
        </div>

        <div class="mb-6">
            <label class="block mb-2 font-medium">
                Address Line
            </label>
            <input type="text"
                   name="addressLine"
                   required
                   class="border border-gray-300 rounded-lg p-3 w-full focus:outline-none focus:ring-2 focus:ring-black">
        </div>

        <div class="flex gap-3">

            <button type="submit"
                    class="bg-black text-white px-6 py-3 rounded-lg hover:bg-gray-800 transition">
                Add Address
            </button>

            <a href="${pageContext.request.contextPath}/profile/addresses"
               class="border border-gray-400 text-gray-700 px-6 py-3 rounded-lg hover:bg-gray-100 transition">
                Back
            </a>

        </div>

    </form>

</div>

<jsp:include page="/WEB-INF/include/footer.jsp"/>