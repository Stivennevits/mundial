package umariana.mundial;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

public class GestionarMundial {
    private static Mundial mundial = new Mundial();
    private static List<Equipo> equipos = new ArrayList<>(); // Inicialización de la lista de equipos
    private static ServletContext servletContext; // Contexto del servlet

    // Establece el contexto del servlet
    public static void setServletContext(ServletContext context) {
        servletContext = context;
        inicializarEquipos(); // Inicializa la lista de equipos desde el archivo
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

        // Guardar el nuevo equipo en el archivo equipo.txt
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

        // Guardar el nuevo equipo en el archivo equipo.txt
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
    private static void inicializarEquipos() {
        Mundial mundial = new Mundial(); // Creamos un nuevo Mundial
        ArrayList<Jugador> jugadores = null; // Inicializamos la lista de jugadores como nula
        String rutaArchivo = servletContext.getRealPath("/WEB-INF/data/mundial.txt"); // Obtenemos la ruta del archivo de datos
        File archivo = new File(rutaArchivo); // Creamos un objeto File para el archivo

        if (archivo.exists()) { // Verificamos si el archivo existe
            try (BufferedReader lector = new BufferedReader(new FileReader(archivo))) { // Creamos un BufferedReader para leer el archivo
                String linea; // Variable para almacenar cada línea leída del archivo
                Equipo equipoActual = null; // Inicializamos el equipo actual como nulo
                while ((linea = lector.readLine()) != null) { // Mientras haya líneas por leer en el archivo
                    String[] campos = linea.split(";"); // Dividimos la línea en campos separados por ";"
                    if (campos.length == 4) { // Si hay 4 campos, es un equipo
                        // Si hay un equipo anterior, agregamos los jugadores a ese equipo
                        if (equipoActual != null && jugadores != null) {
                            equipoActual.setJugadores(jugadores); // Asignamos la lista de jugadores al equipo actual
                            try {
                                mundial.agregarEquipo(equipoActual); // Agregamos el equipo al Mundial
                            } catch (NombreDuplicadoException ex) {
                                Logger.getLogger(GestionarMundial.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        // Creamos un nuevo equipo
                        equipoActual = new Equipo(); // Inicializamos un nuevo equipo
                        equipoActual.setId(Integer.parseInt(campos[0])); // Asignamos el ID del equipo
                        equipoActual.setNombre(campos[1]); // Asignamos el nombre del equipo
                        equipoActual.setDirectorTecnico(campos[2]); // Asignamos el director técnico del equipo
                        equipoActual.setBandera(campos[3]); // Asignamos la ruta de la bandera del equipo
                        jugadores = new ArrayList<>(); // Inicializamos la lista de jugadores para el nuevo equipo
                    } else if (campos.length == 9) { // Si hay 8 campos, es un jugador
                        Jugador jugador = new Jugador(); // Creamos un nuevo jugador
                        jugador.setId(Integer.parseInt(campos[1])); // Asignamos el ID del jugador
                        jugador.setNombre(campos[2]); // Asignamos el nombre del jugador
                        jugador.setEdad(Integer.parseInt(campos[3])); // Asignamos la edad del jugador
                        jugador.setAltura(Double.parseDouble(campos[4])); // Asignamos la altura del jugador
                        jugador.setPeso(Double.parseDouble(campos[5])); // Asignamos el peso del jugador
                        jugador.setSalario(Double.parseDouble(campos[6])); // Asignamos el salario del jugador
                        jugador.setRutaImagen(campos[7]); // Asignamos la ruta de la imagen del jugador
                        jugador.setPosicion(campos[8]); // Asignamos la posición del jugador
                        jugadores.add(jugador); // Agregamos el jugador a la lista de jugadores del equipo actual
                    }
                }

                // Agregamos el último equipo
                if (equipoActual != null && jugadores != null) {
                    equipoActual.setJugadores(jugadores); // Asignamos la lista de jugadores al último equipo
                    try {
                        mundial.agregarEquipo(equipoActual); // Agregamos el último equipo al Mundial
                    } catch (NombreDuplicadoException ex) {
                        Logger.getLogger(GestionarMundial.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } catch (IOException e) {
                // Manejo de excepciones
            }
        }
    }

    public static List<Equipo> obtenerTodosLosEquipos() {
        return equipos;
    }

    private static boolean verificarExistencia(ArrayList<Equipo> equipos, int id) {
        for (Equipo equipo : equipos) {
            for (Jugador jugador : equipo.getJugadores()) {
                if (jugador.getId() == id) {
                    return true;
                }
            }
        }
        return false;
    }    
    
    private static void guardarMundial() {
        String filePath = servletContext.getRealPath("/WEB-INF/data/mundial.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Equipo equipo : Mundial.getEquipos()) {
                // Verifica si el equipo ya existe en el archivo
                boolean equipoExistente = equipoExistenteEnArchivo(filePath, equipo.getNombre());
    
                // Si el equipo no existe en el archivo, escribe su información
                if (!equipoExistente) {
                    writer.write(equipo.getId() + ";" + equipo.getNombre() + ";" + equipo.getDirectorTecnico() + ";" + equipo.getBandera());
                    writer.newLine();
                }
    
                // Escribe la información de los jugadores
                List<Jugador> jugadores = equipo.getJugadores();
                for (Jugador jugador : jugadores) {
                    writer.write(equipo.getId() + ";" + jugador.getId() + ";" + jugador.getNombre() + ";" + jugador.getEdad() + ";" + jugador.getAltura() + ";" + jugador.getPeso() + ";" + jugador.getSalario() + ";" + jugador.getRutaImagen() + ";" + jugador.getPosicion());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            System.err.println("Error al guardar el archivo: " + e.getMessage());
        }
    }
    
    private static boolean equipoExistenteEnArchivo(String filePath, String nombreEquipo) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                if (linea.startsWith(nombreEquipo)) {
                    return true;
                }
            }
        } catch (IOException e) {
            System.err.println("Error al leer el archivo: " + e.getMessage());
        }
        return false;
    }

}