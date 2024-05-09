package servlets;

import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import umariana.mundial.Equipo;
import umariana.mundial.GestionarMundial;
import umariana.mundial.Mundial;

@WebListener
public class MyServletContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        // Inicialización del contexto aquí
        ServletContext servletContext = servletContextEvent.getServletContext();
        GestionarMundial gestionar = new GestionarMundial();
        gestionar.setServletContext(servletContext);
        
        // Obtener equipos y almacenarlos en el contexto
        ArrayList<Equipo> equipos = Mundial.getEquipos();
        servletContext.setAttribute("equipos", equipos);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        // Código de limpieza si es necesario
    }
}
