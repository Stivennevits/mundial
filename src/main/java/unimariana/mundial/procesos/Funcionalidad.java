package unimariana.mundial.procesos;

import unimariana.mundial.excepciones.NombreExisteExcepcion;
import unimariana.mundial.clases.Seleccion;
import unimariana.mundial.clases.Mundial;
import unimariana.mundial.clases.Jugador;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

public class Funcionalidad {
    private static ArrayList<Seleccion> selecciones = new ArrayList<>();
    private static ServletContext servletContext;
    
    // Establece el contexto del servlet
    public static void setServletContext(ServletContext context) {
        servletContext = context;
        cargarDataRam();
    }
    
    public static ArrayList<Seleccion> obtenerTodosLasSelecciones() {
        return selecciones;
    }
    
    public static void agregarSeleccion(String nombreSeleccion, String director, String logoPath) throws NombreExisteExcepcion, IOException {
        // Verificar si ya existe un seleccion con el mismo nombre
        for (Seleccion seleccion : Mundial.dameTodasSelecciones()) {
            if (seleccion.getNombre().equalsIgnoreCase(nombreSeleccion)) {
                throw new NombreExisteExcepcion("Ya existe un seleccion con ese nombre, inténtelo nuevamente.");
            }
        }

        // Obtener id único para el nuevo seleccion
        int idSeleccion = Mundial.siguienteId();

        // Crear unaSeleccion
        Seleccion miSeleccion = new Seleccion(idSeleccion, nombreSeleccion, director, logoPath,new ArrayList());

        Mundial.agregarSeleccion(miSeleccion);

        // Guardar la nueva seleccion en el archivo data.txt
        persistirData();
    }
    
    public void editarSeleccion(int idSeleccion, String nombreSeleccion, String director, String nuevoLogoCargado) {
        Seleccion seleccion = Mundial.dameSeleccion(idSeleccion);
        seleccion.setNombre(nombreSeleccion);
        seleccion.setDirectorTecnico(director);
        seleccion.setBandera(nuevoLogoCargado);
        
        persistirData();
    }
    
    public static void eliminarSeleccion(int id) {
        Mundial.eliminarSeleccion(id);
        persistirData();
    }
    
    public void agregarJugador(int idSeleccion, String nombre, int edad, double altura, double peso, String posicion, double salario, String urlImagen) throws NombreExisteExcepcion {

        // Verificar si ya existe un seleccion con el mismo nombre
        for (Seleccion seleccion : Mundial.dameTodasSelecciones()) {
            for(Jugador jugador : seleccion.getJugadores()){
                if (jugador.getNombre().equalsIgnoreCase(nombre)) {
                throw new NombreExisteExcepcion("Ya existe un seleccion con ese nombre, inténtelo nuevamente.");
            }
           }

        }

        Seleccion seleccion = Mundial.dameSeleccion(idSeleccion);
        
        int totalJugadores = 0;
        ArrayList<Seleccion> selecciones = Mundial.dameTodasSelecciones();

        for (Seleccion seleccionAdicional : selecciones) {
            totalJugadores += seleccionAdicional.getJugadores().size();
        }

        // Crear un jugador 
        Jugador jugador = new Jugador(totalJugadores+1,nombre,edad,altura,peso,salario,urlImagen,posicion);

        seleccion.agregarJugador(jugador);

        persistirData();
    }

    public void editarJugador(int idSeleccion, int idJugador, String nombre, int edad, double altura, double peso, String posicion, double salario, String nuevoLogoCargado) {
        Seleccion seleccion = Mundial.dameSeleccion(idSeleccion);
        Jugador jugador = seleccion.buscarJugador(idJugador);
        jugador.setNombre(nombre);
        jugador.setEdad(edad);
        jugador.setAltura(altura);
        jugador.setPeso(peso);
        jugador.setPosicion(posicion);
        jugador.setSalario(salario);
        jugador.setRutaImagen(nuevoLogoCargado);
        
        persistirData();
    } 
    
    public static void eliminarJugador(int idSeleccion, int id) {
        Seleccion seleccion = Mundial.dameSeleccion(idSeleccion);
        seleccion.eliminarJugador(id);
        persistirData();
    }
 
