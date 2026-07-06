<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ShoeStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        * { box-sizing: border-box; }
        body { background: #f5f5f3; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; }
        .main-content { margin-left: 220px; padding: 32px 36px; min-height: 100vh; }

        /* Stats */
        .stats-row { display: grid; grid-template-columns: repeat(4,1fr); gap: 16px; margin-bottom: 28px; }
        .stat-card { background: #fff; border: 1px solid #e8e8e8; padding: 20px 22px; }
        .stat-label { font-size: 10px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #999; margin-bottom: 10px; }
        .stat-value { font-size: 22px; font-weight: 700; color: #1a1a1a; display: flex; align-items: center; gap: 8px; }
        .stat-badge { font-size: 10px; font-weight: 700; letter-spacing: .06em; padding: 2px 7px; }
        .stat-badge.up { color: #1a1a1a; background: #e6f4ea; }
        .stat-badge.stable { color: #888; background: #f0f0f0; }

        /* Cards */
        .cards-grid { display: grid; grid-template-columns: repeat(3,1fr); gap: 20px; margin-bottom: 28px; }
        .menu-card { background: #fff; border: 1px solid #e8e8e8; display: flex; flex-direction: column; }
        .card-img-wrap { width: 100%; height: 200px; overflow: hidden; }
        .card-img-wrap img { width: 100%; height: 100%; object-fit: cover; filter: grayscale(100%); transition: filter .3s; }
        .menu-card:hover .card-img-wrap img { filter: grayscale(60%); }
        .card-body-custom { padding: 24px; display: flex; flex-direction: column; flex: 1; }
        .card-icon { font-size: 22px; color: #1a1a1a; margin-bottom: 14px; opacity: .7; }
        .card-title { font-size: 12px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #1a1a1a; margin: 0 0 10px; }
        .card-desc { font-size: 13px; color: #888; line-height: 1.6; margin: 0 0 20px; flex: 1; }
        .card-btn { display: inline-block; background: #1a1a1a; color: #fff; font-size: 10px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; text-decoration: none; padding: 12px 20px; text-align: center; transition: background .15s; }
        .card-btn:hover { background: #333; color: #fff; }

        /* Reports Banner */
        .reports-banner { background: #111; color: #fff; padding: 48px; display: flex; align-items: center; gap: 60px; position: relative; overflow: hidden; }
        .reports-title { font-size: 28px; font-weight: 800; letter-spacing: .06em; text-transform: uppercase; margin: 0 0 14px; color: #fff; }
        .reports-desc { font-size: 13px; color: #aaa; line-height: 1.7; margin: 0 0 28px; max-width: 380px; }
        .reports-btn { display: inline-flex; align-items: center; gap: 10px; background: transparent; border: 1px solid #555; color: #fff; font-size: 10px; font-weight: 700; letter-spacing: .14em; text-transform: uppercase; padding: 12px 24px; text-decoration: none; transition: border-color .15s, background .15s; }
        .reports-btn:hover { border-color: #fff; background: rgba(255,255,255,.05); color: #fff; }
        .reports-right { display: flex; flex-direction: column; gap: 20px; flex-shrink: 0; }
        .rs-label { font-size: 9px; font-weight: 700; letter-spacing: .14em; text-transform: uppercase; color: #666; display: block; }
        .rs-value { font-size: 18px; font-weight: 700; color: #fff; display: block; }
        .rs-value.up { color: #7ee8a2; }
        .reports-bg-icon { position: absolute; right: 40px; bottom: -10px; font-size: 9rem; opacity: .08; color: #fff; }
    </style>
</head>
<body>
<div class="d-flex">

    <div id="sidebar-container">
        <jsp:include page="sidebar.jsp" />
    </div>

    <div class="main-content flex-grow-1">

        <!-- Stats Row -->
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-label">Total Revenue</div>
                <div class="stat-value">124,592 đ <span class="stat-badge up">+12%</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Total Orders</div>
                <div class="stat-value">1,482 <span class="stat-badge up">+5.4%</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Active Products</div>
                <div class="stat-value">86 <span class="stat-badge stable">Stable</span></div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Customers</div>
                <div class="stat-value">4.2K <span class="stat-badge up">+8.1%</span></div>
            </div>
        </div>

        <!-- Management Cards -->
        <div class="cards-grid">
            <div class="menu-card">
                <div class="card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&q=80" alt="Inventory">
                </div>
                <div class="card-body-custom">
                    <div class="card-icon"><i class="bi bi-tag"></i></div>
                    <h3 class="card-title">Inventory Management</h3>
                    <p class="card-desc">Add, edit, or delete shoe models in the clinical catalog system.</p>
                    <a href="${pageContext.request.contextPath}/manage-products" class="card-btn">Manage Now</a>
                </div>
            </div>
            <div class="menu-card">
                <div class="card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600&q=80" alt="Orders">
                </div>
                <div class="card-body-custom">
                    <div class="card-icon"><i class="bi bi-cart-check"></i></div>
                    <h3 class="card-title">Order Fulfillment</h3>
                    <p class="card-desc">Track and approve high-velocity shoe orders from global customers.</p>
                    <a href="${pageContext.request.contextPath}/manage-orders" class="card-btn">View Orders</a>
                </div>
            </div>
            <div class="menu-card">
                <div class="card-img-wrap">
                    <img src="https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600&q=80" alt="Customers">
                </div>
                <div class="card-body-custom">
                    <div class="card-icon"><i class="bi bi-people"></i></div>
                    <h3 class="card-title">Customer Directory</h3>
                    <p class="card-desc">Manage customer profiles and secure account information logs.</p>
                    <a href="${pageContext.request.contextPath}/manage-account" class="card-btn">View List</a>
                </div>
            </div>
        </div>

        <!-- Reports Banner -->
        <div class="reports-banner">
            <div class="flex-grow-1">
                <h2 class="reports-title">Reports &amp; Analytics</h2>
                <p class="reports-desc">Access deep-dive statistics, conversion funnels, and predictive velocity data on a separate high-security server layer.</p>
                <a href="#" class="reports-btn">Go to Reports <i class="bi bi-arrow-right"></i></a>
            </div>
            <div class="reports-right">
                <div>
                    <span class="rs-label">Monthly Forecast</span>
                    <span class="rs-value up">+18.5%</span>
                </div>
                <div>
                    <span class="rs-label">Ad Conversion</span>
                    <span class="rs-value">3.42%</span>
                </div>
                <div>
                    <span class="rs-label">Inventory Turnover</span>
                    <span class="rs-value">1.2x</span>
                </div>
            </div>
            <i class="bi bi-graph-up-arrow reports-bg-icon"></i>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
