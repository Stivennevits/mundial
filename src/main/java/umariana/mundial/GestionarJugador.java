package umariana.mundial;

import java.util.ArrayList;
import java.util.List;

public class GestionarJugador{
    // Lista de jugadores
    private final ArrayList<Jugador> misJugadores = new ArrayList<>();
    
    // Método para agregar un jugador a la lista
    public void agregarJugador(Jugador jugador) {
        try {
            // Verificar si ya existe un jugador con el mismo ID
            for (Jugador j : misJugadores) {
                if (j.getIdJugador() == jugador.getIdJugador()) {
                    throw new IdJugadorDuplicadoException();
                }
            }
            // Si no se encontró un jugador con el mismo ID, agregarlo a la lista
            misJugadores.add(jugador);
        } catch (IdJugadorDuplicadoException e) {
            System.out.println("Error al agregar jugador: Ya existe un jugador con ese ID");
        }
    }
    
    // Método para obtener la lista de jugadores
    public List<Jugador> mostrarJugadores() {
        return misJugadores;
    }
    
    // Método para presentar la información de un jugador dado el nombre del equipo y el nombre del jugador
    public Jugador obtenerInfoJugador(ArrayList<Equipo> misEquipos, String nombreEquipo, String nombreJugador) {
        // Buscar el equipo por nombre
        for (Equipo equipo : misEquipos) {
            if (equipo.getNombreEquipo().equalsIgnoreCase(nombreEquipo)) {
                // Obtener la lista de jugadores del equipo
                ArrayList<Jugador> jugadores = equipo.obtenerJugadores();
                // Buscar el jugador dentro del equipo
                for (Jugador jugador : jugadores) {
                    if (jugador.getNombreJugador().equalsIgnoreCase(nombreJugador)) {
                        // Devolver los detalles del jugador
                        return jugador;
                    }
                }
            }
        }
        // Si no se encuentra el jugador, devolver null
        return null;
    }
}
