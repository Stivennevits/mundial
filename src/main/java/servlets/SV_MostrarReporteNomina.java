package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import unimariana.mundial.clases.Seleccion;
import unimariana.mundial.procesos.Funcionalidad;
import unimariana.mundial.clases.Mundial;

@WebServlet("/mostrarReporte.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SV_MostrarReporteNomina extends HttpServlet{
    
    @Override
    public void init() throws ServletException {
        super.init();
        ArrayList<Seleccion> equipos = Mundial.dameTodasSelecciones();
        getServletContext().setAttribute("equipos", equipos);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Seleccion> equipos = Mundial.dameTodasSelecciones();
        getServletContext().setAttribute("equipos", equipos); 
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
    
}
