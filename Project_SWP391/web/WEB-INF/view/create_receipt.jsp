<%-- 
    Document   : create_receipt
    Created on : Oct 22, 2025, 9:37:51 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="${pageContext.request.contextPath}/inbound/create-receipt" method="get">
            <table>
                <tr>
                    <td>Choose purchase order</td>
                    <td>
                        <select name="po_id" onchange="this.form.submit()">
                            <option value="" ${pl.po_id == selectedID ? 'selected' : ''}>---Choose purchase order---</option>
                            <c:forEach var="pl" items="${poList}">
                                <option value="${pl.po_id}" ${pl.po_id == selectedID? 'selected' : ''}>${pl.po_code}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Supplier</td>
                    <td>${not empty poHeader? poHeader.display_name : ''}</td>
                </tr>
                <tr>
                    <td>Created at</td>
                    <td>${not empty poHeader? poHeader.created_at : ''}</td>
                </tr>
                <tr>
                    <td>Note</td>
                    <td>${not empty poHeader? poHeader.note : ''}</td>
                </tr>
            </table>
            <c:if test="${not empty poLine}">
                <table>
                    <tr>
                        <th>Product</th>
                        <th>Qty</th>
                        <th>Unit_price</th>
                    </tr>
                    <tr>
                        <c:forEach var="l" items="${poLine}">
                            <td>${l.product_name}</td>
                            <td>${l.qty}</td>
                            <td>${l.unit_price}
                        </c:forEach>
                    </tr>
                </table> 
            </c:if>
        </form>
    </body>
</html>
