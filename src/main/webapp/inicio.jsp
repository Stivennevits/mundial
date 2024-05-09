<%@page import="umariana.mundial.Jugador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="umariana.mundial.Equipo"%>
<%@page import="umariana.mundial.Mundial"%>
<%@include file="lib/header.jsp"%>

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

<style>
    body {
        background-image: url(fifa3.jpg);
        background-size: cover; 
        background-repeat: no-repeat; 
    }
</style>


<div class="equipos-container">
    <div class="col-md-8">
        <div class="card" style="text-align: center;">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="" style="color: white">Selecciones</h5>
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
                                <th>DT</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            ArrayList<Equipo> equipos = Mundial.getEquipos();
                            if (equipos.isEmpty()) {
                            %>
                                <tr>
                                    <td colspan="5">No se encuentran equipos registrados</td>
                                </tr>
                            <% } else {
                                for (Equipo equipo : equipos) {
                            %>
                                    <tr>
                                        <td><%= equipo.getId()%></td>
                                        <td><%= equipo.getNombre()%></td>
                                        <td><%= equipo.getDirectorTecnico()%></td>
                                        <td class="action">
                                            <a class="btn btn-primary btn-sm me-1" style="color: white;" onclick="mostrarImagenEquipo(<%= equipo.getId() %>, '<%= equipo.getBandera() %>')" title="Ver equipo"><i class="fas fa-eye"></i></a>
                                            <a class="btn btn-dark btn-sm me-1" onclick="verJugador(<%= equipo.getId()%>)" title="Ver Jugadores"><i class="fas fa-list"></i></a>
                                            <a class="btn btn-success btn-sm me-1" onclick="abrirReporteNomina(<%= equipo.getId()%>)" title="Calcular Nómina" href="reporte.jsp?idEquipo=<%= equipo.getId()%>"><i class="fas fa-dollar-sign"></i></a>
                                            <a class="btn btn-warning btn-sm me-1" data-bs-toggle="modal" data-bs-target="#editarModal<%= equipo.getId()%>" title="Editar"><i class="fas fa-edit text-white"></i></a>
                                            <a href="eliminarEquipo.do?id=<%= equipo.getId()%>" onclick="return confirmarEliminar();" class="btn btn-danger btn-sm me-1" title="Eliminar"><i class="fas fa-trash"></i></a>
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

<!-- Modal crear equipo -->                        
<div class="modal fade" id="nuevoJugaModal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
              <h1 class="modal-title fs-5" id="nuevoJugaModal2Label">Agregar Selección</h1>
              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="agregarEquipoForm" action="agregarEquipo.do" method="post" enctype="multipart/form-data" onsubmit="return validarFormulario()">
                    <div class="mb-3">
                        <label for="pais" class="form-label">País:</label>
                        <input type="text" name="nombreEquipo" id="nombreEquipo" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="director" class="form-label">Director Técnico:</label>
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

<!-- Modal ver selección -->
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
if (!equipos.isEmpty()) {
    for (Equipo equipo : equipos) {
%>
<!-- Modal para mostrar la información del equipo -->
<div class="modal fade" id="verModal<%= equipo.getId() %>" tabindex="-1" role="dialog" aria-labelledby="equipoModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="verModalLabel">Información del Equipo</h5>
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

    // Redirecciona a reporte.jsp con el ID del equipo como parámetro
    window.location.href = "reporte.jsp?idEquipo=" + idEquipo;
    }
    // Función para mostrar los detalles de una equipo en la ventana modal
        function mostrarEquipo(idEquipo) {
        // Realizar una solicitud AJAX para cargar el contenido de verequipo.jsp
        $.get("verEquipo.jsp?id=" + idEquipo, function (data) {
            // Insertar el contenido en la ventana modal
            $("#equipoDetails").html(data);

            // Obtener el logo del equipo desde el contenido recibido
            var logo = $(data).find("#logo").text();

            // Insertar el logo del equipo en la ventana modal
            $("#logoEquipo").attr("src", "imagenes/" + logo); // Aquí está la línea agregada

            // Mostrar la ventana modal
            $("#equipoModal").modal("show");
        });
    }


    function editarEquipo(idEquipo) {
        // Realizar una solicitud AJAX para cargar el contenido de editar.jsp
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


    // Función para ver el listado de Jugadores
    function verJugador(idEquipo) {
        window.location.href = 'verJugador.jsp?idEquipo=' + idEquipo;
    }
    
    // Función para confirmar la eliminación de un equipo
    function confirmarEliminar() {
        if (confirm("¿Estás seguro de que deseas eliminar este equipo?")) {
            // Eliminar el equipo (código para enviar la solicitud al servidor)
            
            // Mostrar mensaje de éxito
            mostrarMensaje("Equipo eliminado correctamente");
            
            // Devolver true para permitir la acción de eliminación
            return true;
        } else {
            // Si el usuario cancela la eliminación, devolver false para cancelar la acción de eliminación
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

        // Desaparecer el mensaje después de 3 segundos
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

        // Desaparecer el mensaje después de 5 segundos
        setTimeout(function() {
            toastElement.classList.remove("show");
            // Eliminar el mensaje del DOM después de desaparecer
            setTimeout(function() {
                document.body.removeChild(toastElement);
            }, 1000);
        }, 5000);
    }
    
    // Llamada a la función showToast con un mensaje específico
function mostrarImagenEquipo(idEquipo, rutaImagen) {
    // Agregar "/" despu�s de "imagenes" en la ruta de la imagen
    var nuevaRutaImagen = rutaImagen.replace("imagenes", "imagenes/");
    
    // Actualizar la ruta de la imagen
    var imagen = document.getElementById("imagenEquipo");
    imagen.src = nuevaRutaImagen;
    
    // Mostrar la ventana modal
    $("#modalVer").modal("show");
}

</script>

<%@include file="lib/footer.jsp"%>