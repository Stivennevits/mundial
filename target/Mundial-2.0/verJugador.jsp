<%@page import="unimariana.mundial.clases.Mundial"%>
<%@page import="unimariana.mundial.clases.Jugador"%>
<%@page import="unimariana.mundial.clases.Seleccion"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>


<div class="jugador-container">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card shadow">
                <div class="card-header bg-primary d-flex justify-content-between align-items-center">
                    <h5 class="me-auto" style="color: white">Jugadores</h5>
                    <a class="btn btn-success "  href="index.jsp">
                        <i class="fa fa-arrow-alt-circle-left" ></i>
                    </a>
                    <a class="btn btn-success " data-bs-toggle="modal" data-bs-target="#nuevoJugaModal">
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
                                    <th>Foto</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                    
                                    String idEquipoStr = request.getParameter("idEquipo");
                                    int idEquipo = Integer.parseInt(idEquipoStr);
                                    Seleccion equipo = Mundial.dameSeleccion(idEquipo);
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
                                         <a class="btn btn-primary btn-sm me-1" style="color: white;" data-bs-toggle="modal" data-bs-target="#verJugador" title="Ver Jugador" onclick="mostrarImagenJugador(<%= jugador.getId() %>, '<%= jugador.getRutaImagen()%>')"><i class="fas fa-eye"></i></a>
                                        
                                    </td>
                                    <td>
                                        <a  style="color: white;" data-bs-toggle="modal" data-bs-target="#verJugador" title="Ver Jugador" onclick="mostrarImagenJugador(<%= jugador.getId() %>, '<%= jugador.getRutaImagen()%>')"><i class="fas fa-eye"></i></a>
                                        <a  data-bs-toggle="modal" data-bs-target="#editJugador<%= jugador.getId()%>" title="Editar"><i class='fas fa-user-edit'></i></a>
                                        <a href="eliminarJugador.do?idEquipo=<%= equipo.getId()%>&idJugador=<%= jugador.getId()%>" onclick="return confirmarEliminar();"  title="Eliminar"><i class="fas fa-trash" style="color: red;"></i></a>
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
                            
<style>
    #imagenEquipo {
        width: 400px;   
        height: 500px; 
        object-fit: cover; 
        
    }
  
    .modal-dialog {
    max-width: 450px;  
    }
    
</style>
                            

<!<!-- ver jugador  -->
<div class="modal fade" id="verJugador" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <div class="d-flex justify-content-center align-items-center">
                    <img id="imagenEquipo" src="" alt="Imagen del equipo" class="img-fluid rounded">
                </div>
            </div>
            <div class="modal-footer d-flex justify-content-center">
                <button type="button" class="btn btn-success" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>
                            

                    
<!-- Modal crear -->
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
                    
                    

<%
if (!jugadores.isEmpty()) {
    for (Jugador jugador : jugadores) {
%>                   
                    

<!<!-- editar -->
<div class="modal fade" id="editJugador<%= jugador.getId() %>" tabindex="-1" role="dialog" aria-labelledby="ModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarModalLabel">Editar Jugador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="jugadorDetails">
                    <form id="editarJugadorForm" action="editarJugador.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="idEquipo" value="<%= equipo.getId() %>">
                        <input type="hidden" name="idJugador" value="<%= jugador.getId() %>">
                        <div class="mb-3">
                            <label for="nombreJugador" class="form-label">Nombre del Jugador:</label>
                            <input type="text" name="nombreJugador" class="form-control" value="<%= jugador.getNombre() %>">
                        </div>
                        <div class="mb-3">
                            <label for="edad" class="form-label">Edad:</label>
                            <input type="text" name="edad" class="form-control" value="<%= jugador.getEdad() %>">
                        </div>
                         <div class="mb-3">
                            <label for="altura" class="form-label">Altura:</label>
                            <input type="text" name="altura" class="form-control" value="<%= jugador.getAltura() %>">
                        </div>
                         <div class="mb-3">
                            <label for="peso" class="form-label">Peso:</label>
                            <input type="text" name="peso" class="form-control" value="<%= jugador.getPeso() %>">
                        </div> 
                         <div class="mb-3">
                            <label for="salario" class="form-label">Salario:</label>
                            <input type="text" name="salario" class="form-control" value="<%= jugador.getSalario() %>">
                        </div>
                         <div class="mb-3">
                            <label for="posicion" class="form-label">Posición:</label>
                            <input type="text" name="posicion" id="posicion" class="form-control" value="<%= jugador.getPosicion() %>">
                        </div>
                  
                        <div class="mb-3">
                            <label for="nuevoLogo" class="form-label">Nueva Foto:</label>
                            <input type="file" name="nuevoLogo" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Actualizar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
                        
                            
<% }
} %>                    
          
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
                           
function mostrarImagenJugador(idEquipo, rutaImagen) {
    var nuevaRutaImagen = rutaImagen.replace("imagenes", "imagenes/");
    
    var imagen = document.getElementById("imagenEquipo");
    imagen.src = nuevaRutaImagen;
    
    $("#verJugador").modal("show");
}




</script>