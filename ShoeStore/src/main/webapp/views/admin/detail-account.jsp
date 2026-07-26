<%-- Document : detail-account Created on : Jun 19, 2026, 7:34:18 PM Author : default --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@taglib uri="jakarta.tags.core" prefix="c" %>
            <%@taglib uri="jakarta.tags.fmt" prefix="fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Account Details - ShoesStore</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
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

                        /* Main content: Đồng bộ cấu trúc căn giữa tuyệt đối theo mẫu voucher */
                        .adidis-main-content {
                            margin-left: 256px;
                            padding: 40px;
                            min-height: 100vh;
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            justify-content: center;
                            margin-left: 256px;
                            width: calc(100% - 256px);
                        }

                        /* Khung bọc giới hạn chiều rộng tổng thể */
                        .container-wrapper {
                            width: 100%;
                            max-width: 850px;
                        }

                        .page-header {
                            display: flex;
                            align-items: center;
                            margin-bottom: 24px;
                            gap: 12px;
                        }

                        .page-title {
                            font-size: 16px;
                            font-weight: 700;
                            letter-spacing: .12em;
                            text-transform: uppercase;
                            color: #1a1a1a;
                            margin: 0;
                        }

                        /* Detail Card phẳng sang trọng đồng bộ kích thước lớn */
                        .detail-card {
                            background: #fff;
                            border: 1px solid #e8e8e8;
                            border-radius: 6px;
                            padding: 48px;
                            width: 100%;
                        }

                        .detail-row {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 20px 0;
                            border-bottom: 1px solid #f0f0f0;
                        }

                        .detail-row:last-of-type {
                            border-bottom: none;
                            margin-bottom: 32px;
                        }

                        .detail-label {
                            font-size: 11px;
                            font-weight: 700;
                            letter-spacing: .14em;
                            text-transform: uppercase;
                            color: #999;
                        }

                        .detail-value {
                            font-size: 15px;
                            color: #1a1a1a;
                            font-weight: 600;
                        }

                        .detail-value.name {
                            font-weight: 700;
                            font-size: 20px;
                            /* Tên tài khoản hiển thị lớn nổi bật */
                        }

                        .detail-value.id {
                            font-size: 14px;
                            color: #bbb;
                            font-family: monospace;
                        }

                        .role-badge {
                            font-size: 11px;
                            font-weight: 700;
                            background: #e3f2fd;
                            color: #0d6efd;
                            padding: 6px 14px;
                            border-radius: 4px;
                            text-transform: uppercase;
                            letter-spacing: 0.05em;
                        }

                        .status-badge {
                            font-size: 12px;
                            font-weight: 600;
                            padding: 6px 14px;
                            border-radius: 6px;
                            display: inline-block;
                        }

                        .status-badge.active {
                            background: #e6f4ea;
                            color: #137333;
                        }

                        .status-badge.inactive {
                            background: #fce8e6;
                            color: #c5221f;
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

                <body class="adidis-admin-body">
                    <div class="d-flex">

                        <c:set var="activePage" value="account" scope="request" />
                        <jsp:include page="/views/admin/sidebar.jsp" />

                        <div class="adidis-main-content">
                            <div class="container-wrapper">

                                <div class="page-header">
                                    <i class="bi bi-person-vcard" style="font-size:20px; color:#1a1a1a;"></i>
                                    <h3 class="page-title">Account Details</h3>
                                </div>

                                <c:choose>
                                    <c:when test="${not empty USER_DETAIL}">
                                        <div class="detail-card">
                                            <div class="detail-row">
                                                <span class="detail-label">User ID</span>
                                                <span class="detail-value id">${USER_DETAIL.id}</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Full Name</span>
                                                <span class="detail-value name">${USER_DETAIL.fullName}</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Email Address</span>
                                                <span class="detail-value"
                                                    style="font-weight: 500;">${USER_DETAIL.email}</span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Role</span>
                                                <span class="detail-value">
                                                    <span class="role-badge">${USER_DETAIL.roleName}</span>
                                                </span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Created At</span>
                                                <span class="detail-value" style="font-weight: 500; color: #6c757d;">
                                                    <fmt:formatDate value="${USER_DETAIL.createdAt}"
                                                        pattern="yyyy-MM-dd HH:mm:ss" />
                                                </span>
                                            </div>

                                            <div class="detail-row">
                                                <span class="detail-label">Status</span>
                                                <span class="detail-value">
                                                    <c:choose>
                                                        <c:when test="${'Active'.equalsIgnoreCase(USER_DETAIL.status)}">
                                                            <span class="status-badge active">Active</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge inactive">Inactive</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </div>


                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="error-card">
                                            <i class="bi bi-exclamation-circle text-danger"
                                                style="font-size: 32px;"></i>
                                            <p class="mt-3 mb-4 text-secondary"
                                                style="font-size: 14px; text-transform: uppercase; letter-spacing: 0.05em;">
                                                Account information could not be found.
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

