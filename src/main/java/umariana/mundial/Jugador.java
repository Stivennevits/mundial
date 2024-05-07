package umariana.mundial;

import java.io.Serializable;

public class Jugador implements Serializable{
    // Atributos
    private int idJugador;
    private String nombreJugador;
    private int edad;
    private double altura;
    private double peso;
    private double salario;
    private String posicion;
    
    //Constructores
    public Jugador() {
    }

    public Jugador(int idJugador, String nombreJugador, int edad, double altura, double peso, double salario, String posicion) {
        this.idJugador = idJugador;
        this.nombreJugador = nombreJugador;
        this.edad = edad;
        this.altura = altura;
        this.peso = peso;
        this.salario = salario;
        this.posicion = posicion;
    }

    public int getIdJugador() {
        return idJugador;
    }

    public String getNombreJugador() {
        return nombreJugador;
    }

    public int getEdad() {
        return edad;
    }

    public double getAltura() {
        return altura;
    }

    public double getPeso() {
        return peso;
    }

    public double getSalario() {
        return salario;
    }

    public String getPosicion() {
        return posicion;
    }

    public void setIdJugador(int idJugador) {
        this.idJugador = idJugador;
    }

    public void setNombreJugador(String nombreJugador) {
        this.nombreJugador = nombreJugador;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }

    public void setPosicion(String posicion) {
        this.posicion = posicion;
    }
}
