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
        .modal-open { overflow: hidden; }
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
            <form action="${pageContext.request.contextPath}/staff/create-import" method="POST" id="importForm" class="max-w-6xl" onsubmit="return validateForm()">
                
                <c:if test="${not empty error}">
                    <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 text-red-700 text-sm">
                        <c:out value="${error}"/>
                    </div>
                </c:if>

                <div class="mb-10 max-w-md">
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
                        <button type="button" onclick="openModal()" 
                                class="flex items-center gap-1 text-[10px] font-bold uppercase tracking-widest text-black hover:text-gray-600 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">add_circle</span>
                            Add Product
                        </button>
                    </div>

                    <table class="w-full text-left border-collapse" id="itemsTable">
                        <thead>
                            <tr class="border-b border-gray-100">
                                <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400">Product</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-20 text-center">Size</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-24 text-center">Color</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-28 text-center">Quantity</th>
                                <th class="py-4 px-4 text-[10px] font-bold uppercase text-gray-400 w-40 text-right">Unit Price (đ)</th>
                                <th class="py-4 px-8 text-[10px] font-bold uppercase text-gray-400 w-40 text-right">Subtotal</th>
                                <th class="py-4 px-4 w-12 text-center"></th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-gray-50">
                            <!-- Rows added dynamically via JS -->
                        </tbody>
                    </table>

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

    <!-- Variant Selection Modal (Popup) -->
    <div id="variantModal" class="fixed inset-0 bg-black/50 backdrop-blur-sm z-50 hidden flex items-center justify-center p-4">
        <div class="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden transform transition-all">
            <div class="px-8 py-6 border-b border-gray-100 flex justify-between items-center bg-gray-50">
                <h3 class="text-lg font-bold">Select Product Variant</h3>
                <button type="button" onclick="closeModal()" class="text-gray-400 hover:text-black transition-colors">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <div class="p-8 space-y-6">
                <!-- 3 Sections for Selection -->
                <div class="space-y-2">
                    <label class="block text-[10px] font-bold uppercase tracking-widest text-gray-500">1. Select Product</label>
                    <select id="modalProduct" onchange="onProductChange()" class="w-full border-gray-200 rounded-lg focus:ring-black focus:border-black text-sm py-3 px-4">
                        <option value="">Choose a product...</option>
                    </select>
                </div>
                
                <div class="space-y-2">
                    <label class="block text-[10px] font-bold uppercase tracking-widest text-gray-500">2. Select Size</label>
                    <select id="modalSize" disabled onchange="onSizeChange()" class="w-full border-gray-200 rounded-lg focus:ring-black focus:border-black text-sm py-3 px-4 disabled:bg-gray-50 disabled:text-gray-400">
                        <option value="">Choose size...</option>
                    </select>
                </div>

                <div class="space-y-2">
                    <label class="block text-[10px] font-bold uppercase tracking-widest text-gray-500">3. Select Color</label>
                    <select id="modalColor" disabled class="w-full border-gray-200 rounded-lg focus:ring-black focus:border-black text-sm py-3 px-4 disabled:bg-gray-50 disabled:text-gray-400">
                        <option value="">Choose color...</option>
                    </select>
                </div>
            </div>
            <div class="px-8 py-6 bg-gray-50 border-t border-gray-100 flex justify-end gap-3">
                <button type="button" onclick="closeModal()" class="px-6 py-2.5 text-xs font-bold uppercase tracking-widest text-gray-500 hover:text-black transition-colors">Cancel</button>
                <button type="button" onclick="confirmAddVariant()" class="px-6 py-2.5 bg-black text-white text-xs font-bold uppercase tracking-widest rounded-lg hover:bg-gray-800 transition-all shadow-md active:scale-95">Add to List</button>
            </div>
        </div>
    </div>

    <script>
        // Data from server
        const variantsData = [
            <c:forEach var="v" items="${variants}" varStatus="status">
                {
                    id: '${v.variantID}',
                    productName: `<c:out value="${v.productName}" />`,
                    size: '${v.size}',
                    color: '${v.color}'
                }${!status.last ? ',' : ''}
            </c:forEach>
        ];

        const uniqueProducts = [...new Set(variantsData.map(v => v.productName))];

        function initModal() {
            const productSelect = document.getElementById('modalProduct');
            productSelect.innerHTML = '<option value="">Choose a product...</option>';
            uniqueProducts.sort().forEach(p => {
                const opt = document.createElement('option');
                opt.value = p;
                opt.textContent = p;
                productSelect.appendChild(opt);
            });
            resetSelect('modalSize', 'Choose size...');
            resetSelect('modalColor', 'Choose color...');
        }

        function resetSelect(id, placeholder) {
            const select = document.getElementById(id);
            select.innerHTML = `<option value="">\${placeholder}</option>`;
            select.disabled = true;
        }

        function onProductChange() {
            const product = document.getElementById('modalProduct').value;
            const sizeSelect = document.getElementById('modalSize');
            resetSelect('modalSize', 'Choose size...');
            resetSelect('modalColor', 'Choose color...');

            if (product) {
                const sizes = [...new Set(variantsData.filter(v => v.productName === product).map(v => v.size))];
                sizes.sort().forEach(s => {
                    const opt = document.createElement('option');
                    opt.value = s;
                    opt.textContent = s;
                    sizeSelect.appendChild(opt);
                });
                sizeSelect.disabled = false;
            }
        }

        function onSizeChange() {
            const product = document.getElementById('modalProduct').value;
            const size = document.getElementById('modalSize').value;
            const colorSelect = document.getElementById('modalColor');
            resetSelect('modalColor', 'Choose color...');

            if (product && size) {
                const colors = [...new Set(variantsData.filter(v => v.productName === product && v.size === size).map(v => v.color))];
                colors.sort().forEach(c => {
                    const opt = document.createElement('option');
                    opt.value = c;
                    opt.textContent = c;
                    colorSelect.appendChild(opt);
                });
                colorSelect.disabled = false;
            }
        }

        function openModal() {
            initModal();
            document.getElementById('variantModal').classList.remove('hidden');
            document.body.classList.add('modal-open');
        }

        function closeModal() {
            document.getElementById('variantModal').classList.add('hidden');
            document.body.classList.remove('modal-open');
        }

        function confirmAddVariant() {
            const product = document.getElementById('modalProduct').value;
            const size = document.getElementById('modalSize').value;
            const color = document.getElementById('modalColor').value;

            if (!product || !size || !color) {
                alert('Please select all fields');
                return;
            }

            const variant = variantsData.find(v => v.productName === product && v.size === size && v.color === color);
            if (variant) {
                addRow(variant);
                closeModal();
            }
        }

        function addRow(variant) {
            const tbody = document.querySelector('#itemsTable tbody');
            const existing = Array.from(tbody.querySelectorAll('input[name="variantId[]"]'))
                                 .find(input => input.value === variant.id);
            if (existing) {
                alert('This variant is already in the list.');
                return;
            }

            const row = document.createElement('tr');
            row.className = 'item-row hover:bg-gray-50 transition-colors';
            row.innerHTML = `
                <td class="py-4 px-8">
                    <input type="hidden" name="variantId[]" value="\${variant.id}">
                    <div class="text-sm font-semibold">\${variant.productName}</div>
                </td>
                <td class="py-4 px-4 text-center text-sm">\${variant.size}</td>
                <td class="py-4 px-4 text-center text-sm">\${variant.color}</td>
                <td class="py-4 px-4">
                    <input type="number" name="quantity[]" min="1" value="1" required oninput="updateRow(this)"
                           class="w-full border-gray-100 rounded-lg text-sm focus:ring-black focus:border-black py-2 text-center input-no-spinner">
                </td>
                <td class="py-4 px-4">
                    <input type="number" name="unitPrice[]" min="1000" value="1000" required oninput="updateRow(this)"
                           class="w-full border-gray-100 rounded-lg text-sm focus:ring-black focus:border-black py-2 text-right input-no-spinner">
                    <p class="text-[9px] text-red-500 mt-1 hidden price-error">Min 1,000đ</p>
                </td>
                <td class="py-4 px-8 text-right font-bold text-sm subtotal">0 đ</td>
                <td class="py-4 px-4 text-center">
                    <button type="button" onclick="removeItem(this)" class="text-gray-300 hover:text-red-500 transition-colors">
                        <span class="material-symbols-outlined text-[18px]">delete</span>
                    </button>
                </td>
            `;
            tbody.appendChild(row);
            updateTotal();
        }

        function removeItem(btn) {
            btn.closest('tr').remove();
            updateTotal();
        }

        function updateRow(input) {
            const row = input.closest('tr');
            const qtyInput = row.querySelector('input[name="quantity[]"]');
            const priceInput = row.querySelector('input[name="unitPrice[]"]');
            const priceError = row.querySelector('.price-error');

            const qty = parseInt(qtyInput.value) || 0;
            const price = parseFloat(priceInput.value) || 0;

            if (price < 1000) {
                priceError.classList.remove('hidden');
                priceInput.classList.add('border-red-500');
            } else {
                priceError.classList.add('hidden');
                priceInput.classList.remove('border-red-500');
            }

            const subtotal = qty * price;
            row.querySelector('.subtotal').textContent = new Intl.NumberFormat('vi-VN').format(subtotal) + ' đ';
            updateTotal();
        }

        function updateTotal() {
            let total = 0;
            document.querySelectorAll('.item-row').forEach(row => {
                const qty = parseInt(row.querySelector('input[name="quantity[]"]').value) || 0;
                const price = parseFloat(row.querySelector('input[name="unitPrice[]"]').value) || 0;
                total += (qty * price);
            });
            document.getElementById('totalAmountDisplay').textContent = new Intl.NumberFormat('vi-VN').format(total) + ' đ';
        }

        function validateForm() {
            const rows = document.querySelectorAll('.item-row');
            if (rows.length === 0) {
                alert('Please add at least one product.');
                return false;
            }

            let isValid = true;
            rows.forEach(row => {
                const price = parseFloat(row.querySelector('input[name="unitPrice[]"]').value) || 0;
                if (price < 1000) {
                    isValid = false;
                }
            });

            if (!isValid) {
                alert('Unit price must be at least 1,000 đ for all items.');
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
