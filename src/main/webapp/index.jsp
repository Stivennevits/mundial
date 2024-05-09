<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Copa Mundial FIFA 2024</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-image: url(fifa3.jpg);
            background-size: cover; 
            background-repeat: no-repeat; 
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
        }
        .navbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0px;
        }
        .logo-text {
            font-size: 24px;
            font-weight: bold;
            color: white;
        }
        .navbar ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }
        .navbar li {
            margin-right: 20px;
        }
        .navbar li a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
            position: relative;
        }
        .navbar li a:hover {
            color: #ffc107;
        }
        .navbar li a::before {
            content: "";
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 0;
            background-color: #ffc107;
            visibility: hidden;
            transition: all 0.3s ease-in-out;
        }
        .navbar li a:hover::before {
            width: 100%;
            visibility: visible;
        }
    </style>
</head>
<body>
    <!-- Navbar con Bootstrap -->
    <nav>
        <div class="navbar-container">
            <div class="logo-text">
                Mundial FIFA 2024
            </div>
            <ul class="navbar">
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="inicio.jsp">Equipos</a></li>
            </ul>
        </div>
    </nav>
</body>
</html>