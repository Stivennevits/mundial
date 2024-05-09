package unimariana.mundial.excepciones;

public class NombreExisteExcepcion extends Exception {
    
    public NombreExisteExcepcion(String message) {
       super("Ya existe el nombre asociado a ese equipo o jugador");
    }
}
