package unimariana.mundial.excepciones;

public class JugadorExisteExcepcion extends Exception {
    
    public JugadorExisteExcepcion() {
        super("Ya existe ese jugador");
    }
}
