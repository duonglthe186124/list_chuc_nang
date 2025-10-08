<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Error</title>
    </head>
    <body style="font-family: Arial, sans-serif; text-align: center; margin-top: 100px;">
        <h1 style="color: red;">⚠️ Error Occurred</h1>

        <p style="font-size: 18px;">
            <c:choose>
                <c:when test="${not empty errorMessage}">
                    ${errorMessage}
                </c:when>
                <c:otherwise>
                    An unexpected error has occurred. Please try again later.
                </c:otherwise>
            </c:choose>
        </p>

        <br>
        <a href="${pageContext.request.contextPath}/products">
            <button type="button">Back to Product List</button>
        </a>
    </body>
</html>
