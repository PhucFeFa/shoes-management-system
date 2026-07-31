<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Voucher Details - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }
        body { background: #f5f5f3; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; }
        .main-content {
            margin-left: 256px;
            padding: 48px 60px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            width: calc(100% - 256px);
        }
        .container-wrapper { width: 100%; max-width: 700px; }
        .page-header { display: flex; align-items: center; margin-bottom: 24px; gap: 12px; width: 100%; }
        .page-title { font-size: 14px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #1a1a1a; margin: 0; }
        .detail-card { background: #fff; border: 1px solid #e8e8e8; border-radius: 4px; padding: 40px; width: 100%; box-shadow: 0 1px 3px rgba(0,0,0,0.02); }
        .detail-row { display: flex; justify-content: space-between; align-items: center; padding: 16px 0; border-bottom: 1px solid #f0f0f0; }
        .detail-row:last-of-type { border-bottom: none; margin-bottom: 24px; }
        .detail-label { font-size: 10px; font-weight: 700; letter-spacing: .14em; text-transform: uppercase; color: #999; }
        .detail-value { font-size: 14px; color: #1a1a1a; font-weight: 600; }
        .detail-value.code { font-weight: 700; color: #1a1a1a; letter-spacing: 0.05em; }
        .detail-value.id { font-size: 12px; color: #bbb; font-family: monospace; }
        .status-badge { font-size: 9px; font-weight: 700; padding: 3px 8px; border-radius: 12px; text-transform: uppercase; }
        .status-active { background: #e6fffa; color: #2c7a7b; }
        .status-inactive { background: #fff5f5; color: #e03131; }
        .qty-badge { font-size: 11px; font-weight: 700; background: #f1f3f5; color: #495057; padding: 4px 12px; border-radius: 4px; }
        .error-card { background: #fff; border: 1px solid #e8e8e8; border-radius: 4px; padding: 50px; text-align: center; width: 100%; }
    </style>
</head>
<body>
    <div class="d-flex">
        <c:set var="activePage" value="voucher" scope="request" />
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">
            <div class="container-wrapper">
                <div class="page-header">
                    <i class="bi bi-ticket-perforated" style="font-size:18px; color:#1a1a1a;"></i>
                    <h3 class="page-title">Voucher Details</h3>
                </div>

                <c:choose>
                    <c:when test="${not empty VOUCHER_DETAIL}">
                        <c:set var="item" value="${VOUCHER_DETAIL}" />
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
                                <span class="detail-label">Discount Percentage</span>
                                <span class="detail-value">
                                    <strong><fmt:formatNumber value="${item.discountValue}" pattern="#,##0.##" />%</strong>
                                </span>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Min Order Amount</span>
                                <span class="detail-value">
                                    <strong><fmt:formatNumber value="${item.minOrderAmount}" pattern="#,##0.##" /> đ</strong>
                                </span>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Max Discount Amount</span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${not empty item.maxDiscountAmount}">
                                            <strong><fmt:formatNumber value="${item.maxDiscountAmount}" pattern="#,##0.##" /> đ</strong>
                                        </c:when>
                                        <c:otherwise>No Limit</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Start Date</span>
                                <span class="detail-value">
                                    <fmt:parseDate value="${item.startDate.toString().substring(0,16)}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedStartDate" type="both" />
                                    <fmt:formatDate value="${parsedStartDate}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">End Date</span>
                                <span class="detail-value">
                                    <fmt:parseDate value="${item.endDate.toString().substring(0,16)}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedEndDate" type="both" />
                                    <fmt:formatDate value="${parsedEndDate}" pattern="dd/MM/yyyy" />
                                </span>
                            </div>

                            <div class="detail-row">
                                <span class="detail-label">Usage Statistics</span>
                                <span class="detail-value">
                                    <span class="qty-badge">${item.usedQuantity} / ${item.quantity} used</span>
                                </span>
                            </div>
                            

                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="error-card">
                            <i class="bi bi-exclamation-circle text-danger" style="font-size: 32px;"></i>
                            <p class="mt-3 mb-4 text-secondary" style="font-size: 13px; text-transform: uppercase; letter-spacing: 0.05em;">
                                Voucher information could not be found.
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

