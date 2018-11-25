
package beans;

import java.io.Serializable;

public class Categoria implements Serializable{
    private int codigo;
    private String nombre;
    private boolean estado;
    private int categoriaSuperior;

    public Categoria() {
    }

    public Categoria(int codigo, String nombre, boolean estado, int categoriaSuperior) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.estado = estado;
        this.categoriaSuperior = categoriaSuperior;
    }

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public boolean isEstado() {
        return estado;
    }

    public void setEstado(boolean estado) {
        this.estado = estado;
    }

    public int getCategoriaSuperior() {
        return categoriaSuperior;
    }

    public void setCategoriaSuperior(int categoriaSuperior) {
        this.categoriaSuperior = categoriaSuperior;
    }
    
    
    
   
    
    
    
}
