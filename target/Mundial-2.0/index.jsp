<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="unimariana.mundial.clases.Jugador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="unimariana.mundial.clases.Seleccion"%>
<%@page import="unimariana.mundial.clases.Mundial"%>
<%@include file="lib/header.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Copa Mundial FIFA 2026</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    
    <style>
        
        .navbar-nav .nav-link:hover, .navbar-nav .nav-link:focus {
            color: #ffffff !important; 
            background-color: #007bff !important; 
        }

        .navbar-brand:hover, .navbar-brand:focus {
            color: #ffffff !important; 
            background-color: #007bff !important; 
        }
    </style>
</head>
<body style="background-color: #d3d3d3;">
    

<div class="equipos-container">
    <div class="col-md-8">
        <div class="card" style="text-align: center;">
            <div class="card-header d-flex justify-content-between align-items-center bg-primary">
                <h5 style="color: white">Selecciones</h5>
                <a class="btn btn-info btn-xl" data-bs-toggle="modal" data-bs-target="#nuevoJugaModal2">
                    <i class="fa fa-plus"></i>
                </a>
            </div>

            <div class="card-body">
                <div class="table-wrapper" style="max-height: 450px; overflow-y: auto;">
                    <table class="table table-hover centered-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Seleccion</th>
                                <th>Director Tecnico</th>
                                <th>Bandera</th>
                                <th>Jugadores</th>
                                <th>Nomina</th>
                                <th>Editar</th>
                                <th>Eliminar</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            ArrayList<Seleccion> selecciones = Mundial.dameTodasSelecciones();
                            if (selecciones.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="5">No se encuentran equipos registrados</td>
                                </tr>
                            <% } else {
                                for (Seleccion seleccion : selecciones) {
                            %>
                                    <tr>
                                        <td><%= seleccion.getId()%></td>
                                        <td><%= seleccion.getNombre()%></td>
                                        <td><%= seleccion.getDirectorTecnico()%></td>
                                        <td>
                                            <a  style="color: white;" onclick="mostrarImagenEquipo(<%= seleccion.getId() %>, '<%= seleccion.getBandera() %>')" title="Ver equipo"><i class='fas fa-flag' style="color: red;"></i></a>
                                        </td>
                                        <td><a  onclick="verJugador(<%= seleccion.getId()%>)" title="Ver Jugadores"><i class="fas fa-clipboard-list"></i></a></td>
                                        <td><a  onclick="abrirReporteNomina(<%= seleccion.getId()%>)" title="Calcular NÃ³mina" href="reporte.jsp?idEquipo=<%= seleccion.getId()%>"><i class="fas fa-dollar-sign" style="color: green;"></i></a></td>
                                        <td><a  data-bs-toggle="modal" data-bs-target="#editarModal<%= seleccion.getId()%>" title="Editar"><i class="fas fa-pencil-alt" style="color: yellow;"></i></a></td>
                                        <td class="action">
                                            <a href="eliminarEquipo.do?id=<%= seleccion.getId()%>" onclick="return confirmarEliminar();" title="Eliminar"><i class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
                        

<!-- crear equipo -->                        
<div class="modal fade" id="nuevoJugaModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="nuevoJugaModal2Label">Agregar Seleccion</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="agregarEquipoForm" action="agregarEquipo.do" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario()">
                    <div class="mb-3">
                        <label for="pais" class="form-label">Pai­s:</label>
                        <input type="text" name="nombreSeleccion" id="nombreSeleccion" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="director" class="form-label">Director Tecnico:</label>
                        <input type="text" name="director" id="director" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="logo" class="form-label">Bandera:</label>
                        <input type="file" name="logo" id="logo" class="form-control" required>
                    </div>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" >Guardar</button>
                </form>
            </div>
        </div>
    </div>
</div>


<!-- Modal ver selecciÃ³n -->
<div class="modal fade" id="modalVer" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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


<%
if (!selecciones.isEmpty()) {
    for (Seleccion equipo : selecciones) {
%>
<!-- Modal para mostrar la informaciÃ³n del equipo -->
<div class="modal fade" id="verModal<%= equipo.getId() %>" tabindex="-1" role="dialog" aria-labelledby="equipoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="verModalLabel">Informacion del Equipo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="equipoDetails">
                    <p><strong>ID:</strong> <%= equipo.getId()%></p>
                    <p><strong>Nombre del Equipo:</strong> <%= equipo.getNombre()%></p>
                    <p><strong>Director:</strong> <%= equipo.getDirectorTecnico()%></p>
                    <br>
                    <img style="width: 250px"src="<%= equipo.getBandera()%>" class="img-fluid rounded" alt="logoEquipo">
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editarModal<%= equipo.getId() %>" tabindex="-1" role="dialog" aria-labelledby="equipoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editarModalLabel">Editar Equipo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="equipoDetails">
                    <form id="editarEquipoForm" action="editarEquipo.do" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="idEquipo" value="<%= equipo.getId() %>">
                        <div class="mb-3">
                            <label for="nombreEquipo" class="form-label">Nombre del Equipo:</label>
                            <input type="text" name="nombreEquipo" class="form-control" value="<%= equipo.getNombre()%>">
                        </div>
                        <div class="mb-3">
                            <label for="director" class="form-label">Director:</label>
                            <input type="text" name="director" class="form-control" value="<%= equipo.getDirectorTecnico()%>">
                        </div>
                        <div class="mb-3">
                            <label for="logo" class="form-label">Logo Actual:</label><br>
                            <img  style="width: 150px" src="<%= equipo.getBandera()%>" class="img-fluid rounded" alt="logoEquipo">
                        </div>
                        <div class="mb-3">
                            <label for="nuevoLogo" class="form-label">Nuevo Logo:</label>
                            <input type="file" name="nuevoLogo" class="form-control">
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
    function abrirReporteNomina(idEquipo) {

    // Redirecciona a reporte.jsp con el ID del equipo como parÃ¡metro
    window.location.href = "reporte.jsp?idEquipo=" + idEquipo;
    }
    // FunciÃ³n para mostrar los detalles de una equipo en la ventana modal
        function mostrarEquipo(idEquipo) {
        // Realizar una solicitud AJAX para cargar el contenido de verequipo.jsp
        $.get("verEquipo.jsp?id=" + idEquipo, function (data) {
            // Insertar el contenido en la ventana modal
            $("#equipoDetails").html(data);

            // Obtener el logo del equipo desde el contenido recibido
            var logo = $(data).find("#logo").text();

            // Insertar el logo del equipo en la ventana modal
            $("#logoEquipo").attr("src", "imagenes/" + logo); // AquÃ­ estÃ¡ la lÃ­nea agregada

            // Mostrar la ventana modal
            $("#equipoModal").modal("show");
        });
    }


    function editarEquipo(idEquipo) {
        // Realizar una solicitud AJAX 
        $.get("editarEquipo.jsp?idEquipo=" + idEquipo, function (data) {
            // Insertar el contenido en la ventana modal
            $("#equipoDetails").html(data);

            // Obtener el logo del equipo desde el contenido recibido
            var logo = $(data).find("#logo").text();

            // Insertar el logo del equipo en la ventana modal
            $("#logoEquipo").attr("src", "imagenes/" + logo); // Actualizar la URL del logo

            // Mostrar la ventana modal
            $("#equipoModal").modal("show");
        });
    }


    // FunciÃ³n para ver el listado de Jugadores
    function verJugador(idEquipo) {
        window.location.href = 'verJugador.jsp?idEquipo=' + idEquipo;
    }
    
    // FunciÃ³n para confirmar la eliminaciÃ³n de un equipo
    function confirmarEliminar() {
        if (confirm("¿Estas seguro de que deseas eliminar este equipo?")) {
            // Eliminar el equipo (cÃ³digo para enviar la solicitud al servidor)
            
            // Mostrar mensaje de Ã©xito
            mostrarMensaje("Equipo eliminado correctamente");
            
            // Devolver true para permitir la acciÃ³n de eliminaciÃ³n
            return true;
        } else {
            // Si el usuario cancela la eliminaciÃ³n, devolver false para cancelar la acciÃ³n de eliminaciÃ³n
            return false;
        }
    }

    function mostrarMensaje(mensaje) {
        // Crear un elemento de mensaje
        var mensajeElemento = document.createElement("div");
        mensajeElemento.className = "mensaje-eliminar";
        mensajeElemento.textContent = mensaje;

        // Agregar el mensaje al cuerpo del documento
        document.body.appendChild(mensajeElemento);

        // Desaparecer el mensaje despuÃ©s de 3 segundos
        setTimeout(function() {
            mensajeElemento.style.display = "none";
        }, 3000);
    }
    
    function showToast(message) {
        var toastElement = document.createElement("div");
        toastElement.className = "toast show";
        toastElement.textContent = message;

        // Agregar el mensaje toast al cuerpo del documento
        document.body.appendChild(toastElement);

        // Desaparecer el mensaje despuÃ©s de 5 segundos
        setTimeout(function() {
            toastElement.classList.remove("show");
            // Eliminar el mensaje del DOM despuÃ©s de desaparecer
            setTimeout(function() {
                document.body.removeChild(toastElement);
            }, 1000);
        }, 5000);
    }
    
    // Llamada a la funciÃ³n showToast con un mensaje especÃ­fico
function mostrarImagenEquipo(idEquipo, rutaImagen) {
    // Agregar "/" después de "imagenes" en la ruta de la imagen
    var nuevaRutaImagen = rutaImagen.replace("imagenes", "imagenes/");
    
    // Actualizar la ruta de la imagen
    var imagen = document.getElementById("imagenEquipo");
    imagen.src = nuevaRutaImagen;
    
    // Mostrar la ventana modal
    $("#modalVer").modal("show");
}

</script>
</body>
</html>
