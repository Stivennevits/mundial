package servlets;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import unimariana.mundial.procesos.Funcionalidad;

@WebServlet("/agregarJugador.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SV_AgregarJugador extends HttpServlet {

    private Funcionalidad gestionar;
    
    @Override
    public void init() throws ServletException {
        super.init();
        gestionar = new Funcionalidad();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros de la solicitud
        int idEquipo = Integer.parseInt(request.getParameter("idEquipo"));
        String nombre = request.getParameter("nombreJugador");
        int edad = Integer.parseInt(request.getParameter("edad"));
        double altura = Double.parseDouble(request.getParameter("altura"));
        double peso = Double.parseDouble(request.getParameter("peso"));
        String posicion = request.getParameter("posicion");
        double salario = Double.parseDouble(request.getParameter("salario"));

        // Obtener el archivo de logo
        Part logoPart = request.getPart("logo");
        if (logoPart == null || logoPart.getSize() == 0) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().println("El logo es requerido.");
            return;
        }

        // Guardar el archivo de logo
        String logoDir = getServletContext().getRealPath("");
        String logoFilename = logoPart.getSubmittedFileName();
        File logoFile = new File(logoDir, logoFilename);
        logoPart.write(logoFile.getAbsolutePath());

        // Generar la ruta relativa del logo
        String logoPath = logoFilename;

        try {
            // Llamar a agregarEquipo
            gestionar.agregarJugador(idEquipo,nombre,edad,altura,peso,posicion,salario,logoPath);
            response.sendRedirect("inicio.jsp");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Ocurrió un error inesperado: " + e.getMessage());
        }
    }
}
