package umariana.mundial;

import java.util.ArrayList;
import java.util.List;

public class Equipo {
    private int id;
    private String nombre;
    private String directorTecnico;
    private String bandera;
    private  ArrayList<Jugador> jugadores;

    public Equipo(int id, String nombre, String directorTecnico, String bandera, ArrayList<Jugador> jugadores) {
        this.id = id;
        this.nombre = nombre;
        this.directorTecnico = directorTecnico;
        this.bandera = bandera;
        this.jugadores = jugadores;
    }

    public Equipo() {
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDirectorTecnico() {
        return directorTecnico;
    }

    public void setDirectorTecnico(String directorTecnico) {
        this.directorTecnico = directorTecnico;
    }

    public String getBandera() {
        return bandera;
    }

    public void setBandera(String bandera) {
        this.bandera = bandera;
    }

    public  void agregarJugador(Jugador jugador) throws NombreDuplicadoException {
        if (!jugadores.contains(jugador)) {
            jugadores.add(jugador);
        } else {
            throw new NombreDuplicadoException("Ya existe un registro con el jugador que quieres ingresar");
        }
    }


    public void setJugadores(ArrayList<Jugador> jugadores) {
        this.jugadores = jugadores;
    }

    @Override
    public String toString() {
        return "Equipo{" + "id=" + id + ", nombre=" + nombre + ", directorTecnico=" + directorTecnico + ", bandera=" + bandera + ", jugadores=" + jugadores + '}';
    }

    public ArrayList<Jugador> getJugadores() {
        return jugadores;
    }

    public  int generarIdSiguiente() {
        int ultimoId = 0;
        for (Jugador jugador : jugadores) {
            if (jugador.getId() > ultimoId) {
                ultimoId = jugador.getId();
            }
        }
        return ultimoId + 1;
    }
    
    public  void eliminarJugadorPorId(int idJugador) {
        // Iterar sobre la lista de jugadores
        for (int i = 0; i < jugadores.size(); i++) {
            // Obtener el jugador actual
            Jugador jugador = jugadores.get(i);
            // Verificar si el ID del jugador coincide con el ID proporcionado
            if (jugador.getId() == idJugador) {
                // Eliminar el jugador de la lista
                jugadores.remove(i);
                // Salir del bucle, ya que se ha eliminado el jugador
                break;
            }
        }
    }
    
    public Jugador buscarJugadorPorId(int idJugador) {
    // Iterar sobre la lista de jugadores
    for (Jugador jugador : jugadores) {
        // Verificar si el ID del jugador coincide con el ID proporcionado
        if (jugador.getId() == idJugador) {
            // Devolver el jugador encontrado
            return jugador;
        }
    }
    // Si no se encuentra ningún jugador con el ID especificado, devolver null
    return null;
}
}