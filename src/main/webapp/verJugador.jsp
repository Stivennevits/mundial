<%@page import="umariana.mundial.Mundial"%>
<%@page import="umariana.mundial.Jugador"%>
<%@page import="umariana.mundial.Equipo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="lib/header.jsp" %>
<meta charset="UTF-8">

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
                    
                    <a class="btn btn-info btn-xl"  href="inicio.jsp">
                        <i class="fas fa-arrow-alt-circle-left" style="color: black;"></i>
                    </a>
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
                                        <a class="btn btn-primary btn-sm me-1" style="color: white;" data-bs-toggle="modal" data-bs-target="#verJugador" title="Ver Jugador" onclick="mostrarImagenJugador(<%= jugador.getId() %>, '<%= jugador.getRutaImagen()%>','<%= jugador.getNombre()%>', '<%= jugador.getEdad()%>', '<%= jugador.getAltura()%>', '<%= jugador.getPeso()%>', '<%= jugador.getPosicion()%>', '<%= jugador.getSalario()%>')"><i class="fas fa-eye"></i></a>
                                        <a class="btn btn-warning btn-sm me-1" data-bs-toggle="modal" data-bs-target="#editJugador<%= jugador.getId()%>" title="Editar"><i class="fas fa-edit text-white"></i></a>
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
                            
<style>
    #imagenEquipo {
        width: 400px;   
        height: 500px; 
        object-fit: cover; 
        
    }
    .modal-content {
    background-color: rgba(0, 0, 0, 0.8);
    color: white; 
    }
    .modal-dialog {
    max-width: 450px;  /* Ancho máximo un poco mayor que el de la imagen */
    }
</style>
                            

<!<!-- ver jugador  -->
<div class="modal fade" id="verJugador" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Detalle del Jugador</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 text-center">
                        <img id="imagenJugador" src="" alt="Imagen del Jugador" class="img-fluid rounded">
                    </div>
                    <div class="col-md-6">
                        <h5 class="mb-3">Datos del Jugador</h5>
                        <p><strong>Nombre:</strong> <span id="nombreJugador"></span></p>
                        <p><strong>Edad:</strong> <span id="edadJugador"></span></p>
                        <p><strong>Altura:</strong> <span id="alturaJugador"></span></p>
                        <p><strong>Peso:</strong> <span id="pesoJugador"></span></p>
                        <p><strong>Posición:</strong> <span id="posicionJugador"></span></p>
                        <p><strong>Salario:</strong> <span id="salarioJugador"></span></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cerrar</button>
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
                        <select name="posicion" id="posicion" class="form-control" required>
                            <option value="PO - Portero">PO - Portero</option>
                            <option value="DFC - Defensa Central">DFC - Defensa Central</option>
                            <option value="LI - Lateral Izquierdo">LI - Lateral Izquierdo</option>
                            <option value="LD - Lateral Derecho">LI - Lateral Derecho</option>
                            <option value="MDC - Mediocentro Defensivo">MDC - Mediocentro Defensivo</option>
                            <option value="MC - Mediocentro">MC - Mediocentro</option>
                            <option value="MDO - Mediocentro Ofensivo">MDO - Mediocentro Ofensivo</option>
                            <option value="EI -Extremo Izquierdo">EI -Extremo Izquierdo</option>
                            <option value="ED -Extremo Izquierdo">ED -Extremo Derecho</option>
                            <option value="D - Delantero">D - Delantero</option>
                        </select>
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
                            <select name="posicion" id="posicion" class="form-control" required>
                                <option value="PO - Portero" <%= "PO - Portero".equals(jugador.getPosicion()) ? "selected" : "" %>>PO - Portero</option>
                                <option value="DFC - Defensa Central" <%= "DFC - Defensa Central".equals(jugador.getPosicion()) ? "selected" : "" %>>DFC - Defensa Central</option>
                                <option value="LI - Lateral Izquierdo" <%= "LI - Lateral Izquierdo".equals(jugador.getPosicion()) ? "selected" : "" %>>LI - Lateral Izquierdo</option>
                                <option value="LD - Lateral Derecho" <%= "LD - Lateral Derecho".equals(jugador.getPosicion()) ? "selected" : "" %>>LD - Lateral Derecho</option>
                                <option value="MDC - Mediocentro Defensivo" <%= "MDC - Mediocentro Defensivo".equals(jugador.getPosicion()) ? "selected" : "" %>>MDC - Mediocentro Defensivo</option>
                                <option value="MC - Mediocentro" <%= "MC - Mediocentro".equals(jugador.getPosicion()) ? "selected" : "" %>>MC - Mediocentro</option>
                                <option value="MDO - Mediocentro Ofensivo" <%= "MDO - Mediocentro Ofensivo".equals(jugador.getPosicion()) ? "selected" : "" %>>MDO - Mediocentro Ofensivo</option>
                                <option value="EI -Extremo Izquierdo" <%= "EI -Extremo Izquierdo".equals(jugador.getPosicion()) ? "selected" : "" %>>EI -Extremo Izquierdo</option>
                                <option value="ED -Extremo Derecho" <%= "ED -Extremo Derecho".equals(jugador.getPosicion()) ? "selected" : "" %>>ED -Extremo Derecho</option>
                                <option value="D - Delantero" <%= "D - Delantero".equals(jugador.getPosicion()) ? "selected" : "" %>>D - Delantero</option>
                            </select>
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
                            // Llamada a la funciÃ³n showToast con un mensaje especÃ­fico
function mostrarImagenJugador(idEquipo, rutaImagen, nombre, edad, altura, peso, posicion, salario) {
    // Agregar "/" después de "imagenes" en la ruta de la imagen
    var nuevaRutaImagen = rutaImagen.replace("imagenes", "imagenes/");
    
    // Actualizar la ruta de la imagen y los datos del jugador
    var imagen = document.getElementById("imagenJugador");
    var nombreJugador = document.getElementById("nombreJugador");
    var edadJugador = document.getElementById("edadJugador");
    var alturaJugador = document.getElementById("alturaJugador");
    var pesoJugador = document.getElementById("pesoJugador");
    var posicionJugador = document.getElementById("posicionJugador");
    var salarioJugador = document.getElementById("salarioJugador");

    imagen.src = nuevaRutaImagen;
    nombreJugador.textContent = nombre;
    edadJugador.textContent = edad + " años";
    alturaJugador.textContent = altura + " cm";
    pesoJugador.textContent = peso + " kg";
    posicionJugador.textContent = posicion;
    salarioJugador.textContent = "$" + salario;

    // Mostrar la ventana modal
    $("#verJugador").modal("show");
}





</script>