<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis Admin - Dashboard</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .main-content { margin-left: 256px; }
    </style>
</head>
<body class="bg-[#f9f9f9] text-[#1a1c1c] antialiased flex min-h-screen">

    <c:set var="activePage" value="dashboard" scope="request" />
    <jsp:include page="/views/admin/sidebar.jsp" />

    <main class="main-content flex-1 flex flex-col min-h-screen">
        <!-- Header -->
        <header class="px-16 pt-16 pb-8 border-b border-gray-200 bg-white">
            <h2 class="text-3xl font-bold tracking-tight">Management Panel</h2>
            <p class="text-gray-500 mt-2">Business intelligence and sales performance analytics.</p>
        </header>

        <div class="px-16 py-8 space-y-8">
            <!-- Stats Row -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 border border-gray-200 rounded-lg shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-wider text-gray-400 mb-2">Monthly Revenue</p>
                    <p class="text-2xl font-extrabold"><fmt:formatNumber value="${monthlyRevenue}" pattern="#,##0"/> ð</p>
                </div>
                <div class="bg-white p-6 border border-gray-200 rounded-lg shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-wider text-gray-400 mb-2">Monthly Cost</p>
                    <p class="text-2xl font-extrabold"><fmt:formatNumber value="${monthlyCost}" pattern="#,##0"/> ð</p>
                </div>
                <div class="bg-white p-6 border border-gray-200 rounded-lg shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-wider text-gray-400 mb-2">Success Rate</p>
                    <p class="text-2xl font-extrabold"><fmt:formatNumber value="${successRate}" maxFractionDigits="1"/>%</p>
                </div>
            </div>

            <!-- Charts Row -->
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <div class="lg:col-span-2 bg-white p-6 border border-gray-200 rounded-lg shadow-sm">
                    <h3 class="text-xs font-bold uppercase tracking-widest text-gray-500 mb-6">Revenue vs Cost (Last 6 Months)</h3>
                    <div class="h-[300px]">
                        <canvas id="revenueCostChart"></canvas>
                    </div>
                </div>
                <div class="bg-white p-6 border border-gray-200 rounded-lg shadow-sm flex flex-col items-center">
                    <h3 class="text-xs font-bold uppercase tracking-widest text-gray-500 mb-6 w-full">Order Performance</h3>
                    <div class="relative w-full aspect-square flex items-center justify-center max-w-[240px]">
                        <canvas id="successGauge"></canvas>
                        <div class="absolute inset-0 flex items-center justify-center">
                            <span class="text-3xl font-black"><fmt:formatNumber value="${successRate}" maxFractionDigits="0"/>%</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Top Selling Table -->
            <div class="bg-white border border-gray-200 rounded-lg shadow-sm overflow-hidden">
                <div class="px-6 py-4 border-b border-gray-100 bg-gray-50">
                    <h3 class="text-xs font-bold uppercase tracking-widest text-gray-500">Monthly Best Sellers</h3>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full text-left">
                        <thead class="bg-white text-[10px] font-bold uppercase tracking-wider text-gray-400">
                            <tr>
                                <th class="px-6 py-4">Month/Year</th>
                                <th class="px-6 py-4">Product</th>
                                <th class="px-6 py-4 text-center">Variant Details</th>
                                <th class="px-6 py-4 text-right">Units Sold</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach items="${topSellingItems}" var="item">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="px-6 py-4 text-sm font-medium text-gray-500">${item.month}</td>
                                    <td class="px-6 py-4 text-sm font-bold text-gray-900">${item.productName}</td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded bg-gray-100 text-[10px] font-bold text-gray-600 mr-2 uppercase">Size: ${item.size}</span>
                                        <span class="inline-flex items-center px-2 py-0.5 rounded bg-gray-100 text-[10px] font-bold text-gray-600 uppercase">Color: ${item.color}</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-right font-black">${item.totalSold}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty topSellingItems}">
                                <tr>
                                    <td colspan="4" class="px-6 py-20 text-center text-gray-400 italic">No sales data recorded yet.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Data from server
        const months = [];
        const revenueData = [];
        const costData = [];
        <c:forEach items="${chartData}" var="row">
            months.push('${row.month}');
            revenueData.push(${row.revenue});
            costData.push(${row.cost});
        </c:forEach>

        // Revenue vs Cost Chart
        new Chart(document.getElementById('revenueCostChart'), {
            type: 'bar',
            data: {
                labels: months,
                datasets: [
                    { label: 'Revenue', data: revenueData, backgroundColor: '#000000', borderRadius: 4 },
                    { label: 'Cost', data: costData, backgroundColor: '#E5E7EB', borderRadius: 4 }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: { beginAtZero: true, grid: { display: false }, ticks: { font: { size: 10 } } },
                    x: { grid: { display: false }, ticks: { font: { size: 10 } } }
                },
                plugins: {
                    legend: { position: 'bottom', labels: { boxWidth: 12, font: { size: 10, weight: 'bold' } } }
                }
            }
        });

        // Success Doughnut (Full Circle)
        const successRate = ${successRate};
        new Chart(document.getElementById('successGauge'), {
            type: 'doughnut',
            data: {
                datasets: [{
                    data: [successRate, 100 - successRate],
                    backgroundColor: ['#000000', '#F3F4F6'],
                    borderWidth: 0
                }]
            },
            options: {
                cutout: '85%',
                responsive: true,
                maintainAspectRatio: true,
                plugins: { legend: { display: false }, tooltip: { enabled: false } }
            }
        });
    </script>
</body>
</html>

