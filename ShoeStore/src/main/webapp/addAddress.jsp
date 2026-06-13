<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/WEB-INF/include/header.jsp"/>

<div class="max-w-3xl mx-auto mt-24 mb-16 px-6">

    <div class="bg-white shadow-lg rounded-xl p-8">

        <h1 class="text-3xl font-bold mb-2">
            Add New Address
        </h1>

        <p class="text-gray-500 mb-8">
            Enter your shipping address information.
        </p>

        <!-- Success Message -->
        <% String message = (String) request.getAttribute("message"); %>
        <% if(message != null){ %>
            <div class="mb-6 p-4 rounded bg-green-100 text-green-700 border border-green-300">
                <%= message %>
            </div>
        <% } %>

        <!-- Error Message -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if(error != null){ %>
            <div class="mb-6 p-4 rounded bg-red-100 text-red-700 border border-red-300">
                <%= error %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/AddAddressServlet"
              method="post"
              class="space-y-6">

            <div>
                <label class="block text-sm font-semibold mb-2">
                    City
                </label>
                <input
                    type="text"
                    name="city"
                    required
                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-black">
            </div>

            <div>
                <label class="block text-sm font-semibold mb-2">
                    District
                </label>
                <input
                    type="text"
                    name="district"
                    required
                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-black">
            </div>

            <div>
                <label class="block text-sm font-semibold mb-2">
                    Ward
                </label>
                <input
                    type="text"
                    name="ward"
                    required
                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-black">
            </div>

            <div>
                <label class="block text-sm font-semibold mb-2">
                    Address Line
                </label>
                <textarea
                    name="addressLine"
                    rows="3"
                    required
                    class="w-full border border-gray-300 rounded-lg px-4 py-3 focus:outline-none focus:ring-2 focus:ring-black"></textarea>
            </div>

            <div class="flex gap-4">

                <button
                    type="submit"
                    class="bg-black text-white px-6 py-3 rounded-lg hover:bg-gray-800 transition">
                    Add Address
                </button>

                <a href="${pageContext.request.contextPath}/profile"
                   class="bg-gray-200 text-black px-6 py-3 rounded-lg hover:bg-gray-300 transition">
                    Back to Profile
                </a>

            </div>

        </form>

    </div>

</div>

<jsp:include page="/WEB-INF/include/footer.jsp"/>