<%@page import="unimariana.mundial.clases.Jugador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="unimariana.mundial.clases.Seleccion"%>
<%@page import="unimariana.mundial.clases.Mundial"%>
<%@include file="lib/header.jsp"%>





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
                    Seleccion equipoEspecifico = Mundial.dameSeleccion(idEquipo);
                    if (equipoEspecifico != null) {
                        Double totalNomina = 0.0;
                        for (Jugador jugador : equipoEspecifico.getJugadores()) {
                            totalNomina += jugador.getSalario();
                        }
                %>
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <tbody>
                            <tr>
                                <th>Equipo</th>
                                <td><%= equipoEspecifico.getNombre() %></td>
                            </tr>
                            <tr>
                                <th>Fecha</th>
                                <td><%= java.time.LocalDate.now() %></td>
                            </tr>
                            <tr>
                                <th>Total N�mina</th>
                                <td><%= totalNomina %> millones anuales</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <% } else { %>
                <p>No se encontro el equipo seleccionado.</p>
                <% } %>
                <% } else { %>
                    <p>No se proporciono un ID de equipo válido.</p>
                <% } %>
            </div>
            <div class="modal-footer d-flex justify-content-center">
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
            window.location.href = 'index.jsp';
        });
    });
</script>
