<%-- 
    Document   : login_page
    Created on : Sep 25, 2025, 8:02:45 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <h1>Login</h1>
        <form action="login" method="POST">
            <input type="text" name="email"/><br><!-- comment -->
            <input type="password" name="password"/><br>
            <input type="submit" value="Login" />
        </form>
    </body>
</html>
