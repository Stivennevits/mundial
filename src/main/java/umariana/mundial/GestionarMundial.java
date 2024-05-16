package umariana.mundial;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

public class GestionarMundial {
    private static List<Equipo> equipos = new ArrayList<>(); // Inicialización de la lista de equipos
    private static ServletContext servletContext; // Contexto del servlet

    // Establece el contexto del servlet
    public static void setServletContext(ServletContext context) {
        servletContext = context;
        try {
            inicializarEquipos(); // Inicializa la lista de equipos desde el archivo
        } catch (NombreDuplicadoException ex) {
            Logger.getLogger(GestionarMundial.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Método para agregar un equipo nuevo
    public static void agregarEquipo(String nombreEquipo, String director, String logoPath) throws NombreDuplicadoException, IOException {
        // Verificar si ya existe un equipo con el mismo nombre
        for (Equipo equipo : Mundial.getEquipos()) {
            if (equipo.getNombre().equalsIgnoreCase(nombreEquipo)) {
                throw new NombreDuplicadoException("Ya existe un equipo con ese nombre, inténtelo nuevamente.");
            }
        }

        // Generar un ID único para el nuevo equipo
        int idEquipo = Mundial.generarIdSiguiente();

        // Crear un objeto Equipo con los datos proporcionados
        Equipo miEquipo = new Equipo(idEquipo, nombreEquipo, director, logoPath,new ArrayList());

        Mundial.agregarEquipo(miEquipo);
        guardarMundial();
    }

  
    public static void eliminarEquipo(int id) {
        Mundial.eliminarEquipoPorId(id);
        guardarMundial();
    }

    public static void eliminarJugador(int idEquipo, int id) {
        Equipo equipo = Mundial.getEquipoPorId(idEquipo);
        equipo.eliminarJugadorPorId(id);
        guardarMundial();
    }


    
        public void agregarJugador(int idEquipo, String nombre, int edad, double altura, double peso, String posicion, double salario, String urlImagen) throws NombreDuplicadoException {

        // Verificar si ya existe un equipo con el mismo nombre
        for (Equipo equipo : Mundial.getEquipos()) {
            for(Jugador jugador : equipo.getJugadores()){
                if (jugador.getNombre().equalsIgnoreCase(nombre)) {
                throw new NombreDuplicadoException("Ya existe un equipo con ese nombre, inténtelo nuevamente.");
            }
           }

        }

        // Generar un ID único para el nuevo equipo
        Equipo equipo = Mundial.getEquipoPorId(idEquipo);
        
        int totalJugadores = 0;
        ArrayList<Equipo> equipos = Mundial.getEquipos();

        for (Equipo equipoa : equipos) {
            totalJugadores += equipoa.getJugadores().size();
        }
        //int id = equipo.generarIdSiguiente();

        // Crear un objeto Equipo con los datos proporcionados
        Jugador jugador = new Jugador(totalJugadores+1,nombre,edad,altura,peso,salario,urlImagen,posicion);

        equipo.agregarJugador(jugador);
        guardarMundial();
    }
    
        

    public void editarEquipo(int idEquipo, String nombreEquipo, String director, String nuevoLogoCargado) {
        Equipo equipo = Mundial.getEquipoPorId(idEquipo);
        equipo.setNombre(nombreEquipo);
        equipo.setDirectorTecnico(director);
        equipo.setBandera(nuevoLogoCargado);
        
        guardarMundial();
    }

    public void editarJugador(int idEquipo, int idJugador, String nombre, int edad, double altura, double peso, String posicion, double salario, String nuevoLogoCargado) {
        Equipo equipo = Mundial.getEquipoPorId(idEquipo);
        Jugador jugador = equipo.buscarJugadorPorId(idJugador);
        jugador.setNombre(nombre);
        jugador.setEdad(edad);
        jugador.setAltura(altura);
        jugador.setPeso(peso);
        jugador.setPosicion(posicion);
        jugador.setSalario(salario);
        jugador.setRutaImagen(nuevoLogoCargado);
        
        guardarMundial();
    }    
    
    // Método para inicializar la lista de equipos
private static void inicializarEquipos() throws NombreDuplicadoException {
    Mundial mundial = new Mundial();
    String equiposFilePath = servletContext.getRealPath("/WEB-INF/data/equipos.txt");
    String jugadoresFilePath = servletContext.getRealPath("/WEB-INF/data/jugadores.txt");

    try (BufferedReader equiposReader = new BufferedReader(new FileReader(equiposFilePath));
         BufferedReader jugadoresReader = new BufferedReader(new FileReader(jugadoresFilePath))) {
        String equipoLine;
        while ((equipoLine = equiposReader.readLine()) != null) {
            String[] equipoInfo = equipoLine.split(";");
            Equipo equipo = new Equipo();
            equipo.setId(Integer.parseInt(equipoInfo[0]));
            equipo.setNombre(equipoInfo[1]);
            equipo.setDirectorTecnico(equipoInfo[2]);
            equipo.setBandera(equipoInfo[3]);

            // Leer jugadores asociados a este equipo desde el archivo jugadores.txt
            ArrayList<Jugador> jugadores = new ArrayList<>();
            String jugadorLine;
            while ((jugadorLine = jugadoresReader.readLine()) != null) {
                String[] jugadorInfo = jugadorLine.split(";");
                if (Integer.parseInt(jugadorInfo[0]) == equipo.getId()) {
                    Jugador jugador = new Jugador();
                    jugador.setId(Integer.parseInt(jugadorInfo[1]));
                    jugador.setNombre(jugadorInfo[2]);
                    jugador.setEdad(Integer.parseInt(jugadorInfo[3]));
                    jugador.setAltura(Double.parseDouble(jugadorInfo[4]));
                    jugador.setPeso(Double.parseDouble(jugadorInfo[5]));
                    jugador.setSalario(Double.parseDouble(jugadorInfo[6]));
                    jugador.setRutaImagen(jugadorInfo[7]);
                    jugador.setPosicion(jugadorInfo[8]);
                    jugadores.add(jugador);
                }
            }
            equipo.setJugadores(jugadores);
            mundial.agregarEquipo(equipo);
        }
    } catch (IOException e) {
        System.err.println("Error al inicializar equipos: " + e.getMessage());
    }
}
    public static List<Equipo> obtenerTodosLosEquipos() {
        return equipos;
    }
    
    private static void guardarMundial() {
        String equiposFilePath = servletContext.getRealPath("/WEB-INF/data/equipos.txt");
        String jugadoresFilePath = servletContext.getRealPath("/WEB-INF/data/jugadores.txt");
        try (BufferedWriter equiposWriter = new BufferedWriter(new FileWriter(equiposFilePath));
             BufferedWriter jugadoresWriter = new BufferedWriter(new FileWriter(jugadoresFilePath))) {
            for (Equipo equipo : Mundial.getEquipos()) {
                // Guardar información de equipos
                equiposWriter.write(equipo.getId() + ";" + equipo.getNombre() + ";" + equipo.getDirectorTecnico() + ";" + equipo.getBandera());
                equiposWriter.newLine();

                // Guardar información de jugadores asociados a cada equipo
                List<Jugador> jugadores = equipo.getJugadores();
                for (Jugador jugador : jugadores) {
                    jugadoresWriter.write(equipo.getId() + ";" + jugador.getId() + ";" + jugador.getNombre() + ";" + jugador.getEdad() + ";" +
                            jugador.getAltura() + ";" + jugador.getPeso() + ";" + jugador.getSalario() + ";" + jugador.getRutaImagen() + ";" +
                            jugador.getPosicion());
                    jugadoresWriter.newLine();
                }
            }
        } catch (IOException e) {
            System.err.println("Error al guardar el archivo: " + e.getMessage());
        }
    }

}