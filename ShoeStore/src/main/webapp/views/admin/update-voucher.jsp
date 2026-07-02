<%-- 
    Document   : update-voucher
    Created on : Jun 25, 2026, 4:57:02 PM
    Author     : default
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Voucher - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            background: #f5f5f3; /* Đồng bộ màu nền xám nhạt chuẩn */
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            margin: 0;
        }
        /* Cố định khoảng cách 256px đồng bộ tuyệt đối với Sidebar */
        .main-content {
            margin-left: 256px;
            padding: 32px 36px;
            min-height: 100vh;
            width: calc(100% - 256px);
        }
        .page-header {
            display: flex;
            align-items: center;
            margin-bottom: 24px;
            gap: 10px;
        }
        .page-title {
            font-size: 13px;
            font-weight: 700;
            letter-spacing: .12em;
            text-transform: uppercase;
            color: #1a1a1a;
            margin: 0;
        }
        /* Khối bo Form đồng bộ kiểu dáng với .table-card bên list */
        .form-card {
            background: #fff;
            border: 1px solid #e8e8e8;
            border-radius: 4px;
            padding: 28px 32px;
            max-width: 650px; /* Độ rộng form vừa vặn, tinh tế */
        }
        .alert-error {
            background-color: #fff5f5;
            color: #e03131;
            padding: 12px 16px;
            border: 1px solid #ffc9c9;
            font-size: 12px;
            font-weight: 600;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-label {
            display: block;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .08em;
            text-transform: uppercase;
            color: #999;
            margin-bottom: 8px;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            font-size: 13px;
            color: #1a1a1a;
            background-color: #ffffff;
            border: 1px solid #e8e8e8;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.15s ease;
        }
        .form-control:focus {
            outline: none;
            border-color: #1a1a1a;
            box-shadow: none; /* Khử bóng xanh mặc định của bootstrap */
        }
        .btn-group-action {
            margin-top: 28px;
            display: flex;
            gap: 8px;
        }
        /* Đồng bộ nút bấm style chữ nhỏ gọn, viết hoa */
        .btn-custom {
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .1em;
            text-transform: uppercase;
            padding: 8px 20px;
            border-radius: 4px;
            text-decoration: none;
            transition: all 0.15s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border: none;
        }
        .btn-save {
            background: #1a1a1a;
            color: #fff;
        }
        .btn-save:hover {
            background: #333333;
            color: #fff;
        }
        .btn-back {
            background: #f1f1f1;
            color: #333;
        }
        .btn-back:hover {
            background: #e2e2e2;
            color: #333;
        }
    </style>
</head>
<body>

    <div class="d-flex">
        <%-- Thiết lập Active Page để giữ trạng thái menu Sidebar sáng đúng mục Voucher --%>
        <c:set var="activePage" value="voucher" scope="request" />
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">
            <div class="page-header">
                <i class="bi bi-pencil-square" style="font-size:16px; color:#1a1a1a;"></i>
                <h3 class="page-title">Update Voucher Parameters</h3>
            </div>

            <div class="form-card">
                
                <c:if test="${not empty ERROR}">
                    <div class="alert-error">
                        <i class="bi bi-exclamation-circle me-2"></i>${ERROR}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/manage-voucher/edit" method="POST">
                    <input type="hidden" name="id" value="${voucher.id}" />

                    <div class="form-group">
                        <label class="form-label">Voucher Code</label>
                        <input type="text" class="form-control" name="code" value="${not empty ERROR ? param.code : voucher.code}" placeholder="E.G. NEWYEAR2026" required />
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label class="form-label">Discount Percent (%)</label>
                            <input type="number" step="0.1" class="form-control" name="discountPercent" value="${not empty ERROR ? oldPercent : voucher.discountPercent}" placeholder="0.1 - 100" required />
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="form-label">Max Discount Amount</label>
                            <input type="number" step="0.01" class="form-control" name="maxDiscountAmount" value="${not empty ERROR ? oldMax : voucher.maxDiscountAmount}" placeholder="Limit value" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 form-group">
                            <label class="form-label">Start Date & Time</label>
                            <input type="datetime-local" class="form-control" name="startDate" value="${formattedStart}" required />
                        </div>
                        <div class="col-md-6 form-group">
                            <label class="form-label">End Date & Time</label>
                            <input type="datetime-local" class="form-control" name="endDate" value="${formattedEnd}" required />
                        </div>
                    </div>

                    <div class="form-group" style="max-width: 50%;">
                        <label class="form-label">Total Quantity</label>
                        <input type="number" class="form-control" name="quantity" value="${not empty ERROR ? oldQty : voucher.quantity}" placeholder="Slots numbers" required />
                    </div>

                    <div class="btn-group-action">
                        <button type="submit" class="btn-custom btn-save">
                            <i class="bi bi-check-lg me-1"></i> Save Changes
                        </button>
                        <a href="${pageContext.request.contextPath}/manage-voucher" class="btn-custom btn-back">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>