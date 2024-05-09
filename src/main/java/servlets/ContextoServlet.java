package servlets;

import java.util.ArrayList;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import unimariana.mundial.clases.Seleccion;
import unimariana.mundial.procesos.Funcionalidad;
import unimariana.mundial.clases.Mundial;

//Metodo para cargar toda la info a todo el servelets
@WebListener
public class ContextoServlet implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext servletContext = servletContextEvent.getServletContext();
        Funcionalidad funcionalidad = new Funcionalidad();
        funcionalidad.setServletContext(servletContext);
        
        // Obtener selecciones y almacenarlos en el contexto
        ArrayList<Seleccion> selecciones = Mundial.dameTodasSelecciones();
        for(Seleccion seleccion : selecciones){
            System.out.println("PRUEBA MASTER"+seleccion);
        }
        servletContext.setAttribute("equipos", selecciones);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
