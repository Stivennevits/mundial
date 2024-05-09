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
    
    // Método para inicializar la lista de equipos
    private static void inicializarEquipos() {
        Mundial mundial = new Mundial();
        Equipo equipoActual = null;
        ArrayList<Jugador> jugadores = null;
        String rutaArchivo = servletContext.getRealPath("/WEB-INF/data/mundial.txt");
        File archivo = new File(rutaArchivo);
        if (archivo.exists()) {
            try (BufferedReader lector = new BufferedReader(new FileReader(archivo))) {
            String linea;
            while ((linea = lector.readLine()) != null) {
                if (linea.startsWith("*_Equipo:")) {
                    // Si hay un equipo anterior, agregamos los jugadores a ese equipo
                    if (equipoActual != null && jugadores != null) {
                        equipoActual.setJugadores(jugadores);
                        try {
                            mundial.agregarEquipo(equipoActual);
                        } catch (NombreDuplicadoException ex) {
                            Logger.getLogger(GestionarMundial.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }

                    // Creamos un nuevo equipo
                    equipoActual = new Equipo();
                    equipoActual.setNombre(linea.substring(10).trim());
                    jugadores = new ArrayList<>();
                }else if (linea.startsWith("Id:")) {
                        if (equipoActual != null) {
                        equipoActual.setId(Integer.parseInt(linea.substring(4).trim()));
                    }
                } else if (linea.startsWith("Director Tecnico:")) {
                    if (equipoActual != null) {
                        equipoActual.setDirectorTecnico(linea.substring(18).trim());
                    }
                } else if (linea.startsWith("Bandera:")) {
                    if (equipoActual != null) {
                        equipoActual.setBandera(linea.substring(9).trim());
                    }
                    
                } else if (linea.startsWith("Jugadores:")) {
                    // Saltamos la línea de encabezado
                    lector.readLine();
                    // Leemos los jugadores del equipo
                    String jugadorLine;
                    while (!(jugadorLine = lector.readLine()).equals("")) {
                        Jugador jugador = new Jugador();
                        jugador.setId(Integer.parseInt(jugadorLine.substring(jugadorLine.indexOf("Id:") + 4).trim()));
                        jugador.setNombre(lector.readLine().substring(11).trim());
                        jugador.setEdad(Integer.parseInt(lector.readLine().substring(10).trim()));
                        jugador.setAltura(Double.parseDouble(lector.readLine().substring(11).trim()));
                        jugador.setPeso(Double.parseDouble(lector.readLine().substring(9).trim()));
                        jugador.setSalario(Double.parseDouble(lector.readLine().substring(12).trim()));
                        jugador.setRutaImagen(lector.readLine().substring(16).trim());
                        jugador.setPosicion(lector.readLine().substring(14).trim());
                        jugadores.add(jugador);
                        // Leer la línea en blanco
                        lector.readLine();
                        lector.mark(4096); // marca el inicio de la línea
                        String nextLine = lector.readLine();
                        if (nextLine != null) {
                            if (!(nextLine.substring(0, 9).equals("*_Equipo:"))) {
                                lector.reset(); // retrocede al inicio de la línea
                            } else {
                                lector.reset();
                                break;
                            }
                        } else {
                            break; // Salir del bucle si nextLine es null (fin del archivo)
                        }
                    }
                }
            }

            // Agregamos el último equipo
            if (equipoActual != null && jugadores != null) {
                equipoActual.setJugadores(jugadores);
                try {
                    mundial.agregarEquipo(equipoActual);
                } catch (NombreDuplicadoException ex) {
                    Logger.getLogger(GestionarMundial.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        } catch (IOException e) {
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
    
    public static void guardarMundial() {
        String filePath = servletContext.getRealPath("/WEB-INF/data/mundial.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Equipo equipo : Mundial.getEquipos()) {
                // Verifica si el equipo ya existe en el archivo
                boolean equipoExistente = equipoExistenteEnArchivo(filePath, equipo.getNombre());
    
                // Escribe la información del equipo
                writer.write("*_Equipo: " + equipo.getNombre());
                writer.newLine();
                writer.write("Id: " + equipo.getId()); // No se cambia el ID existente
                writer.newLine();
                writer.write("Director Tecnico: " + equipo.getDirectorTecnico());
                writer.newLine();
                writer.write("Bandera: " + equipo.getBandera());
                writer.newLine();
                writer.write("Jugadores:");
                writer.newLine();
    
                List<Jugador> jugadores = equipo.getJugadores();
                for (Jugador jugador : jugadores) {
                    int totalJugadores = jugador.getId();

                    writer.write("\n    Id: " + totalJugadores);
                    writer.newLine();
                    writer.write("    Nombre: " + jugador.getNombre());
                    writer.newLine();
                    writer.write("    Edad: " + jugador.getEdad());
                    writer.newLine();
                    writer.write("    Altura: " + jugador.getAltura());
                    writer.newLine();
                    writer.write("    Peso: " + jugador.getPeso());
                    writer.newLine();
                    int salarioEntero = (int) jugador.getSalario(); // Convertir a entero
                    writer.write("    Salario: " + salarioEntero);
                    writer.newLine();
                    writer.write("    Ruta Imagen: " + jugador.getRutaImagen());
                    writer.newLine();
                    writer.write("    Posicion: " + jugador.getPosicion());
                    writer.newLine();
                }
                writer.newLine();
            }
    
        } catch (IOException e) {
            System.err.println("Error al guardar el archivo: " + e.getMessage());
        }
    }
    

    private static boolean equipoExistenteEnArchivo(String filePath, String nombreEquipo) {
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String linea;
            while ((linea = reader.readLine()) != null) {
                if (linea.startsWith("*_Equipo: ") && linea.substring(10).trim().equals(nombreEquipo)) {
                    return true;
                }
            }
        } catch (IOException e) {
            System.err.println("Error al leer el archivo: " + e.getMessage());
        }
        return false;
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

    

}
