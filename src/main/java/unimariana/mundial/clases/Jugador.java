package unimariana.mundial.clases;

import java.io.Serializable;

public class Jugador implements Serializable{
    private int id;
    private String nombre;
    private int edad;
    private double altura;
    private double peso;
    private double salario;
    private String logoImagen;
    private String posicion;    

    public Jugador(int id, String nombre, int edad, double altura, double peso, double salario, String rutaImagen, String posicion) {
        this.id = id;
        this.nombre = nombre;
        this.edad = edad;
        this.altura = altura;
        this.peso = peso;
        this.salario = salario;
        this.logoImagen = rutaImagen;
        this.posicion = posicion;
    }

    public Jugador() {
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

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }

    public double getAltura() {
        return altura;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }

    public double getSalario() {
        return salario;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }

    public String getRutaImagen() {
        return logoImagen;
    }

    public void setRutaImagen(String rutaImagen) {
        this.logoImagen = rutaImagen;
    }

    public String getPosicion() {
        return posicion;
    }

    public void setPosicion(String posicion) {
        this.posicion = posicion;
    }

    @Override
    public String toString() {
        return "Jugador{" + "id=" + id + ", nombre=" + nombre + ", edad=" + edad + ", altura=" + altura + ", peso=" + peso + ", salario=" + salario + ", logoImagen=" + logoImagen + ", posicion=" + posicion + '}';
    }

    
}
