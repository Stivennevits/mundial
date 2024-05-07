<%@page import="umariana.mundial.Jugador"%>
<%@page import="umariana.mundial.GestionarJugador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
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

<div class="jugador-container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="" style="color: white">Listado de Jugadores</h5>
                    <a class="btn btn-info btn-xl" data-bs-toggle="modal" data-bs-target="#nuevoJugaModal">
                        <i class="fa fa-plus"></i>
                    </a>
                </div>
                <div class="card-body">
                    <div class="table-scroll" style="max-width: 100%; overflow-x: auto;">
                        <table class="table table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Edad</th>
                                    <th>Altura</th>
                                    <th>Peso</th>
                                    <th>Salario</th>
                                    <th>Posición</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    List<Jugador> jugadores = (List<Jugador>) request.getAttribute("jugadores");
                                    if (jugadores != null && !jugadores.isEmpty()) {
                                        for (Jugador jugador : jugadores) { 
                                %>
                                <tr>
                                    <td><%= jugador.getIdJugador() %></td>
                                    <td><%= jugador.getNombreJugador() %></td>
                                    <td><%= jugador.getEdad() %></td>
                                    <td><%= jugador.getAltura() %></td>
                                    <td><%= jugador.getPeso() %></td>
                                    <td><%= jugador.getSalario() %></td>
                                    <td><%= jugador.getPosicion() %></td>
                                    <td>
                                        <a class="btn btn-info"><i class="fas fa-eye"></i></a>
                                    </td>
                                </tr>
                                <% 
                                        } 
                                    } else { 
                                %>
                                <tr>
                                    <td colspan="8" class="text-center">No se encuentran jugadores registrados</td>
                                </tr>
                                <% 
                                    } 
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- Modal -->
<div class="modal fade" id="nuevoJugaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="nuevoJugaModalLabel">Agregar Jugador</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="agregarJugadorForm" action="SV_AgregarJugador" method="post">
                    <div class="mb-3">
                        <label for="pais" class="form-label">País:</label>
                        <input type="text" name="pais" id="pais" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="nombreJugador" class="form-label">Nombre:</label>
                        <input type="text" name="nombreJugador" id="nombreJugador" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="director" class="form-label">Director Técnico:</label>
                        <input type="text" name="director" id="director" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="logo" class="form-label">Logo:</label>
                        <input type="file" name="logo" id="logo" class="form-control" required>
                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="liveToastBtn">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>
