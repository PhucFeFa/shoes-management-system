<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis - Import Requests</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .main-content { margin-left: 220px; }
    </style>
</head>
<body class="bg-[#f9f9f9] text-[#1a1c1c] antialiased flex min-h-screen">

    <c:set var="activePage" value="import-requests" scope="request" />
    <jsp:include page="/views/staff/sidebar.jsp" />

    <main class="main-content flex-1 flex flex-col min-h-screen">
        <header class="px-16 pt-16 pb-8 flex justify-between items-end border-b border-gray-200">
            <div>
                <h2 class="text-3xl font-bold tracking-tight">Import Requests</h2>
                <p class="text-gray-500 mt-2">Track your stock replenishment requests and their status.</p>
            </div>
            <div class="flex gap-4">
                <a href="${pageContext.request.contextPath}/staff/create-import" 
                   class="px-6 py-3 bg-black text-white font-semibold uppercase text-xs rounded-lg hover:bg-gray-800 transition-colors flex items-center gap-2">
                    <span class="material-symbols-outlined text-[18px]">add</span>
                    New Request
                </a>
            </div>
        </header>

        <section class="px-16 py-6 flex-1">
            <!-- Success Message -->
            <c:if test="${param.success eq 'true' or param.msg eq 'success'}">
                <div class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-700 text-sm flex items-center gap-3">
                    <span class="material-symbols-outlined">check_circle</span>
                    Your import request has been submitted successfully and is now pending admin approval.
                </div>
            </c:if>

            <div class="border border-gray-200 bg-white overflow-hidden shadow-sm rounded-lg">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-gray-50 border-b border-gray-200">
                        <tr>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">ID</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Supplier</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Date</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-right">Total Amount</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Status</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:choose>
                            <c:when test="${empty importRequests}">
                                <tr>
                                    <td colspan="6" class="py-20 text-center text-gray-400">
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="material-symbols-outlined text-5xl opacity-20">inventory_2</span>
                                            <p class="font-semibold uppercase text-xs tracking-widest">No requests found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="req" items="${importRequests}">
                                    <tr class="hover:bg-gray-50 transition-colors group">
                                        <td class="py-4 px-6 font-bold text-sm">#<c:out value="${req.importID}"/></td>
                                        <td class="py-4 px-6 text-sm"><c:out value="${req.supplier}"/></td>
                                        <td class="py-4 px-6 text-sm text-gray-500">
                                            <fmt:formatDate value="${req.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td class="py-4 px-6 text-sm text-right font-semibold">
                                            <fmt:formatNumber value="${req.totalAmount}" pattern="#,##0"/> đ
                                        </td>
                                        <td class="py-4 px-6">
                                            <c:set var="statusClass" value=""/>
                                            <c:choose>
                                                <c:when test="${req.status == 'REQUESTING'}"><c:set var="statusClass" value="bg-blue-100 text-blue-700"/></c:when>
                                                <c:when test="${req.status == 'APPROVED'}"><c:set var="statusClass" value="bg-yellow-100 text-yellow-700"/></c:when>
                                                <c:when test="${req.status == 'REPORTED'}"><c:set var="statusClass" value="bg-purple-100 text-purple-700"/></c:when>
                                                <c:when test="${req.status == 'ACCEPTED'}"><c:set var="statusClass" value="bg-green-100 text-green-700"/></c:when>
                                                <c:when test="${req.status == 'COMPLETE'}"><c:set var="statusClass" value="bg-gray-900 text-white"/></c:when>
                                                <c:when test="${req.status == 'CANCELLED'}"><c:set var="statusClass" value="bg-red-100 text-red-700"/></c:when>
                                                <c:otherwise><c:set var="statusClass" value="bg-gray-100 text-gray-700"/></c:otherwise>
                                            </c:choose>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-bold uppercase tracking-wider ${statusClass}">
                                                <c:out value="${req.status}"/>
                                            </span>
                                        </td>
                                        <td class="py-4 px-6 text-center">
                                            <a href="${pageContext.request.contextPath}/staff/import-detail?id=${req.importID}" 
                                               class="inline-flex items-center px-4 py-1.5 border border-black text-[10px] font-bold uppercase tracking-widest text-black hover:bg-black hover:text-white transition-all rounded">
                                                Detail
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</body>
</html>
