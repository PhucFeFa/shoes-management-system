<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Voucher Details - Admin</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"
                    rel="stylesheet">
                <style>
                    * {
                        box-sizing: border-box;
                    }

                    body {
                        background: #f5f5f3;
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                        margin: 0;
                    }

                    /* Main content: Căn giữa toàn bộ nội dung theo cả 2 chiều */
                    .main-content {
                        margin-left: 220px;
                        padding: 40px;
                        min-height: 100vh;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        justify-content: center;
                        width: calc(100% - 220px);
                    }

                    /* Đảm bảo phần header nằm gọn theo chiều rộng của card bên dưới */
                    .container-wrapper {
                        width: 100%;
                        max-width: 850px;
                        /* Tăng kích thước tổng thể */
                    }

                    .page-header {
                        display: flex;
                        align-items: center;
                        margin-bottom: 24px;
                        gap: 12px;
                    }

                    .page-title {
                        font-size: 16px;
                        /* Tăng kích thước tiêu đề */
                        font-weight: 700;
                        letter-spacing: .12em;
                        text-transform: uppercase;
                        color: #1a1a1a;
                        margin: 0;
                    }

                    /* Khung nội dung lớn và sang trọng hơn */
                    .detail-card {
                        background: #fff;
                        border: 1px solid #e8e8e8;
                        border-radius: 6px;
                        padding: 48px;
                        /* Tăng padding bên trong */
                        width: 100%;
                    }

                    .detail-row {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 20px 0;
                        /* Tăng khoảng cách dòng */
                        border-bottom: 1px solid #f0f0f0;
                    }

                    .detail-row:last-of-type {
                        border-bottom: none;
                        margin-bottom: 32px;
                    }

                    .detail-label {
                        font-size: 11px;
                        /* Tăng kích thước label */
                        font-weight: 700;
                        letter-spacing: .14em;
                        text-transform: uppercase;
                        color: #999;
                    }

                    .detail-value {
                        font-size: 15px;
                        /* Tăng kích thước thông tin chữ */
                        color: #1a1a1a;
                        font-weight: 600;
                    }

                    .detail-value.code {
                        font-weight: 700;
                        font-size: 20px;
                        /* Làm nổi bật mã voucher lớn lên */
                    }

                    .detail-value.id {
                        font-size: 14px;
                        color: #bbb;
                        font-family: monospace;
                    }

                    .detail-value.percent {
                        color: #1a6fa8;
                        font-weight: 700;
                        font-size: 18px;
                    }

                    .qty-badge {
                        font-size: 12px;
                        font-weight: 700;
                        background: #f1f3f5;
                        color: #495057;
                        padding: 6px 14px;
                        border-radius: 4px;
                        text-transform: uppercase;
                    }

                    .btn-back {
                        display: inline-flex;
                        align-items: center;
                        gap: 8px;
                        background: #f1f1f1;
                        color: #333;
                        font-size: 11px;
                        font-weight: 600;
                        letter-spacing: .05em;
                        text-transform: uppercase;
                        padding: 12px 24px;
                        text-decoration: none;
                        border-radius: 4px;
                        transition: background 0.2s;
                    }

                    .btn-back:hover {
                        background: #e2e2e2;
                        color: #000;
                    }

                    .error-card {
                        background: #fff;
                        border: 1px solid #e8e8e8;
                        border-radius: 6px;
                        padding: 56px;
                        text-align: center;
                        width: 100%;
                    }
                </style>
            </head>

            <body>
                <div class="d-flex">

                    <c:set var="activePage" value="voucher" scope="request" />
                    <jsp:include page="sidebar.jsp" />

                    <div class="main-content">
                        <div class="container-wrapper">

                            <div class="page-header">
                                <i class="bi bi-ticket-perforated" style="font-size:20px; color:#1a1a1a;"></i>
                                <h3 class="page-title">Voucher Details</h3>
                            </div>

                            <c:choose>

                                <c:when test="${not empty VOUCHER_DETAIL or not empty voucher}">
                                    <%-- Tạo biến bọc ngắn gọn đại diện cho dữ liệu thực tế --%>
                                        <c:set var="item"
                                            value="${not empty VOUCHER_DETAIL ? VOUCHER_DETAIL : voucher}" />

                                        <div class="detail-card">
                                            <div class="detail-row">
                                                <span class="detail-label">Voucher ID</span>
                                                <span class="detail-value id">${item.id}</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Voucher Code</span>
                                                <span class="detail-value code">${item.code}</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Discount Percent</span>
                                                <span class="detail-value percent">${item.discountPercent}%</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Max Discount Amount</span>
                                                <span class="detail-value">
                                                    <fmt:formatNumber value="${item.maxDiscountAmount}" type="currency"
                                                        currencySymbol="$" />
                                                </span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Start Date</span>
                                                <span class="detail-value">
                                                    <fmt:formatDate value="${item.startDate}"
                                                        pattern="yyyy-MM-dd HH:mm" />
                                                </span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">End Date</span>
                                                <span class="detail-value">
                                                    <fmt:formatDate value="${item.endDate}"
                                                        pattern="yyyy-MM-dd HH:mm" />
                                                </span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Quantity Remaining</span>
                                                <span class="detail-value">
                                                    <span class="qty-badge">${item.quantity}</span>
                                                </span>
                                            </div>

                                            <div class="pt-3">
                                                <a href="${pageContext.request.contextPath}/manage-voucher"
                                                    class="btn-back">
                                                    <i class="bi bi-arrow-left"></i> Back to list
                                                </a>
                                            </div>
                                        </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="error-card">
                                        <i class="bi bi-exclamation-circle text-danger" style="font-size: 32px;"></i>
                                        <p class="mt-3 mb-4 text-secondary"
                                            style="font-size: 14px; text-transform: uppercase; letter-spacing: 0.05em;">
                                            Voucher information could not be found.
                                        </p>
                                        <a href="${pageContext.request.contextPath}/manage-voucher" class="btn-back">
                                            <i class="bi bi-arrow-left"></i> Back to list
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </div>
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>