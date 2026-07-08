<%-- Author: PhucLHCE191132 --%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis Admin - Import Detail</title>
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
                <a href="${pageContext.request.contextPath}/import" class="inline-flex items-center text-sm font-semibold text-gray-500 hover:text-black transition-colors mb-4 uppercase tracking-widest gap-2">
                    <span class="material-symbols-outlined text-lg">arrow_back</span>
                    Back to List
                </a>
                <h2 class="text-3xl font-bold tracking-tight">Request Detail #<c:out value="${importDetail.importID}"/></h2>
                <p class="text-gray-500 mt-2">View details and process stock replenishment request.</p>
            </div>
            
            <div class="flex items-center gap-3">
                <span class="text-sm font-semibold uppercase text-gray-500 tracking-wider">Status:</span>
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
                <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold uppercase tracking-wider ${statusClass}">
                    <c:out value="${importDetail.status}"/>
                </span>
            </div>
        </header>

        <section class="px-16 py-8 flex-1 grid grid-cols-3 gap-8">
            <!-- Left Column: Details & Items -->
            <div class="col-span-2 flex flex-col gap-8">
                
                <c:if test="${not empty error}">
                    <div class="p-4 bg-red-50 border-l-4 border-red-500 text-red-700 font-semibold text-sm flex items-center gap-3 rounded-r-lg">
                        <span class="material-symbols-outlined">error</span>
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <!-- Information Card -->
                <div class="bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm p-6">
                    <h3 class="text-lg font-bold mb-4">Information</h3>
                    <div class="grid grid-cols-2 gap-y-6">
                        <div>
                            <p class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-1">Staff Name</p>
                            <p class="font-medium text-sm"><c:out value="${importDetail.staffName}"/></p>
                        </div>
                        <div>
                            <p class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-1">Supplier</p>
                            <p class="font-medium text-sm"><c:out value="${importDetail.supplier}"/></p>
                        </div>
                        <div>
                            <p class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-1">Order Date</p>
                            <p class="font-medium text-sm">
                                <fmt:formatDate value="${importDetail.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </p>
                        </div>
                        <div>
                            <p class="text-xs font-bold uppercase tracking-widest text-gray-400 mb-1">Total Amount</p>
                            <p class="font-bold text-lg text-black">
                                <fmt:formatNumber value="${importDetail.totalAmount}" pattern="#,##0"/> đ
                            </p>
                        </div>
                    </div>
                </div>

                <!-- Requested Items -->
                <div class="bg-white border border-gray-200 rounded-xl overflow-hidden shadow-sm">
                    <div class="p-6 border-b border-gray-200">
                        <h3 class="text-lg font-bold">Requested Items</h3>
                    </div>
                    <table class="w-full text-left border-collapse">
                        <thead class="bg-gray-50 border-b border-gray-200">
                            <tr>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider">Product</th>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Size</th>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Color</th>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-center">Qty</th>
                                <c:if test="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}">
                                    <th class="py-3 px-6 text-xs font-bold uppercase text-black bg-indigo-50 tracking-wider text-center">Received Qty</th>
                                </c:if>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-right">Unit Price</th>
                                <th class="py-3 px-6 text-xs font-bold uppercase text-gray-500 tracking-wider text-right">Line Total</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-100">
                            <c:forEach var="detail" items="${importDetail.details}">
                                <tr class="hover:bg-gray-50 transition-colors">
                                    <td class="py-4 px-6 text-sm font-semibold max-w-[200px] truncate"><c:out value="${detail.productName}"/></td>
                                    <td class="py-4 px-6 text-sm text-center"><c:out value="${detail.size}"/></td>
                                    <td class="py-4 px-6 text-sm text-center">
                                        <div class="inline-flex items-center gap-2">
                                            <span class="w-3 h-3 rounded-full border border-gray-300" style="background-color: <c:out value="${detail.color}"/>;"></span>
                                            <span class="capitalize"><c:out value="${detail.color}"/></span>
                                        </div>
                                    </td>
                                    <td class="py-4 px-6 text-sm text-center font-bold"><c:out value="${detail.importQuantity}"/></td>
                                    
                                    <c:set var="isPostApproved" value="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}" />
                                    <c:if test="${isPostApproved}">
                                        <td class="py-4 px-6 text-sm text-center font-bold text-indigo-700 bg-indigo-50/30"><c:out value="${detail.receivedQuantity}"/></td>
                                    </c:if>

                                    <td class="py-4 px-6 text-sm text-right">
                                        <fmt:formatNumber value="${detail.unitPrice}" pattern="#,##0"/> đ
                                    </td>
                                    <td class="py-4 px-6 text-sm text-right font-bold text-black">
                                        <c:set var="qtyToCalculate" value="${isPostApproved ? detail.receivedQuantity : detail.importQuantity}" />
                                        <fmt:formatNumber value="${detail.unitPrice * qtyToCalculate}" pattern="#,##0"/> đ
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>

            <!-- Right Column: Approval Action -->
            <div class="col-span-1">
                <div class="bg-white border border-gray-200 rounded-xl shadow-sm p-6 sticky top-8">
                    <h3 class="text-lg font-bold mb-4">Process Request</h3>
                    
                    <c:choose>
                        <c:when test="${importDetail.status == 'REQUESTING' || importDetail.status == 'REPORTED'}">
                            <form id="approvalForm" action="${pageContext.request.contextPath}/admin/import-detail" method="POST" class="flex flex-col gap-6" onsubmit="return validateApprovalForm(event)">
                                <input type="hidden" name="id" value="${importDetail.importID}">
                                
                                <div class="flex flex-col gap-2 relative">
                                    <label for="note" class="text-xs font-bold uppercase tracking-widest text-gray-500">Admin Note <span class="text-red-500">*</span></label>
                                    <textarea id="note" name="note" rows="4" required
                                              placeholder="Add remarks for approval, cancellation, or acceptance reason..."
                                              class="w-full rounded-lg border-gray-300 shadow-sm focus:border-black focus:ring-black text-sm p-3 placeholder-gray-400"></textarea>
                                    <div id="noteError" class="hidden text-red-600 text-xs font-semibold mt-1 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-[14px]">error</span> 
                                        Admin Note is strictly required.
                                    </div>
                                </div>
                                
                                <div class="flex flex-col gap-3">
                                    <c:choose>
                                        <c:when test="${importDetail.status == 'REQUESTING'}">
                                            <button type="submit" name="action" value="approve" 
                                                    class="w-full flex items-center justify-center gap-2 px-6 py-3 bg-green-600 text-white font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-green-700 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">check_circle</span>
                                                Approve Request
                                            </button>
                                            
                                            <button type="submit" name="action" value="cancel" 
                                                    class="w-full flex items-center justify-center gap-2 px-6 py-3 bg-red-600 text-white font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-red-700 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">cancel</span>
                                                Reject Request
                                            </button>
                                        </c:when>
                                        
                                        <c:when test="${importDetail.status == 'REPORTED'}">
                                            <button type="submit" name="action" value="accept" 
                                                    class="w-full flex items-center justify-center gap-2 px-6 py-3 bg-green-600 text-white font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-green-700 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">done_all</span>
                                                Accept Arrival
                                            </button>
                                            
                                            <button type="submit" name="action" value="cancel" 
                                                    class="w-full flex items-center justify-center gap-2 px-6 py-3 bg-red-600 text-white font-bold text-xs uppercase tracking-widest rounded-lg hover:bg-red-700 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">cancel</span>
                                                Cancel Arrival
                                            </button>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="flex flex-col gap-6">
                                <div class="p-4 bg-gray-50 rounded-lg text-sm text-gray-500 italic text-center">
                                    This request has already been processed and its status cannot be changed.
                                </div>
                                
                                <div class="flex flex-col gap-2">
                                    <label class="text-xs font-bold uppercase tracking-widest text-gray-400">Admin Note</label>
                                    <div class="p-4 bg-gray-50 rounded-lg text-sm text-gray-800 min-h-[100px] whitespace-pre-wrap"><c:choose><c:when test="${empty importDetail.note}"><span class="text-gray-400 italic">No notes provided.</span></c:when><c:otherwise><c:out value="${importDetail.note}"/></c:otherwise></c:choose></div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>

        </section>
    </main>

    <script>
        function validateApprovalForm(event) {
            const submitter = event.submitter;
            const noteInput = document.getElementById('note');
            const errorDiv = document.getElementById('noteError');
            
            // Reset state
            noteInput.classList.remove('border-red-500', 'focus:border-red-500', 'focus:ring-red-500');
            errorDiv.classList.add('hidden');

            const noteValue = noteInput.value.trim();
            if (noteValue === '') {
                noteInput.classList.add('border-red-500', 'focus:border-red-500', 'focus:ring-red-500');
                errorDiv.classList.remove('hidden');
                event.preventDefault();
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
