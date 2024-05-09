package umariana.mundial;

public class IdJugadorDuplicadoException extends Exception {
    
    public IdJugadorDuplicadoException() {
        super("Ya existe un jugador con ese ID, intentelo nuevamente");
    }
}
