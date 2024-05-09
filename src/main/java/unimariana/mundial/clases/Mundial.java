package unimariana.mundial.clases;

import java.util.ArrayList;
import unimariana.mundial.excepciones.NombreExisteExcepcion;

public class Mundial {
    private static ArrayList<Seleccion> selecciones;


    public Mundial() {
        this.selecciones = new ArrayList<>();
    }
    
    public static void agregarSeleccion(Seleccion seleccion) throws NombreExisteExcepcion {
        if (!selecciones.contains(seleccion)) {
            selecciones.add(seleccion);
        } else {
            throw new NombreExisteExcepcion("Ya existe un registro con el seleccion que quieres ingresar");
        }
    }
    
    public static ArrayList<Seleccion> dameTodasSelecciones() {
        return selecciones;
    }
    
    public static Seleccion dameSeleccion(int idSeleccion) {
        for (Seleccion seleccion : selecciones) {
            if (seleccion.getId() == idSeleccion) {
                return seleccion;
            }
        }
        return null;
    }

    public static int siguienteId() {
        int ultimoId = 0;
        for (Seleccion seleccion : selecciones) {
            if (seleccion.getId() > ultimoId) {
                ultimoId = seleccion.getId();
            }
        }
        return ultimoId + 1;
    }

    public static void eliminarSeleccion(int id) {
        for (int i = 0; i < selecciones.size(); i++) {
            if (selecciones.get(i).getId() == id) {
                selecciones.remove(i);
                return;
            }
        }
    }
    
}
