<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Update Voucher - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }
        body { background: #f5f5f3; font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; margin: 0; }
        .main-content {
            margin-left: 256px; /* Cố định theo chiều rộng thực tế của sidebar */
            padding: 60px 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center; /* Căn giữa nội dung theo chiều ngang */
            width: calc(100% - 256px);
        }
        .container-wrapper {
            width: 100%;
            max-width: 650px; /* Giới hạn độ rộng của form để trông cân đối */
            padding: 0 20px;
        }
        .page-header { 
            display: flex; 
            align-items: center; 
            margin-bottom: 24px; 
            gap: 10px;
            width: 100%;
        }
        .page-title { font-size: 13px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #1a1a1a; margin: 0; }
        .form-card { 
            background: #fff; 
            border: 1px solid #e8e8e8; 
            border-radius: 4px; 
            padding: 40px; 
            width: 100%;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
        }
        .form-label { font-size: 10px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #999; margin-bottom: 8px; display: block; }
        .form-control, .form-select { border-radius: 4px; border: 1px solid #e8e8e8; padding: 12px 14px; font-size: 14px; color: #1a1a1a; }
        .form-control:focus, .form-select:focus { border-color: #1a1a1a; box-shadow: none; outline: none; }
        .btn-save { background: #1a1a1a; color: #fff; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: .1em; padding: 12px 24px; border-radius: 4px; border: none; transition: background 0.2s; }
        .btn-save:hover { background: #333; }
        .alert-error { background: #fff5f5; color: #e03131; border: 1px solid #ffc9c9; padding: 16px; border-radius: 4px; font-size: 13px; margin-bottom: 24px; }
    </style>
</head>
<body>
    <div class="d-flex">
        <c:set var="activePage" value="voucher" scope="request" />
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">
            <div class="container-wrapper">
                <div class="page-header">
                    <i class="bi bi-pencil-square" style="font-size:16px; color:#1a1a1a;"></i>
                    <h3 class="page-title">Update Voucher</h3>
                </div>

                <div class="form-card">
                    <c:if test="${not empty ERROR}">
                        <div class="alert-error">
                            <i class="bi bi-exclamation-circle me-2"></i> ${ERROR}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/manage-voucher/edit" method="POST">
                        <input type="hidden" name="id" value="${voucher.id}" />

                        <div class="mb-4">
                            <label class="form-label">Voucher Code</label>
                            <input type="text" name="code" class="form-control w-100" value="${voucher.code}" required />
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Discount Percentage (%)</label>
                            <input type="number" step="0.1" min="0.1" max="100" name="discountValue" class="form-control w-100" value="${voucher.discountValue}" required />
                            <small class="text-muted" style="font-size: 11px;">Value must be between 0.1 and 100</small>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Min Order Amount (đ)</label>
                                <input type="number" step="0.01" min="0" name="minOrderAmount" class="form-control w-100" value="${voucher.minOrderAmount}" required />
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Max Discount Amount (đ)</label>
                                <input type="number" step="0.01" min="0" name="maxDiscountAmount" class="form-control w-100" value="${voucher.maxDiscountAmount}" placeholder="Leave empty for no limit" />
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Start Date & Time</label>
                                <input type="datetime-local" name="startDate" class="form-control w-100" value="${formattedStart}" required />
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label">End Date & Time</label>
                                <input type="datetime-local" name="endDate" class="form-control w-100" value="${formattedEnd}" required />
                            </div>
                        </div>

                        <div class="mb-4" style="max-width: 50%;">
                            <label class="form-label">Total Quantity</label>
                            <input type="number" name="quantity" min="1" class="form-control w-100" value="${voucher.quantity}" required />
                        </div>

                        <div class="d-flex gap-3 mt-2">
                            <button type="submit" class="btn-save">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

