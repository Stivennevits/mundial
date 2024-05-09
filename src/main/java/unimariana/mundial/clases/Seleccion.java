package unimariana.mundial.clases;

import java.util.ArrayList;
import unimariana.mundial.excepciones.NombreExisteExcepcion;

public class Seleccion {
    private int id;
    private String nombre;
    private String dt;
    private String logoBandera;
    private ArrayList<Jugador> jugadores;

    public Seleccion(int id, String nombre, String directorTecnico, String bandera, ArrayList<Jugador> jugadores) {
        this.id = id;
        this.nombre = nombre;
        this.dt = directorTecnico;
        this.logoBandera = bandera;
        this.jugadores = jugadores;
    }

    public Seleccion() {
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
        return dt;
    }

    public void setDirectorTecnico(String directorTecnico) {
        this.dt = directorTecnico;
    }

    public String getBandera() {
        return logoBandera;
    }

    public void setBandera(String bandera) {
        this.logoBandera = bandera;
    }

    public  void agregarJugador(Jugador jugador) throws NombreExisteExcepcion {
        if (!jugadores.contains(jugador)) {
            jugadores.add(jugador);
        } else {
            throw new NombreExisteExcepcion("Ya existe un registro con el jugador que quieres ingresar");
        }
    }

    public void setJugadores(ArrayList<Jugador> jugadores) {
        this.jugadores = jugadores;
    }

    public ArrayList<Jugador> getJugadores() {
        return jugadores;
    }
    
    public  int siguienteId() {
        int ultimoId = 0;
        for (Jugador jugador : jugadores) {
            if (jugador.getId() > ultimoId) {
                ultimoId = jugador.getId();
            }
        }
        return ultimoId + 1;
    }
    
    public  void eliminarJugador(int idJugador) {
        for (int i = 0; i < jugadores.size(); i++) {
            Jugador jugador = jugadores.get(i);
            if (jugador.getId() == idJugador) {
                jugadores.remove(i);
                break;
            }
        }
    }
    
    public Jugador buscarJugador(int idJugador) {
    for (Jugador jugador : jugadores) {
        if (jugador.getId() == idJugador) {
            return jugador;
        }
    }
        return null;
    }

    @Override
    public String toString() {
        return "Seleccion{" + "id=" + id + ", nombre=" + nombre + ", dt=" + dt + ", logoBandera=" + logoBandera + ", jugadores=" + jugadores + '}';
    }
    
}