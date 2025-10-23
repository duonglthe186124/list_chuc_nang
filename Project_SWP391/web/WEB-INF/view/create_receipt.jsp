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
                            <option value="" ${pl.id == selectedID ? 'selected' : ''}>---Choose purchase order---</option>
                            <c:forEach var="pl" items="${poList}">
                                <option value="${pl.id}" ${pl.id == selectedID? 'selected' : ''}>${pl.po_code}</option>
                            </c:forEach>
                        </select>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
