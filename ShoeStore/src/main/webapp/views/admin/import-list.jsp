<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis Admin - Import Management</title>
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

    <c:set var="activePage" value="import" scope="request" />
    <jsp:include page="/views/admin/sidebar.jsp" />

    <main class="main-content flex-1 flex flex-col min-h-screen">
        <header class="px-16 pt-16 pb-8 flex justify-between items-end border-b border-gray-200 bg-white">
            <div>
                <h2 class="text-3xl font-bold tracking-tight">Confirm Import</h2>
                <p class="text-gray-500 mt-2">Manage and approve stock replenishment requests from staff.</p>
            </div>
        </header>

        <section class="px-16 py-6 flex-1">
            <div class="border border-gray-200 bg-white overflow-hidden shadow-sm rounded-lg">
                <table class="w-full text-left border-collapse">
                    <thead class="bg-gray-50 border-b border-gray-200">
                        <tr>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">ID</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Staff</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Supplier</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Date</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-right">Total Amount</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Status</th>
                            <th class="py-4 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:choose>
                            <c:when test="${empty importList}">
                                <tr>
                                    <td colspan="7" class="py-20 text-center text-gray-400">
                                        <div class="flex flex-col items-center gap-2">
                                            <span class="material-symbols-outlined text-5xl opacity-20">local_shipping</span>
                                            <p class="font-semibold uppercase text-xs tracking-widest">No import requests found</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="item" items="${importList}">
                                    <tr class="hover:bg-gray-50 transition-colors">
                                        <td class="py-4 px-6 font-bold text-sm">#<c:out value="${item.importID}"/></td>
                                        <td class="py-4 px-6 text-sm"><c:out value="${item.staffName}"/></td>
                                        <td class="py-4 px-6 text-sm"><c:out value="${item.supplier}"/></td>
                                        <td class="py-4 px-6 text-sm text-center text-gray-500">
                                            <fmt:formatDate value="${item.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </td>
                                        <td class="py-4 px-6 text-sm text-right font-semibold">
                                            <fmt:formatNumber value="${item.totalAmount}" pattern="#,##0"/> đ
                                        </td>
                                        <td class="py-4 px-6 text-center">
                                            <c:set var="statusClass" value=""/>
                                            <c:choose>
                                                <c:when test="${item.status == 'REQUESTING'}"><c:set var="statusClass" value="bg-blue-100 text-blue-700"/></c:when>
                                                <c:when test="${item.status == 'APPROVED'}"><c:set var="statusClass" value="bg-yellow-100 text-yellow-700"/></c:when>
                                                <c:when test="${item.status == 'REPORTED'}"><c:set var="statusClass" value="bg-purple-100 text-purple-700"/></c:when>
                                                <c:when test="${item.status == 'ACCEPTED'}"><c:set var="statusClass" value="bg-green-100 text-green-700"/></c:when>
                                                <c:when test="${item.status == 'COMPLETE'}"><c:set var="statusClass" value="bg-gray-900 text-white"/></c:when>
                                                <c:when test="${item.status == 'CANCELLED'}"><c:set var="statusClass" value="bg-red-100 text-red-700"/></c:when>
                                                <c:otherwise><c:set var="statusClass" value="bg-gray-100 text-gray-700"/></c:otherwise>
                                            </c:choose>
                                            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[10px] font-bold uppercase tracking-wider ${statusClass}">
                                                <c:out value="${item.status}"/>
                                            </span>
                                        </td>
                                        <td class="py-4 px-6 text-center">
                                            <a href="${pageContext.request.contextPath}/admin/import-detail?id=${item.importID}" 
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
