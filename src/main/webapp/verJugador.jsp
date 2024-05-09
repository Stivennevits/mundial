<%@page import="umariana.mundial.Mundial"%>
<%@page import="umariana.mundial.Jugador"%>
<%@page import="umariana.mundial.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>

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

<style>
    body {
        background-image: url(fifa3.jpg);
        background-size: cover; 
        background-repeat: no-repeat; 
    }
</style>

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
                                    
                                    String idEquipoStr = request.getParameter("idEquipo");
                                    int idEquipo = Integer.parseInt(idEquipoStr);
                                    Equipo equipo = Mundial.getEquipoPorId(idEquipo);
                                    ArrayList<Jugador> jugadores = equipo.getJugadores();
                                    if (jugadores != null && !jugadores.isEmpty()) {
                                        for (Jugador jugador : jugadores) { 
                                %>
                                <tr>
                                    <td><%= jugador.getId()%></td>
                                    <td><%= jugador.getNombre()%></td>
                                    <td><%= jugador.getEdad() %></td>
                                    <td><%= jugador.getAltura() %></td>
                                    <td><%= jugador.getPeso() %></td>
                                    <td><%= jugador.getSalario() %></td>
                                    <td><%= jugador.getPosicion() %></td>
                                    <td>
                                        <a class="btn btn-info" data-bs-toggle="modal" data-bs-target="#verJugador" title="Ver Jugador" onclick="mostrarImagenJugador(<%= jugador.getId() %>, '<%= jugador.getRutaImagen()%>')"><i class="fas fa-eye"></i></a>
                                        <a class="btn btn-warning btn-sm me-1" data-bs-toggle="modal" data-bs-target="#editarModal" title="Editar"><i class="fas fa-edit text-white"></i></a>
                                        <a href="eliminarJugador.do?idEquipo=<%= equipo.getId()%>&idJugador=<%= jugador.getId()%>" onclick="return confirmarEliminar();" class="btn btn-danger btn-sm me-1" title="Eliminar"><i class="fas fa-trash"></i></a>
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

<!<!-- ver selecciÃ³n -->
<div class="modal fade" id="verJugador" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div class="d-flex justify-content-center align-items-center">
                    <img id="imagenEquipo" src="" alt="Imagen del equipo" class="img-fluid rounded">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
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
                <form id="agregarJugadorForm" action="agregarJugador.do" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario()">
                    <div class="mb-3">
                        <label for="nombreJugador" class="form-label">Nombre:</label>
                        <input type="text" name="nombreJugador" id="nombreJugador" class="form-control" required>
                    </div>
                     <div class="mb-3">
                        <label for="edad" class="form-label">Edad:</label>
                        <input type="text" name="edad" id="edad" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="altura" class="form-label">Altura:</label>
                        <input type="text" name="altura" id="altura" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="peso" class="form-label">Peso:</label>
                        <input type="text" name="peso" id="peso" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="salario" class="form-label">Salario:</label>
                        <input type="text" name="salario" id="salario" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="posicion" class="form-label">Posición:</label>
                        <input type="text" name="posicion" id="posicion" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="logo" class="form-label">Foto:</label>
                        <input type="file" name="logo" id="logo" class="form-control" required>
                    </div>
                    <input type="hidden" name="idEquipo" value="<%= idEquipo %>">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="liveToastBtn">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>
                    
<!-- Modal Editar -->
<div class="modal fade" id="editarModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="nuevoJugaModalLabel">Editar Jugador</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="agregarJugadorForm" action="agregarJugador.do" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario()">
                    <div class="mb-3">
                        <label for="nombreJugador" class="form-label">Nombre:</label>
                        <input type="text" name="nombreJugador" id="nombreJugador" class="form-control" required>
                    </div>
                     <div class="mb-3">
                        <label for="edad" class="form-label">Edad:</label>
                        <input type="text" name="edad" id="edad" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="altura" class="form-label">Altura:</label>
                        <input type="text" name="altura" id="altura" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="peso" class="form-label">Peso:</label>
                        <input type="text" name="peso" id="peso" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="salario" class="form-label">Salario:</label>
                        <input type="text" name="salario" id="salario" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="posicion" class="form-label">Posición:</label>
                        <input type="text" name="posicion" id="posicion" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="logo" class="form-label">Foto:</label>
                        <input type="file" name="logo" id="logo" class="form-control" required>
                    </div>
                    <input type="hidden" name="idEquipo" value="<%= idEquipo %>">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" id="liveToastBtn">Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
                            // Llamada a la funciÃ³n showToast con un mensaje especÃ­fico
function mostrarImagenJugador(idEquipo, rutaImagen) {
    // Agregar "/" después de "imagenes" en la ruta de la imagen
    var nuevaRutaImagen = rutaImagen.replace("imagenes", "imagenes/");
    
    // Actualizar la ruta de la imagen
    var imagen = document.getElementById("imagenEquipo");
    imagen.src = nuevaRutaImagen;
    
    // Mostrar la ventana modal
    $("#verJugador").modal("show");
}
</script>