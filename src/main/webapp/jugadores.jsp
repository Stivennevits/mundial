<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>

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

<section>
    <div>
        <h1>MEJORES JUGADORES DEL MUNDIAL</h1>
    </div>
    <div class="swiper mySwiper container">
        <div class="swiper-wrapper content">
            <div class="row">
                <div class="swiper-slide card-juga">
                    <div class="card-juga-content">
                        <div class="image">
                            <img src="https://img.a.transfermarkt.technology/portrait/big/28003-1710080339.jpg?lm=1" alt="">
                        </div>
                        <div class="name-profession">
                            <span class="name">Lionel Messi</span>
                        </div>
                        <div class="rating">
                            <i class="fa-solid">Delantero</i>
                        </div>
                        <div class="button">
                            <button class="aboutMe">Argentina</button>
                        </div>
                    </div>
                </div>
                <div class="swiper-slide card-juga">
                    <div class="card-juga-content">
                        <div class="image">
                            <img src="https://img.a.transfermarkt.technology/portrait/big/8198-1694609670.jpg?lm=1" alt="">
                        </div>
                        <div class="name-profession">
                            <span class="name">Cristiano Ronaldo</span>
                        </div>
                        <div class="rating">
                            <i class="fa-solid">Delantero</i>
                        </div>
                        <div class="button">
                            <button class="aboutMe">Portugal</button>
                        </div>
                    </div>
                </div>
                <div class="swiper-slide card-juga">
                    <div class="card-juga-content">
                        <div class="image">
                            <img src="https://i.pinimg.com/originals/48/e0/05/48e005049d4fc054dd2d6c319ca011da.png" alt="">
                        </div>
                        <div class="name-profession">
                            <span class="name">Neymar JR</span>
                        </div>
                        <div class="rating">
                            <i class="fa-solid">Delantero</i>
                        </div>
                        <div class="button">
                            <button class="aboutMe">Brasil</button>
                        </div>
                    </div>
                </div>
                <div class="swiper-slide card-juga">
                    <div class="card-juga-content">
                        <div class="image">
                            <img src="https://conteudo.imguol.com.br/c/esporte/10/2022/09/23/richarlison-comemora-gol-pela-selecao-brasileira-em-amistoso-contra-gana-1663969438957_v2_4x3.jpg" alt="">
                        </div>
                        <div class="name-profession">
                            <span class="name">Richarlison</span>
                        </div>
                        <div class="rating">
                            <i class="fa-solid">Delantero</i>
                        </div>
                        <div class="button">
                            <button class="aboutMe">Brasil</button>
                        </div>
                    </div>
                </div>
            </di>
        </div>
    </div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
    <div class="swiper-pagination"></div>
</section>
