<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ShoeStore</title>
    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Separate CSS for Dashboard -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/dashboard.css">
</head>
<body class="bg-light">
    <div class="d-flex">
        <!-- Sidebar -->
        <div id="sidebar-container">
            <jsp:include page="sidebar.jsp" />
        </div>

        <!-- Main Content -->
        <div class="flex-grow-1 p-4">
            <div class="container-fluid">
                <header class="mb-5">
                    <h2 class="fw-bold text-dark">ShoeStore Administration</h2>
                    <p class="text-muted">Select a category to start managing your store</p>
                </header>

                <div class="row g-4">
                    
                    <!-- Product Management -->
                    <div class="col-md-4">
                        <div class="card menu-card shadow-sm h-100 text-center">
                            <img src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500" class="shoe-img-header" alt="Shoes">
                            <div class="card-body p-4">
                                <div class="icon-circle bg-primary bg-opacity-10 text-primary">
                                    <i class="bi bi-tag-fill"></i>
                                </div>
                                <h4 class="fw-bold">Inventory</h4>
                                <p class="text-muted">Add, edit, or delete shoe models in the system.</p>
                                <a href="#" class="btn btn-primary w-100 rounded-pill">Manage Now</a>
                            </div>
                        </div>
                    </div>

                    <!-- Order Management -->
                    <div class="col-md-4">
                        <div class="card menu-card shadow-sm h-100 text-center">
                            <img src="https://images.unsplash.com/photo-1549298916-b41d501d3772?w=500" class="shoe-img-header" alt="Orders">
                            <div class="card-body p-4">
                                <div class="icon-circle bg-success bg-opacity-10 text-success">
                                    <i class="bi bi-cart-check-fill"></i>
                                </div>
                                <h4 class="fw-bold">Orders</h4>
                                <p class="text-muted">Track and approve shoe orders from customers.</p>
                                <a href="#" class="btn btn-success w-100 rounded-pill">View Orders</a>
                            </div>
                        </div>
                    </div>

                    <!-- Customer Management -->
                    <div class="col-md-4">
                        <div class="card menu-card shadow-sm h-100 text-center">
                            <img src="https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=500" class="shoe-img-header" alt="Customers">
                            <div class="card-body p-4">
                                <div class="icon-circle bg-info bg-opacity-10 text-info">
                                    <i class="bi bi-people-fill"></i>
                                </div>
                                <h4 class="fw-bold">Customers</h4>
                                <p class="text-muted">Manage customer information and accounts.</p>
                                <a href="#" class="btn btn-info text-white w-100 rounded-pill">View List</a>
                            </div>
                        </div>
                    </div>

                    <!-- Reports Banner -->
                    <div class="col-12 mt-4">
                        <div class="card border-0 rounded-4 bg-dark text-white p-5 position-relative overflow-hidden">
                            <div class="position-relative z-index-1">
                                <h3 class="fw-bold">Reports & Analytics</h3>
                                <p>View detailed statistics on a separate page for better security.</p>
                                <button class="btn btn-outline-light rounded-pill px-4">Go to Reports <i class="bi bi-arrow-right"></i></button>
                            </div>
                            <i class="bi bi-graph-up-arrow position-absolute bottom-0 end-0 m-3 opacity-25" style="font-size: 8rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
