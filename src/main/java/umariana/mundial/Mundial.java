package umariana.mundial;

import java.util.ArrayList;

public class Mundial {
    private static ArrayList<Equipo> equipos;


    public Mundial() {
        this.equipos = new ArrayList<>();
    }
    
    public static void agregarEquipo(Equipo equipo) throws NombreDuplicadoException {
        if (!equipos.contains(equipo)) {
            equipos.add(equipo);
        } else {
            throw new NombreDuplicadoException("Ya existe un registro con el equipo que quieres ingresar");
        }
    }
    
    public static ArrayList<Equipo> getEquipos() {
        return equipos;
    }
    
    public static Equipo getEquipoPorId(int idEquipo) {
        for (Equipo equipo : equipos) {
            if (equipo.getId() == idEquipo) {
                return equipo;
            }
        }
        return null;
    }

    public static int generarIdSiguiente() {
        int ultimoId = 0;
        for (Equipo equipo : equipos) {
            if (equipo.getId() > ultimoId) {
                ultimoId = equipo.getId();
            }
        }
        return ultimoId + 1;
    }

    public static void eliminarEquipoPorId(int id) {
        for (int i = 0; i < equipos.size(); i++) {
            if (equipos.get(i).getId() == id) {
                equipos.remove(i);
                System.out.println("Equipo con ID " + id + " eliminado correctamente.");
                return; // Termina el método después de eliminar el equipo
            }
        }
        System.out.println("No se encontró ningún equipo con el ID " + id);
    }
    
    
}
