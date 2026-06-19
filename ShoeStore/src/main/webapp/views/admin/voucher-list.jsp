<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="jakarta.tags.core" prefix="c"%>
<%@taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Voucher Management - ShoesStore</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/styles/admin.css"> 
        <style>
            .action-wrap {
                display: flex;
                gap: 8px;
            }
            .btn-action {
                padding: 6px 14px;
                font-size: 11px;
                font-weight: 600;
                text-decoration: none;
                border-radius: 4px;
                transition: all 0.2s ease;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .btn-view {
                background: #f1f3f5;
                color: #495057;
            }
            .btn-view:hover {
                background: #e9ecef;
            }
            .btn-edit {
                background: #e3f2fd;
                color: #0d6efd;
            }
            .btn-edit:hover {
                background: #cfe2ff;
            }
        </style>
    </head>
    <body style="margin: 0; font-family: system-ui, -apple-system, sans-serif;">
        <div style="display: flex; min-height: 100vh;">

            <jsp:include page="/views/admin/sidebar.jsp" />

            <div style="flex: 1; padding: 40px 40px 40px 260px; background-color: #fdfdfd; min-width: 0;">

                <div style="margin-bottom: 30px; display: flex; align-items: center; gap: 10px;">
                    <i class="bi bi-ticket-perforated" style="font-size: 18px; color: #000;"></i>
                    <h2 style="text-transform: uppercase; letter-spacing: 1.5px; font-size: 14px; font-weight: 700; margin: 0; color: #000;">
                        Voucher List
                    </h2>
                </div>

                <div style="background: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.02); border: 1px solid #f1f3f5; overflow: hidden; padding: 10px 20px;">
                    <table style="width: 100%; border-collapse: collapse; text-align: left;">
                        <thead>
                            <tr style="border-bottom: 1px solid #f1f3f5; font-size: 11px; color: #adb5bd; text-transform: uppercase; letter-spacing: 1px;">
                                <th style="padding: 16px 12px; width: 8%; font-weight: 600;">No.</th>
                                <th style="padding: 16px 12px; width: 25%; font-weight: 600;">Code</th>
                                <th style="padding: 16px 12px; width: 22%; font-weight: 600;">Start Date</th>
                                <th style="padding: 16px 12px; width: 22%; font-weight: 600;">End Date</th>
                                <th style="padding: 16px 12px; width: 10%; font-weight: 600;">Quantity</th>
                                <th style="padding: 16px 12px; text-align: center; width: 13%; font-weight: 600;">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty VOUCHER_LIST}">
                                    <c:forEach items="${VOUCHER_LIST}" var="v" varStatus="counter">
                                        <tr style="border-bottom: 1px solid #f8f9fa; font-size: 13px; color: #495057;">
                                            <td style="padding: 18px 12px; color: #adb5bd;">${counter.count}</td>
                                            <td style="padding: 18px 12px; font-weight: 700; color: #000;">${v.code}</td>
                                            <td style="padding: 18px 12px; color: #6c757d;">
                                                <fmt:formatDate value="${v.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                            </td>
                                            <td style="padding: 18px 12px; color: #6c757d;">
                                                <fmt:formatDate value="${v.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                            </td>
                                            <td style="padding: 18px 12px;">
                                                <span style="background: #e9ecef; padding: 4px 10px; border-radius: 4px; font-size: 12px; font-weight: 600; color: #495057;">
                                                    ${v.quantity}
                                                </span>
                                            </td>
                                            <td style="padding: 18px 12px;">
                                                <div class="action-wrap" style="justify-content: center;">
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/view?id=${v.id}" class="btn-action btn-view">VIEW</a>
                                                    <a href="${pageContext.request.contextPath}/manage-voucher/edit?id=${v.id}" class="btn-action btn-edit">EDIT</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="6" style="padding: 40px; text-align: center; color: #adb5bd; font-size: 13px;">
                                            No vouchers available.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </body>
</html>