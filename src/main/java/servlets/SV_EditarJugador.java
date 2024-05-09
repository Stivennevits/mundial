package servlets;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import umariana.mundial.GestionarMundial;

@WebServlet("/editarJugador.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SV_EditarJugador extends HttpServlet {

    
    private GestionarMundial gestionar = new GestionarMundial();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los parámetros enviados desde el formulario de edición
        int idEquipo = Integer.parseInt(request.getParameter("idEquipo"));
        int idJugador = Integer.parseInt(request.getParameter("idJugador"));
        String nombre = request.getParameter("nombreJugador");
        int edad = Integer.parseInt(request.getParameter("edad"));
        double altura = Double.parseDouble(request.getParameter("altura"));
        double peso = Double.parseDouble(request.getParameter("peso"));
        String posicion = request.getParameter("posicion");
        double salario = Double.parseDouble(request.getParameter("salario"));
        // Obtener la parte del archivo (nuevo logo)
        Part filePart = request.getPart("nuevoLogo");

        // Verificar si se cargó una nueva foto
        String nuevoLogoCargado = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Obtener el nombre del archivo
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.

            // Guardar el archivo en la carpeta "imagenes"
            String uploadPath = getServletContext().getRealPath("") + File.separator + "imagenes";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String filePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(filePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // URL de la nueva foto (ruta relativa)
            nuevoLogoCargado = "imagenes" + File.separator + fileName;
        }

        // Obtener el equipo a actualizar
          try {
            // Llamar a agregarEquipo
            gestionar.editarJugador(idEquipo,idJugador,nombre,edad,altura,peso,posicion,salario,nuevoLogoCargado);
            response.sendRedirect("inicio.jsp");
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().println("Ocurrió un error inesperado: " + e.getMessage());
        }
    }

}