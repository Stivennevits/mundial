<%@page import="umariana.mundial.Jugador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="umariana.mundial.Equipo"%>
<%@page import="umariana.mundial.Mundial"%>
<%@include file="lib/header.jsp"%>

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

<div class="modal fade" id="reporteNominaModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Reporte de Nomina</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <% 
                String idEquipoParam = request.getParameter("idEquipo");
                if (idEquipoParam != null && !idEquipoParam.isEmpty()) {
                    int idEquipo = Integer.parseInt(idEquipoParam);
                    Equipo equipoEspecifico = Mundial.getEquipoPorId(idEquipo);
                    if (equipoEspecifico != null) {
                        Double totalNomina = 0.0;
                        for (Jugador jugador : equipoEspecifico.getJugadores()) {
                            totalNomina += jugador.getSalario();
                        }
                %>
                <div>
                    <p><strong>Equipo: </strong><%= equipoEspecifico.getNombre() %></p>
                    <p><strong>Fecha: </strong><%= java.time.LocalDate.now() %></p>
                    <p><strong>Total Nomina: </strong><%= totalNomina %> millones anuales</p>
                </div>
                <% } else { %>
                <p>No se encontro el equipo seleccionado.</p>
                <% } %>
                <% } else { %>
                    <p>No se proporciono un ID de equipo válido.</p>
                <% } %>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

<%@include file="lib/footer.jsp"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.6.0/js/bootstrap.bundle.min.js"></script>

<script>
    $(document).ready(function(){
        // Abre el modal cuando el documento esté listo
        $('#reporteNominaModal').modal('show');

        // Obtiene el ID del equipo del modal y lo imprime en la consola
        var idEquipo = '<%= request.getParameter("idEquipo") %>';
        console.log("ID del Equipo:", idEquipo);
        
          $('#reporteNominaModal').on('hidden.bs.modal', function () {
            // Redirige a inicio.jsp
            window.location.href = 'inicio.jsp';
        });
    });
</script>
