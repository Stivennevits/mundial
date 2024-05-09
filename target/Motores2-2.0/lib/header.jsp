<%@ page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mundial</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://kit.fontawesome.com/424ce1386e.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        
        

       <style>
        body {
            background-color: gray;
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin: 0;
            padding: 0;
            height: 100vh;
        }

        .form-wrapper {
            display: flex;
            justify-content: center; 
            align-items: center; 
            height: 100%; 
        }
        .toast {
            visibility: hidden;
            min-width: 250px;
            margin-left: -125px;
            background-color: #333;
            color: #fff;
            text-align: center;
            border-radius: 2px;
            padding: 16px;
            position: fixed;
            z-index: 1;
            left: 50%;
            bottom: 30px;
            font-size: 17px;
        }

        .toast.show {
            visibility: visible;
        }

        .btn {
            border-radius: 10px;
            margin: 1px;
        }

        .btn:hover {
            transform: scale(1.2);
        }

        .btn-primary {
            background-color: lightskyblue;
            border-color: lightskyblue;
        }

        .btn-primary:hover {
            background-color: purple;
            border-color: purple;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: black;
            border-color: black;
        }

        .btn-danger {
            background-color: #ff6b6b;
            border-color: #ff6b6b;
        }

        .btn-danger:hover {
            background-color: red;
            border-color: red;
        }

        .btn-info {
            background-color: darkorange;
            border-color: orange;
        }

        .btn-info:hover {
            background-color: white;
            border-color: white;
        }
        
        /* Menu Navbar */
        nav {
            background-color: #040404;
            padding: 10px 20px;
            margin: 0;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo-text {
            color: white;
            font-size: 1.5em;
            font-weight: bold;
            text-transform: uppercase;
        }

        .navbar {
            list-style-type: none;
            margin: 8px;
            padding: 0;
            display: flex;
        }

        .navbar li {
            margin-left: 30px;
            margin-right: 30px;
        }

        .navbar a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            display: block;
            transition: background-color 0.3s;
        }

        .navbar a:hover {
            background-color: black;
            border-radius: 4px;
        }

        
        /* Clase para centrar el contenedor de la tabla en la página */
        .equipos-container {
            display: flex;
            justify-content: center; /* Centra horizontalmente el formulario */
            align-items: center; /* Centra verticalmente el formulario */
            height: 100%;
            margin-top: 5px;
            
        }

        .jugador-container {
            position: absolute; /* Centra el contenedor */
            top: 50%; /* Sitúa el contenedor en el centro vertical de la pantalla */
            left: 50%; /* Sitúa el contenedor en el centro horizontal de la pantalla */
            transform: translate(-50%, -50%); /* Centra el contenedor */
            width: 80%;
            padding: 20px; /* Aumenta el padding si es necesario */
            overflow: hidden;
        }


        /* Ajusta agregaEquipo para centrar el formulario */
        .wrapper {
            position: absolute; /* Usa posición absoluta */
            top: 50%; /* Sitúa el contenedor en el centro vertical de la pantalla */
            left: 50%; /* Sitúa el contenedor en el centro horizontal de la pantalla */
            transform: translate(-50%, -50%); /* Centra el contenedor */
            width: 400px;
            height: 500px;
            padding: 40px;
            overflow: hidden;
        }


        .form-wrapper {
          display: flex;
          justify-content: center;
          align-items: center;
          width: 100%;
          height: 100%;
        }

        h2 {
          font-size: 30px;
          color: #fff;
          text-align: center;
        }
        .input-group {
          position: relative;
          margin: 30px 0;
          border-bottom: 2px solid #fff;
        }
        .input-group label {
          position: absolute;
          top: 50%;
          left: 5px;
          transform: translateY(-50%);
          font-size: 16px;
          color: #fff;
          pointer-events: none;
          transition: .5s;
        }
        .input-group input {
          width: 320px;
          height: 40px;
          font-size: 16px;
          color: #fff;
          padding: 0 5px;
          background: transparent;
          border: none;
          outline: none;
        }
        .input-group input:focus~label,
        .input-group input:valid~label {
          top: -5px;
        }

        /* Ajustes para el cuerpo de la tarjeta verJugador */
        .card-body {
            padding: 20px; /* Cambia el color de fondo */
            color: #fff; /* Cambia el color del texto */
        }
        .card-header {
            background-color: #040404;
        }
        
        
        
    </style>
  </head>
<body>