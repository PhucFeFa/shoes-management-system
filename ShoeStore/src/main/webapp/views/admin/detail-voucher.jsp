<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Voucher Details - ShoesStore</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
        <style>
            /* Khối bao tổng để ép toàn bộ nội dung con canh giữa trang mà không bị ảnh hưởng bởi class hệ thống */
            .detail-container-wrapper {
                max-width: 800px;
                margin: 0 auto;
                width: 100%;
            }
            .detail-card {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.03);
                border: 1px solid #f1f3f5;
                padding: 40px;
                margin-top: 20px;
            }
            .detail-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 18px 0;
                border-bottom: 1px solid #f8f9fa;
                font-size: 14px;
            }
            .detail-group:last-of-type {
                border-bottom: none;
            }
            .detail-label {
                color: #adb5bd;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 11px;
                letter-spacing: 0.8px;
            }
            .detail-value {
                color: #495057;
                font-weight: 600;
                text-align: right;
            }
            .btn-back {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                padding: 10px 20px;
                background: #f1f3f5;
                color: #495057;
                text-decoration: none;
                font-size: 13px;
                font-weight: 600;
                border-radius: 6px;
                margin-top: 30px;
                transition: all 0.2s ease;
            }
            .btn-back:hover {
                background: #e9ecef;
                transform: translateX(-2px);
            }
        </style>
    </head>
    <body class="sole-admin-body">
        
        <jsp:include page="/views/admin/sidebar.jsp" />

        <div class="sole-main-content" style="padding: 40px; background-color: #fdfdfd;">
            
            <div class="detail-container-wrapper">
                
                <div style="margin-bottom: 30px; display: flex; align-items: center; gap: 10px; border-bottom: 2px solid #000; padding-bottom: 15px;">
                    <i class="bi bi-ticket-perforated" style="font-size: 20px; color: #000;"></i>
                    <h2 style="text-transform: uppercase; letter-spacing: 1.5px; font-size: 15px; font-weight: 700; margin: 0; color: #000;">
                        Voucher Details
                    </h2>
                </div>

                <c:choose>
                    <c:when test="${not empty VOUCHER_DETAIL}">
                        <div class="detail-card">
                            <div class="detail-group">
                                <span class="detail-label">Voucher ID</span>
                                <span class="detail-value" style="color: #adb5bd; font-weight: 400; font-family: monospace; font-size: 13px;">
                                    ${VOUCHER_DETAIL.id}
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Voucher Code</span>
                                <span class="detail-value" style="color: #000; font-size: 18px; letter-spacing: 0.5px;">
                                    ${VOUCHER_DETAIL.code}
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Discount Percent</span>
                                <span class="detail-value" style="color: #2b8a3e;">${VOUCHER_DETAIL.discountPercent}%</span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Max Discount Amount</span>
                                <span class="detail-value">
                                    <fmt:formatNumber value="${VOUCHER_DETAIL.maxDiscountAmount}" type="currency" currencySymbol="$"/>
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Start Date</span>
                                <span class="detail-value" style="font-weight: 500;">
                                    <fmt:formatDate value="${VOUCHER_DETAIL.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">End Date</span>
                                <span class="detail-value" style="font-weight: 500;">
                                    <fmt:formatDate value="${VOUCHER_DETAIL.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Quantity Remaining</span>
                                <span class="detail-value">
                                    <span style="background: #e9ecef; padding: 6px 14px; border-radius: 6px; font-size: 13px;">
                                        ${VOUCHER_DETAIL.quantity}
                                    </span>
                                </span>
                            </div>
                            
                            <div style="text-align: left;">
                                <a href="${pageContext.request.contextPath}/manage-voucher" class="btn-back">
                                    <i class="bi bi-arrow-left"></i> Back to list
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="background: #fff; border-radius: 12px; border: 1px solid #f1f3f5; padding: 50px; text-align: center; color: #adb5bd;">
                            <i class="bi bi-exclamation-circle" style="font-size: 32px; color: #e03131;"></i>
                            <p style="margin-top: 15px; font-size: 15px; font-weight: 500; color: #495057;">Voucher information could not be found.</p>
                            <a href="${pageContext.request.contextPath}/manage-voucher" class="btn-back">
                                <i class="bi bi-arrow-left"></i> Back to list
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </body>
</html>