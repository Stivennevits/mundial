package servlets;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import umariana.mundial.Equipo;
import umariana.mundial.GestionarMundial;
import umariana.mundial.Mundial;


@WebServlet("/mostrarEquipo.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SV_MostrarEquipo extends HttpServlet{
    private GestionarMundial gestionar;
    
    @Override
    public void init() throws ServletException {
        super.init();
        gestionar = new GestionarMundial();
        gestionar.setServletContext(getServletContext());
        ArrayList<Equipo> equipos = Mundial.getEquipos();
        getServletContext().setAttribute("equipos", equipos);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Equipo> equipos = Mundial.getEquipos();
        getServletContext().setAttribute("equipos", equipos); 
        request.getRequestDispatcher("mostrarEquipos.jsp").forward(request, response);
    }
    
}
