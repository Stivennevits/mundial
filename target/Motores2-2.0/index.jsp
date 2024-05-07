<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>

<!-- Navbar con Bootstrap -->
<nav>
    <div class="navbar-container">
        <div class="logo-text">
            Mundial
        </div>
        <ul class="navbar">
            <li><a href="index.jsp">Inicio</a></li>
            <li><a href="inicio.jsp">Equipos</a></li>
            <li><a href="agregarEquipo.jsp">Agregar equipo</a></li>
            <li><a href="jugadores.jsp">Jugadores</a></li>
        </ul>
    </div>
</nav>

<div class="stunning-wrapper">
    <div class="stunning-button-text">
        <a href="inicio.jsp" id="stunning-button">+8 EQUIPOS</a>
    </div>
    <div class="stunning-container">
        <input type="radio" name="slide" id="c1" checked>
        <label for="c1" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">1</div>
                <div class="stunning-description">
                    <p>COLOMBIA</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c2">
        <label for="c2" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">2</div>
                <div class="stunning-description">
                    <p>BRASIL</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c3">
        <label for="c3" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">3</div>
                <div class="stunning-description">
                    <p>ALEMANIA</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c4">
        <label for="c4" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">4</div>
                <div class="stunning-description">
                    <p>FRANCIA</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c5">
        <label for="c5" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">5</div>
                <div class="stunning-description">
                    <p>ITALIA</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c6">
        <label for="c6" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">6</div>
                <div class="stunning-description">
                    <p>MÉXICO</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c7">
        <label for="c7" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">7</div>
                <div class="stunning-description">
                    <p>URUGUAY</p>
                </div>
            </div>
        </label>
        <input type="radio" name="slide" id="c8">
        <label for="c8" class="stunning-card">
            <div class="row">
                <div class="stunning-icon">8</div>
                <div class="stunning-description">
                    <p>HOLANDA</p>
                </div>
            </div>
        </label>
    </div>
</div>
