<%-- 
    Document   : index
    Created on : 05-dic-2017, 10:29:17
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./style.css" media="all" />
        <title>Login</title>
    </head>
    <body>
      <script language="JavaScript">
            function myfunction(url) {
            window.location.href = url;
        }
        
        </script>
        <div id="box1">
            <h1>Login</h1>
            <form action = "pruebaBBDD.jsp" method = "GET">
                <input type="text" placeholder="Inserta tu usuario" name="user"/>
                <input type="password" placeholder="Inserta tu contraseña" name="password"/>
                <input type="submit" name="boton" value="Entrar"/>
                <a href="./RegBBDD.jsp">Registrar</a>
            </form>
        </div>
        
    </body>
</html>

