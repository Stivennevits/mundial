package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import unimariana.mundial.procesos.Funcionalidad;

@WebServlet("/eliminarJugador.do")
public class SV_EliminarJugador extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener el ID del equipo a eliminar desde los parámetros de la solicitud
        int id = Integer.parseInt(request.getParameter("idJugador"));
        int idEquipo = Integer.parseInt(request.getParameter("idEquipo"));

        // Eliminar el equipo utilizando el método de la clase GestionarEquipo
        Funcionalidad.eliminarJugador(idEquipo,id);

        // Redirigir al usuario a index.jsp con un parámetro en la URL indicando que el equipo se eliminó con éxito
        response.sendRedirect("inicio.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
}