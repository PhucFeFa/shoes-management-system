<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis - Import Request Detail</title>
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

</head>
<body class="bg-[#f9f9f9] text-[#1a1c1c] antialiased flex min-h-screen">

    <c:set var="activePage" value="import-requests" scope="request" />
    <jsp:include page="/views/staff/sidebar.jsp" />

    <main class="ml-64 flex-1 flex flex-col min-h-screen">
        <header class="px-16 pt-16 pb-8 flex justify-between items-end border-b border-gray-200 bg-white">
            <div>
                <div class="flex items-center gap-3 mb-2">
                    <h2 class="text-3xl font-bold tracking-tight">Request #<c:out value="${importDetail.importID}"/></h2>
                </div>
                <p class="text-gray-500">Details of your stock replenishment request.</p>
            </div>
            <div class="flex gap-4">
                <c:set var="statusClass" value=""/>
                <c:choose>
                    <c:when test="${importDetail.status == 'REQUESTING'}"><c:set var="statusClass" value="bg-blue-100 text-blue-700"/></c:when>
                    <c:when test="${importDetail.status == 'APPROVED'}"><c:set var="statusClass" value="bg-yellow-100 text-yellow-700"/></c:when>
                    <c:when test="${importDetail.status == 'REPORTED'}"><c:set var="statusClass" value="bg-purple-100 text-purple-700"/></c:when>
                    <c:when test="${importDetail.status == 'ACCEPTED'}"><c:set var="statusClass" value="bg-green-100 text-green-700"/></c:when>
                    <c:when test="${importDetail.status == 'COMPLETE'}"><c:set var="statusClass" value="bg-gray-900 text-white"/></c:when>
                    <c:when test="${importDetail.status == 'CANCELLED'}"><c:set var="statusClass" value="bg-red-100 text-red-700"/></c:when>
                    <c:otherwise><c:set var="statusClass" value="bg-gray-100 text-gray-700"/></c:otherwise>
                </c:choose>
                <span class="px-4 py-2 rounded-full text-xs font-bold uppercase tracking-widest ${statusClass}">
                    <c:out value="${importDetail.status}"/>
                </span>
            </div>
        </header>

        <div class="px-16 py-10 space-y-8">
            <c:if test="${not empty error}">
                <div class="p-4 bg-red-50 border-l-4 border-red-500 text-red-700 text-sm">
                    <c:out value="${error}"/>
                </div>
            </c:if>

            <!-- Info Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-widest text-gray-400 mb-2">Supplier</p>
                    <p class="font-bold text-lg text-gray-900"><c:out value="${importDetail.supplier}"/></p>
                </div>
                <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-widest text-gray-400 mb-2">Request Date</p>
                    <p class="font-bold text-lg text-gray-900">
                        <fmt:formatDate value="${importDetail.orderDate}" pattern="dd MMM yyyy, HH:mm" timeZone="Asia/Ho_Chi_Minh"/>
                    </p>
                </div>
                <div class="bg-white p-6 rounded-2xl border border-gray-200 shadow-sm">
                    <p class="text-[10px] font-bold uppercase tracking-widest text-gray-400 mb-2">Requested By</p>
                    <p class="font-bold text-lg text-gray-900"><c:out value="${importDetail.staffName}"/></p>
                </div>
            </div>

            <!-- Admin Note -->
            <c:if test="${not empty importDetail.note}">
                <div class="bg-gray-50 p-6 rounded-2xl border-l-4 border-gray-900">
                    <p class="text-[10px] font-bold uppercase tracking-widest text-gray-400 mb-1">Admin Note</p>
                    <p class="text-sm italic text-gray-700">"<c:out value="${importDetail.note}"/>"</p>
                </div>
            </c:if>

            <!-- Items Table -->
            <div class="bg-white border border-gray-200 rounded-2xl shadow-sm overflow-hidden">
                <div class="px-8 py-4 bg-gray-50 border-b border-gray-200">
                    <h3 class="text-[10px] font-bold uppercase tracking-widest text-gray-500">Requested Items</h3>
                </div>
                
                <c:choose>
                    <c:when test="${importDetail.status == 'APPROVED'}">
                        <form action="${pageContext.request.contextPath}/staff/import-detail" method="POST">
                            <input type="hidden" name="action" value="report">
                            <input type="hidden" name="importID" value="${importDetail.importID}">
                            
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr class="border-b border-gray-100">
                                        <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400">Product</th>
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-24 text-center">Size</th>
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-24 text-center">Color</th>
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-28 text-center">Qty Request</th>
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-black w-32 text-center bg-yellow-50">Actual Received</th>
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-40 text-right">Unit Price</th>
                                        <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400 w-48 text-right">Subtotal</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-gray-50">
                                    <c:set var="calculatedTotal" value="0" />
                                    <c:forEach var="item" items="${importDetail.details}">
                                        <c:set var="itemSubtotal" value="${item.unitPrice * item.importQuantity}" />
                                        <c:set var="calculatedTotal" value="${calculatedTotal + itemSubtotal}" />
                                        
                                        <tr>
                                            <td class="py-4 px-8 text-sm font-bold text-gray-900">
                                                <c:out value="${item.productName}"/>
                                                <input type="hidden" name="detailIDs" value="${item.importDetailID}">
                                            </td>
                                            <td class="py-4 px-4 text-sm text-center text-gray-600"><c:out value="${item.size}"/></td>
                                            <td class="py-4 px-4 text-sm text-center text-gray-600"><c:out value="${item.color}"/></td>
                                            <td class="py-4 px-4 text-sm text-center font-bold text-gray-400"><c:out value="${item.importQuantity}"/></td>
                                            
                                            <td class="py-4 px-4 bg-yellow-50/30">
                                                <input type="number" name="receivedQuantities" 
                                                       value="${item.importQuantity}" 
                                                       oninput="updateSubtotal(this, ${item.unitPrice})"
                                                       class="w-full border-gray-200 rounded text-center text-sm focus:ring-black focus:border-black py-1">
                                            </td>

                                            <td class="py-4 px-4 text-sm text-right text-gray-600 whitespace-nowrap">
                                                <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0"/>&nbsp;đ
                                            </td>
                                            <td class="py-4 px-8 text-sm text-right font-bold text-gray-900 item-subtotal-display whitespace-nowrap">
                                                <fmt:formatNumber value="${itemSubtotal}" pattern="#,##0"/>&nbsp;đ
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                                <tfoot>
                                    <tr class="bg-gray-50 border-t border-gray-200">
                                        <td colspan="6" class="py-6 px-8 text-right text-[10px] font-bold uppercase tracking-widest text-gray-500">Total Amount</td>
                                        <td class="py-6 px-8 text-right text-2xl font-extrabold text-gray-900 whitespace-nowrap" id="totalAmountDisplay">
                                            <fmt:formatNumber value="${calculatedTotal}" pattern="#,##0"/>&nbsp;đ
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>

                            <div class="px-8 py-6 bg-gray-50 border-t border-gray-200 flex justify-end">
                                <button type="submit"
                                        class="px-10 py-3 bg-black text-white text-xs font-bold uppercase tracking-widest rounded-full hover:bg-gray-800 transition-all shadow-md active:scale-95">
                                    Submit Arrival Report
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="border-b border-gray-100">
                                    <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400">Product</th>
                                    <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-24 text-center">Size</th>
                                    <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-24 text-center">Color</th>
                                    <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-28 text-center">Qty Request</th>
                                    
                                    <c:if test="${importDetail.status != 'REQUESTING' && importDetail.status != 'CANCELLED'}">
                                        <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-28 text-center">Qty Received</th>
                                    </c:if>

                                    <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-40 text-right">Unit Price</th>
                                    <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400 w-48 text-right">Subtotal</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-50">
                                <c:set var="calculatedTotal" value="0" />
                                <c:forEach var="item" items="${importDetail.details}">
                                    <c:set var="isReported" value="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}" />
                                    <c:set var="displayQty" value="${isReported ? item.receivedQuantity : item.importQuantity}" />
                                    <c:set var="itemSubtotal" value="${item.unitPrice * displayQty}" />
                                    <c:set var="calculatedTotal" value="${calculatedTotal + itemSubtotal}" />
                                    
                                    <tr>
                                        <td class="py-4 px-8 text-sm font-bold text-gray-900">
                                            <c:out value="${item.productName}"/>
                                        </td>
                                        <td class="py-4 px-4 text-sm text-center text-gray-600"><c:out value="${item.size}"/></td>
                                        <td class="py-4 px-4 text-sm text-center text-gray-600"><c:out value="${item.color}"/></td>
                                        <td class="py-4 px-4 text-sm text-center font-bold text-gray-400"><c:out value="${item.importQuantity}"/></td>

                                        <c:if test="${importDetail.status != 'REQUESTING' && importDetail.status != 'CANCELLED'}">
                                            <td class="py-4 px-4 text-sm text-center font-bold text-gray-900"><c:out value="${item.receivedQuantity}"/></td>
                                        </c:if>

                                        <td class="py-4 px-4 text-sm text-right text-gray-600 whitespace-nowrap">
                                            <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0"/>&nbsp;đ
                                        </td>
                                        <td class="py-4 px-8 text-sm text-right font-bold text-gray-900 whitespace-nowrap">
                                            <fmt:formatNumber value="${itemSubtotal}" pattern="#,##0"/>&nbsp;đ
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <tfoot>
                                <tr class="bg-gray-50 border-t border-gray-200">
                                    <td colspan="${importDetail.status != 'REQUESTING' && importDetail.status != 'CANCELLED' ? 6 : 5}" class="py-6 px-8 text-right text-[10px] font-bold uppercase tracking-widest text-gray-500">Total Amount</td>
                                    <td class="py-6 px-8 text-right text-2xl font-extrabold text-gray-900 whitespace-nowrap">
                                        <fmt:formatNumber value="${calculatedTotal}" pattern="#,##0"/>&nbsp;đ
                                    </td>
                                </tr>
                            </tfoot>
                        </table>

                        <c:if test="${importDetail.status == 'ACCEPTED'}">
                            <div class="px-8 py-6 bg-gray-50 border-t border-gray-200 flex justify-end">
                                <form action="${pageContext.request.contextPath}/staff/stock-in" method="POST">
                                    <input type="hidden" name="importID" value="${importDetail.importID}">
                                    <button type="submit" 
                                            class="px-10 py-3 bg-green-600 text-white text-xs font-bold uppercase tracking-widest rounded-full hover:bg-green-700 transition-all shadow-md active:scale-95">
                                        Stock-in 
                                    </button>
                                </form>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <script>
        function updateSubtotal(input, unitPrice) {
            const row = input.closest('tr');
            const subtotalDisplay = row.querySelector('.item-subtotal-display');
            const qty = parseInt(input.value) || 0;
            const subtotal = qty * unitPrice;
            
            subtotalDisplay.innerHTML = new Intl.NumberFormat('vi-VN').format(subtotal) + '&nbsp;đ';
            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            const inputs = document.querySelectorAll('input[name="receivedQuantities"]');
            if (inputs.length > 0) {
                inputs.forEach(input => {
                    const row = input.closest('tr');
                    const subtotalText = row.querySelector('.item-subtotal-display').textContent;
                    const subtotalValue = parseInt(subtotalText.replace(/[^0-9]/g, '')) || 0;
                    total += subtotalValue;
                });
            }
            document.getElementById('totalAmountDisplay').innerHTML = new Intl.NumberFormat('vi-VN').format(total) + '&nbsp;đ';
        }
    </script>
</body>
</html>

