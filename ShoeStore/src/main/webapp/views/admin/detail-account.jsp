<%-- 
    Document   : detail-account
    Created on : Jun 19, 2026, 7:34:18 PM
    Author     : default
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Account Details - ShoesStore</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css">
        <style>
            /* Khối bao tổng ép nội dung căn giữa trang, không bị lệch do CSS hệ thống */
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
                    <i class="bi bi-person-vcard" style="font-size: 20px; color: #000;"></i>
                    <h2 style="text-transform: uppercase; letter-spacing: 1.5px; font-size: 15px; font-weight: 700; margin: 0; color: #000;">
                        Account Details
                    </h2>
                </div>

                <c:choose>
                    <c:when test="${not empty USER_DETAIL}">
                        <div class="detail-card">
                            <div class="detail-group">
                                <span class="detail-label">User ID</span>
                                <span class="detail-value" style="color: #adb5bd; font-weight: 400; font-family: monospace; font-size: 13px;">
                                    ${USER_DETAIL.id}
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Full Name</span>
                                <span class="detail-value" style="color: #000; font-size: 16px;">
                                    ${USER_DETAIL.fullName}
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Email Address</span>
                                <span class="detail-value" style="font-weight: 500;">${USER_DETAIL.email}</span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Role</span>
                                <span class="detail-value">
                                    <span style="background: #e3f2fd; color: #0d6efd; padding: 4px 10px; border-radius: 4px; font-size: 12px; font-weight: 700; text-transform: uppercase;">
                                        ${USER_DETAIL.roleName}
                                    </span>
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Created At</span>
                                <span class="detail-value" style="font-weight: 500; color: #6c757d;">
                                    <fmt:formatDate value="${USER_DETAIL.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                </span>
                            </div>
                            <div class="detail-group">
                                <span class="detail-label">Status</span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${'Active'.equalsIgnoreCase(USER_DETAIL.status)}">
                                            <span style="background: #e6f4ea; color: #137333; padding: 6px 14px; border-radius: 6px; font-size: 13px;">
                                                Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background: #fce8e6; color: #c5221f; padding: 6px 14px; border-radius: 6px; font-size: 13px;">
                                                Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            
                            <div style="text-align: left;">
                                <a href="${pageContext.request.contextPath}/manage-account" class="btn-back">
                                    <i class="bi bi-arrow-left"></i> Back to list
                                </a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="background: #fff; border-radius: 12px; border: 1px solid #f1f3f5; padding: 50px; text-align: center; color: #adb5bd;">
                            <i class="bi bi-exclamation-circle" style="font-size: 32px; color: #e03131;"></i>
                            <p style="margin-top: 15px; font-size: 15px; font-weight: 500; color: #495057;">Account information could not be found.</p>
                            <a href="${pageContext.request.contextPath}/manage-account" class="btn-back">
                                <i class="bi bi-arrow-left"></i> Back to list
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </body>
</html>
