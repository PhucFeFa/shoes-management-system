<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <title>Adidis - Create Import Request</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect">
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <!-- Material Symbols -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <style>
        body { font-family: 'Inter', sans-serif; }
        .main-content { margin-left: 220px; }
        .input-no-spinner::-webkit-inner-spin-button, 
        .input-no-spinner::-webkit-outer-spin-button { 
            -webkit-appearance: none; 
            margin: 0; 
        }
    </style>
</head>
<body class="bg-[#f9f9f9] text-[#1a1c1c] antialiased flex min-h-screen">

    <!-- SideNavBar -->
    <c:set var="activePage" value="import-requests" scope="request" />
    <jsp:include page="/views/staff/sidebar.jsp" />

    <!-- Main Content -->
    <main class="main-content flex-1 flex flex-col min-h-screen">
        <!-- Header -->
        <header class="px-16 pt-16 pb-8 flex justify-between items-end border-b border-gray-200 bg-white">
            <div>
                <h2 class="text-3xl font-bold tracking-tight">Create Import Request</h2>
                <p class="text-gray-500 mt-2">Fill in the details to request new stock from a supplier.</p>
            </div>
            <a href="${pageContext.request.contextPath}/staff/view-request" 
               class="text-xs font-bold uppercase tracking-widest text-gray-400 hover:text-black transition-colors flex items-center gap-2">
                <span class="material-symbols-outlined text-[18px]">arrow_back</span>
                Back to List
            </a>
        </header>

        <!-- Form Section -->
        <div class="px-16 py-10 flex-1">
            <form action="${pageContext.request.contextPath}/staff/create-import" method="POST" id="importForm" class="max-w-5xl">
                
                <c:if test="${not empty error}">
                    <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 text-red-700 text-sm">
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <div class="mb-10 max-w-md">
                    <!-- Supplier Info -->
                    <div class="space-y-4">
                        <label class="block text-[10px] font-bold uppercase tracking-widest text-gray-500">Supplier Name <span class="text-red-500">*</span></label>
                        <input type="text" name="supplier" required placeholder="Enter supplier name"
                               class="w-full border-gray-200 rounded-lg focus:ring-black focus:border-black py-3 px-4">
                    </div>
                </div>

                <!-- Products Table -->
                <div class="bg-white border border-gray-200 rounded-xl shadow-sm overflow-hidden mb-8">
                    <div class="px-8 py-4 bg-gray-50 border-b border-gray-200 flex justify-between items-center">
                        <span class="text-[10px] font-bold uppercase tracking-widest text-gray-500">Products List</span>
                        <button type="button" onclick="addItem()" 
                                class="flex items-center gap-1 text-[10px] font-bold uppercase tracking-widest text-black hover:text-gray-600 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">add_circle</span>
                            Add Item
                        </button>
                    </div>

                    <table class="w-full text-left border-collapse" id="itemsTable">
                        <thead>
                            <tr class="border-b border-gray-100">
                                <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400">Variant (Product - Size - Color)</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-32 text-center">Quantity</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-48 text-right">Unit Price (đ)</th>
                                <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400 w-48 text-right">Subtotal</th>
                                <th class="py-4 px-4 w-12"></th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <!-- Template Row -->
                            <tr class="item-row">
                                <td class="py-4 px-8">
                                    <select name="variantId[]" required class="w-full border-gray-100 rounded-lg text-sm focus:ring-black focus:border-black py-2">
                                        <option value="">Select a variant...</option>
                                        <c:forEach var="v" items="${variants}">
                                            <option value="${v.variantID}">${v.productName} - ${v.size} - ${v.color}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td class="py-4 px-4">
                                    <input type="number" name="quantity[]" min="1" value="1" required oninput="updateRow(this)"
                                           class="w-full border-gray-100 rounded-lg text-sm focus:ring-black focus:border-black py-2 text-center input-no-spinner">
                                </td>
                                <td class="py-4 px-4">
                                    <input type="number" name="unitPrice[]" min="0" value="0" required oninput="updateRow(this)"
                                           class="w-full border-gray-100 rounded-lg text-sm focus:ring-black focus:border-black py-2 text-right input-no-spinner">
                                </td>
                                <td class="py-4 px-8 text-right font-bold text-sm subtotal">
                                    0 đ
                                </td>
                                <td class="py-4 px-4 text-center">
                                    <button type="button" onclick="removeItem(this)" class="text-gray-300 hover:text-red-500 transition-colors">
                                        <span class="material-symbols-outlined text-[18px]">delete</span>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <!-- Total Section -->
                    <div class="px-8 py-6 bg-gray-50 border-t border-gray-200 flex justify-end items-center gap-6">
                        <span class="text-[10px] font-bold uppercase tracking-widest text-gray-500">Estimated Total Amount</span>
                        <span class="text-2xl font-extrabold" id="totalAmountDisplay">0 đ</span>
                    </div>
                </div>

                <div class="flex justify-end">
                    <button type="submit" class="px-12 py-4 bg-black text-white font-bold uppercase text-xs tracking-widest rounded-lg hover:bg-gray-800 transition-all shadow-lg hover:shadow-xl active:scale-95">
                        Submit Request
                    </button>
                </div>
            </form>
        </div>
    </main>

    <script>
        function addItem() {
            const tbody = document.querySelector('#itemsTable tbody');
            const rows = document.querySelectorAll('.item-row');
            const newRow = rows[0].cloneNode(true);
            
            // Clear inputs in new row
            newRow.querySelector('select').selectedIndex = 0;
            newRow.querySelector('input[name="quantity[]"]').value = 1;
            newRow.querySelector('input[name="unitPrice[]"]').value = 0;
            newRow.querySelector('.subtotal').textContent = '0 đ';
            
            tbody.appendChild(newRow);
        }

        function removeItem(btn) {
            const rows = document.querySelectorAll('.item-row');
            if (rows.length > 1) {
                btn.closest('.item-row').remove();
                updateTotal();
            } else {
                alert('At least one item is required.');
            }
        }

        function updateRow(input) {
            const row = input.closest('.item-row');
            const qty = parseInt(row.querySelector('input[name="quantity[]"]').value) || 0;
            const price = parseFloat(row.querySelector('input[name="unitPrice[]"]').value) || 0;
            
            const subtotal = qty * price;
            row.querySelector('.subtotal').textContent = new Intl.NumberFormat('vi-VN').format(subtotal) + ' đ';
            
            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            const rows = document.querySelectorAll('.item-row');
            rows.forEach(row => {
                const qty = parseInt(row.querySelector('input[name="quantity[]"]').value) || 0;
                const price = parseFloat(row.querySelector('input[name="unitPrice[]"]').value) || 0;
                total += (qty * price);
            });
            
            document.getElementById('totalAmountDisplay').textContent = new Intl.NumberFormat('vi-VN').format(total) + ' đ';
        }

        // Initialize total on load
        updateTotal();
    </script>
</body>
</html>
