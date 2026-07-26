<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Request Detail #${importDetail.importID} - Admin</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
        <style>
            * { box-sizing: border-box; }
            body {
                background: #f5f5f3;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
                margin: 0;
            }
            .main-content {
                margin-left: 256px;
                padding: 32px 36px;
                min-height: 100vh;
                width: calc(100% - 256px); box-sizing: border-box;
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
            .info-card {
                background: #fff;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                padding: 24px;
                margin-bottom: 24px;
            }
            .table-card {
                background: #fff;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                overflow-x: auto;
            }
            .user-table {
                width: 100%;
                border-collapse: collapse;
                table-layout: fixed;
                min-width: 800px;
            }
            .user-table thead tr {
                border-bottom: 2px solid #e8e8e8;
            }
            .user-table thead th {
                font-size: 11px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                color: #1a1a1a;
                padding: 14px 16px;
                white-space: nowrap;
                overflow: hidden;
                text-align: left;
            }
            .user-table tbody tr {
                border-bottom: 1px solid #f0f0f0;
                transition: background .12s;
            }
            .user-table tbody tr:last-child { border-bottom: none; }
            .user-table tbody tr:hover { background: #fafafa; }
            .user-table tbody td {
                padding: 16px;
                font-size: 13px;
                color: #1a1a1a;
                vertical-align: middle;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .btn-back {
                background: #e2e8f0;
                color: #475569;
                text-decoration: none;
                font-size: 11px;
                font-weight: 600;
                letter-spacing: .05em;
                text-transform: uppercase;
                padding: 10px 16px;
                border-radius: 4px;
                margin-right: 12px;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-back:hover { background: #cbd5e1; color: #334155; }
            
            .status-badge {
                font-size: 9px;
                font-weight: 700;
                letter-spacing: .1em;
                text-transform: uppercase;
                padding: 4px 10px;
                display: inline-block;
                white-space: nowrap;
                border-radius: 4px;
            }
            
            /* Process Form Card */
            .process-card {
                background: #fff;
                border: 1px solid #e8e8e8;
                border-radius: 4px;
                padding: 24px;
                margin-top: 24px;
            }
            .section-title {
                font-size: 14px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: .1em;
                margin-bottom: 20px;
            }
            .btn-approve { background: #198754; color: #fff; font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: .05em; padding: 10px 20px; border: none; border-radius: 4px; }
            .btn-approve:hover { background: #157347; color: #fff; }
            .btn-reject { background: #dc3545; color: #fff; font-weight: 600; font-size: 12px; text-transform: uppercase; letter-spacing: .05em; padding: 10px 20px; border: none; border-radius: 4px; }
            .btn-reject:hover { background: #bb2d3b; color: #fff; }
        </style>
    </head>
    <body>
        <c:set var="activePage" value="import" scope="request" />
        <div class="d-flex">
            <jsp:include page="/views/admin/sidebar.jsp" />

            <div class="main-content">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <div class="page-header mb-0">
                        <i class="bi bi-file-earmark-text" style="font-size:16px; color:#1a1a1a;"></i>
                        <h3 class="page-title">Request Detail #${importDetail.importID}</h3>
                    </div>
                    
                    <div class="d-flex align-items-center gap-2">
                        <span style="font-size: 10px; font-weight: 700; letter-spacing: .1em; text-transform: uppercase; color: #999;">Status:</span>
                        <c:set var="statusClass" value=""/>
                        <c:choose>
                            <c:when test="${importDetail.status == 'REQUESTING'}"><c:set var="statusClass" value="background: #e8f4fd; color: #1a6fa8;"/></c:when>
                            <c:when test="${importDetail.status == 'APPROVED'}"><c:set var="statusClass" value="background: #fff8e6; color: #b38600;"/></c:when>
                            <c:when test="${importDetail.status == 'REPORTED'}"><c:set var="statusClass" value="background: #f4e8fd; color: #7a1aa8;"/></c:when>
                            <c:when test="${importDetail.status == 'ACCEPTED'}"><c:set var="statusClass" value="background: #e6f4ea; color: #1e7e34;"/></c:when>
                            <c:when test="${importDetail.status == 'COMPLETE'}"><c:set var="statusClass" value="background: #e8e8e8; color: #1a1a1a;"/></c:when>
                            <c:when test="${importDetail.status == 'CANCELLED'}"><c:set var="statusClass" value="background: #f8d7da; color: #b21f2d;"/></c:when>
                            <c:otherwise><c:set var="statusClass" value="background: #f5f5f5; color: #666;"/></c:otherwise>
                        </c:choose>
                        <span class="status-badge" style="${statusClass}">
                            <c:out value="${importDetail.status}"/>
                        </span>
                    </div>
                </div>



                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <div class="info-card">
                    <div class="row">
                        <div class="col-md-3"><strong>Staff Name:</strong> <span class="text-muted">${importDetail.staffName}</span></div>
                        <div class="col-md-3"><strong>Supplier:</strong> <span class="text-muted">${importDetail.supplier}</span></div>
                        <div class="col-md-3"><strong>Order Date:</strong> <span class="text-muted"><fmt:formatDate value="${importDetail.orderDate}" pattern="dd/MM/yyyy HH:mm"/></span></div>
                        <div class="col-md-3"><strong>Total Amount:</strong> <span class="text-dark fw-bold"><fmt:formatNumber value="${importDetail.totalAmount}" pattern="#,##0"/> đ</span></div>
                    </div>
                </div>

                <div class="table-card">
                    <table class="user-table">
                        <colgroup>
                            <col style="width: 25%;">
                            <col style="width: 10%;">
                            <col style="width: 15%;">
                            <col style="width: 10%;">
                            <c:if test="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}">
                                <col style="width: 10%;">
                            </c:if>
                            <col style="width: 15%;">
                            <col style="width: 15%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th>Product Name</th>
                                <th>Size</th>
                                <th>Color</th>
                                <th>Qty</th>
                                <c:if test="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}">
                                    <th>Received</th>
                                </c:if>
                                <th>Unit Price</th>
                                <th>Line Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="detail" items="${importDetail.details}">
                                <tr>
                                    <td><span style="font-weight: 600; color: #1a1a1a;"><c:out value="${detail.productName}"/></span></td>
                                    <td><c:out value="${detail.size}"/></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-2">
                                            <span style="width: 12px; height: 12px; border-radius: 50%; border: 1px solid #e8e8e8; background-color: <c:out value="${detail.color}"/>;"></span>
                                            <span style="text-transform: capitalize;"><c:out value="${detail.color}"/></span>
                                        </div>
                                    </td>
                                    <td style="font-weight: 700;"><c:out value="${detail.importQuantity}"/></td>
                                    
                                    <c:set var="isPostApproved" value="${importDetail.status == 'REPORTED' || importDetail.status == 'ACCEPTED' || importDetail.status == 'COMPLETE'}" />
                                    <c:if test="${isPostApproved}">
                                        <td style="font-weight: 700; color: #198754;"><c:out value="${detail.receivedQuantity}"/></td>
                                    </c:if>

                                    <td style="color: #888;">
                                        <fmt:formatNumber value="${detail.unitPrice}" pattern="#,##0"/> đ
                                    </td>
                                    <td style="font-weight: 700; color: #1a1a1a;">
                                        <c:set var="qtyToCalculate" value="${isPostApproved ? detail.receivedQuantity : detail.importQuantity}" />
                                        <fmt:formatNumber value="${detail.unitPrice * qtyToCalculate}" pattern="#,##0"/> đ
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Process Request Section -->
                <div class="process-card">
                    <h3 class="section-title">Process Request</h3>
                    
                    <c:choose>
                        <c:when test="${importDetail.status == 'REQUESTING' || importDetail.status == 'REPORTED'}">
                            <form id="approvalForm" action="${pageContext.request.contextPath}/admin/import-detail" method="POST" class="needs-validation" novalidate onsubmit="return validateApprovalForm(event)">
                                <input type="hidden" name="id" value="${importDetail.importID}">
                                
                                <div class="mb-3">
                                    <label for="note" class="form-label text-uppercase text-muted fw-bold" style="font-size: 10px; letter-spacing: .1em;">Admin Note <span class="text-danger">*</span></label>
                                    <textarea id="note" name="note" rows="3" class="form-control" required placeholder="Add remarks for approval, cancellation, or acceptance reason..."></textarea>
                                    <div class="invalid-feedback">
                                        Admin Note is strictly required.
                                    </div>
                                </div>
                                
                                <div class="d-flex gap-2">
                                    <c:choose>
                                        <c:when test="${importDetail.status == 'REQUESTING'}">
                                            <button type="submit" name="action" value="approve" class="btn-approve d-flex align-items-center gap-2">
                                                <i class="bi bi-check-circle"></i> Approve Request
                                            </button>
                                            <button type="submit" name="action" value="cancel" class="btn-reject d-flex align-items-center gap-2">
                                                <i class="bi bi-x-circle"></i> Reject Request
                                            </button>
                                        </c:when>
                                        
                                        <c:when test="${importDetail.status == 'REPORTED'}">
                                            <button type="submit" name="action" value="accept" class="btn-approve d-flex align-items-center gap-2">
                                                <i class="bi bi-check-all"></i> Accept Arrival
                                            </button>
                                            <button type="submit" name="action" value="cancel" class="btn-reject d-flex align-items-center gap-2">
                                                <i class="bi bi-x-circle"></i> Cancel Arrival
                                            </button>
                                        </c:when>
                                    </c:choose>
                                </div>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-secondary text-center mb-4" role="alert">
                                <em>This request has already been processed and its status cannot be changed.</em>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label text-uppercase text-muted fw-bold" style="font-size: 10px; letter-spacing: .1em;">Admin Note</label>
                                <div class="p-3 bg-light rounded border text-dark" style="min-height: 80px; white-space: pre-wrap;"><c:choose><c:when test="${empty importDetail.note}"><span class="text-muted fst-italic">No notes provided.</span></c:when><c:otherwise><c:out value="${importDetail.note}"/></c:otherwise></c:choose></div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validateApprovalForm(event) {
                const form = event.target;
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
                return form.checkValidity();
            }
        </script>
    </body>
</html>

