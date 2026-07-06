<%-- 
    Document   : voucher-form
    Created on : Jun 20, 2026, 9:24:06 PM
    Author     : default
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Voucher - ShoesStore</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f5f5f3; font-family: 'Inter', sans-serif; margin: 0; }
        /* ĐÃ CHỈNH SỬA: Thay thế margin-left cố định bằng flex-grow để tự động thích ứng với sidebar */
        .main-content { flex-grow: 1; padding: 40px 60px; min-height: 100vh; display: flex; flex-direction: column; align-items: center; }
        .content-container { width: 100%; max-width: 600px; }
        .page-header { display: flex; align-items: center; margin-bottom: 24px; gap: 10px; width: 100%; }
        .page-title { font-size: 13px; font-weight: 700; letter-spacing: .12em; text-transform: uppercase; color: #1a1a1a; margin: 0; }
        .form-card { background: #fff; border: 1px solid #e8e8e8; border-radius: 4px; padding: 40px; width: 100%; box-shadow: 0 1px 3px rgba(0,0,0,0.05); }
        .form-label { font-size: 10px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #999; margin-bottom: 8px; }
        .form-control { border-radius: 4px; border: 1px solid #e0e0e0; padding: 10px 14px; font-size: 14px; color: #1a1a1a; }
        .form-control:focus { border-color: #1a1a1a; box-shadow: none; }
        .btn-black { background: #1a1a1a; color: #fff; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .1em; padding: 12px 24px; border-radius: 4px; border: none; transition: background 0.2s; }
        .btn-black:hover { background: #333; color: #fff; }
        .btn-cancel { background: #f1f1f1; color: #333; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: .1em; padding: 12px 24px; border-radius: 4px; text-decoration: none; display: inline-block; text-align: center; }
        .btn-cancel:hover { background: #e2e2e2; }
    </style>
</head>
<body>
    <div class="d-flex w-100">
        <c:set var="activePage" value="voucher" scope="request" />
        <jsp:include page="sidebar.jsp" />

        <div class="main-content">
            <div class="content-container">
                <div class="page-header">
                    <i class="bi bi-plus-square" style="font-size:16px; color:#1a1a1a;"></i>
                    <h3 class="page-title">Create New Voucher</h3>
                </div>

                <div class="form-card">
                    <c:if test="${not empty ERROR}">
                        <div class="alert alert-danger font-size: 13px; border-radius: 4px; padding: 12px 16px; margin-bottom: 24px;">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${ERROR}
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/create-voucher" method="POST">
                        <div class="mb-4">
                            <label class="form-label">Voucher Code</label>
                            <input type="text" name="code" class="form-control" placeholder="e.g. WELCOME20" value="${oldCode}" required autocomplete="off"
                                   oninvalid="this.setCustomValidity('Please enter a voucher code.')"
                                   oninput="this.setCustomValidity('')">
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Discount Percent (%)</label>
                                <input type="number" step="0.01" min="0.1" max="100" name="discountPercent" class="form-control" placeholder="20.0" value="${oldPercent}" required
                                       oninvalid="this.setCustomValidity('Please enter a valid discount percent between 0.1 and 100.')"
                                       oninput="this.setCustomValidity('')">
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Max Discount Amount (đ)</label>
                                <input type="number" step="0.01" min="0" name="maxDiscountAmount" class="form-control" placeholder="50.0" value="${oldMax}" required
                                       oninvalid="this.setCustomValidity('Please enter a valid max discount amount.')"
                                       oninput="this.setCustomValidity('')">
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <label class="form-label">Start Date</label>
                                <input type="datetime-local" name="startDate" class="form-control" value="${oldStart}" required
                                       oninvalid="this.setCustomValidity('Please enter a valid start date and time.')"
                                       oninput="this.setCustomValidity('')">
                            </div>
                            <div class="col-md-6 mb-4">
                                <label class="form-label">End Date</label>
                                <input type="datetime-local" name="endDate" class="form-control" value="${oldEnd}" required
                                       oninvalid="this.setCustomValidity('Please enter a valid end date and time.')"
                                       oninput="this.setCustomValidity('')">
                            </div>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">Quantity</label>
                            <input type="number" min="1" name="quantity" class="form-control" placeholder="1000" value="${oldQty}" required
                                   oninvalid="this.setCustomValidity('Please enter a valid quantity greater than 0.')"
                                   oninput="this.setCustomValidity('')">
                        </div>

                        <div class="d-flex gap-2 mt-4">
                            <button type="submit" class="btn-black">Save Voucher</button>
                            <a href="${pageContext.request.contextPath}/manage-voucher" class="btn-cancel">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>