    private static void cargarDataRam() {
        Mundial mundial = new Mundial();
        ArrayList<Jugador> jugadores = new ArrayList<>(); // Inicializamos la lista de jugadores como nula
        String rutaArchivo = servletContext.getRealPath("/WEB-INF/data/data.txt"); // Obtenemos la ruta del archivo de datos
        File archivo = new File(rutaArchivo); // Creamos un objeto File para el archivo
    
        if (archivo.exists()) { // Verificamos si el archivo existe
            try (BufferedReader lector = new BufferedReader(new FileReader(archivo))) { // Creamos un BufferedReader para leer el archivo
                String linea; // Variable para almacenar cada línea leída del archivo
                Seleccion equipoActual = null; // Inicializamos el equipo actual como nulo
                while ((linea = lector.readLine()) != null) { // Mientras haya líneas por leer en el archivo
                    String[] campos = linea.split(";"); // Dividimos la línea en campos separados por ";"
                   
                    if (campos.length == 4) { // Si hay 4 campos, es un equipo
                        // Si hay un equipo anterior, agregamos los jugadores a ese equipo
                        if (equipoActual != null && jugadores != null) {
                            equipoActual.setJugadores(jugadores); // Asignamos la lista de jugadores al equipo actual
                            try {
                                mundial.agregarSeleccion(equipoActual); // Agregamos el equipo al Mundial
                            } catch (NombreExisteExcepcion ex) {
                                Logger.getLogger(Funcionalidad.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                        // Creamos un nuevo equipo
                        equipoActual = new Seleccion(); // Inicializamos un nuevo equipo
                        equipoActual.setNombre(campos[0]); // Asignamos el nombre del equipo
                        equipoActual.setDirectorTecnico(campos[1]); // Asignamos el director técnico del equipo
                        equipoActual.setBandera(campos[2]); // Asignamos la ruta de la bandera del equipo
                        equipoActual.setId(Integer.parseInt(campos[3])); // Asignamos el ID del equipo
                        jugadores = new ArrayList<>(); // Inicializamos la lista de jugadores para el nuevo equipo
                    } else if (campos.length == 8) { // Si hay 8 campos, es un jugador
                        Jugador jugador = new Jugador(); // Creamos un nuevo jugador
                        jugador.setId(Integer.parseInt(campos[0])); // Asignamos el ID del jugador
                        jugador.setNombre(campos[1]); // Asignamos el nombre del jugador
                        jugador.setEdad(Integer.parseInt(campos[2])); // Asignamos la edad del jugador
                        jugador.setAltura(Double.parseDouble(campos[3])); // Asignamos la altura del jugador
                        jugador.setPeso(Double.parseDouble(campos[4])); // Asignamos el peso del jugador
                        jugador.setSalario(Double.parseDouble(campos[5])); // Asignamos el salario del jugador
                        jugador.setRutaImagen(campos[6]); // Asignamos la ruta de la imagen del jugador
                        jugador.setPosicion(campos[7]); // Asignamos la posición del jugador
                       
                        jugadores.add(jugador); // Agregamos el jugador a la lista de jugadores del equipo actual
                    }
                    
                }
    
                // Agregamos el último equipo
                if (equipoActual != null && jugadores != null) {
                    equipoActual.setJugadores(jugadores); // Asignamos la lista de jugadores al último equipo
                    try {
                        mundial.agregarSeleccion(equipoActual); // Agregamos el último equipo al Mundial
                    } catch (NombreExisteExcepcion ex) {
                        Logger.getLogger(Funcionalidad.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
            } catch (IOException e) {
                // Manejo de excepciones
      
            }
        }
    }
    
    private static void persistirData() {
        String filePath = servletContext.getRealPath("/WEB-INF/data/data.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Seleccion equipo : Mundial.dameTodasSelecciones()) {
                writer.write(equipo.getNombre() + ";" + equipo.getDirectorTecnico() + ";" + equipo.getBandera() + ";" + equipo.getId());
                writer.newLine();
                List<Jugador> jugadores = equipo.getJugadores();
                for (Jugador jugador : jugadores) {
                    writer.write(jugador.getId() + ";" + jugador.getNombre() + ";" + jugador.getEdad() + ";" + jugador.getAltura() + ";" + jugador.getPeso() + ";" + jugador.getSalario() + ";" + jugador.getRutaImagen() + ";" + jugador.getPosicion());
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            System.err.println("Error al guardar el archivo: " + e.getMessage());
        }
    }
    
    private static boolean seleccionExistenteEnArchivo(String filePath, String nombreEquipo) {
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