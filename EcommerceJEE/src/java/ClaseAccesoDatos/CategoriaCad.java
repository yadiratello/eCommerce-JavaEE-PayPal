
package ClaseAccesoDatos;

import beans.Categoria;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class CategoriaCad {
    
    public static ArrayList<Categoria> listarCategoria(){
        
        try {
            String sql = "{call sp_listar_categoria_superior()}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            ResultSet resultado = sentencia.executeQuery();
            
            ArrayList<Categoria> lista = new ArrayList<Categoria>();
            
            while (resultado.next()) {
                
                Categoria cat = new Categoria();
                
                cat.setCodigo(resultado.getInt("codigo"));
                cat.setNombre(resultado.getString("nombre"));
                
                lista.add(cat);
            }
            
            return lista;
                    
        } catch (SQLException ex) {
            return null;
        }
    }
    
    
    public static ArrayList<Categoria> listarSubCategoria(int categoriaSuperior){
        
        try {
            String sql = "{call sp_listar_sub_categoria(?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setInt(1, categoriaSuperior);
            
            ResultSet resultado = sentencia.executeQuery();
            
            ArrayList<Categoria> lista = new ArrayList<Categoria>();
            
            while (resultado.next()) {
                
                Categoria cat = new Categoria();
                
                cat.setCodigo(resultado.getInt("codigo"));
                cat.setNombre(resultado.getString("nombre"));
                
                lista.add(cat);
            }
            
            return lista;
                    
        } catch (SQLException ex) {
            return null;
        }
    }
    
    
    
    public static boolean cantidadCategorias(int cat){
        
        try {
            String sql = "{call sp_contar_categorias(?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setInt(1, cat);
            
            ResultSet resultado = sentencia.executeQuery();
            
            
            resultado.next();
               
            
            return resultado.getInt("cantidad")>0;
                    
        } catch (SQLException ex) {
            return false;
        }
    }
    
    
    public static ArrayList<Categoria> listarTodasCategorias(){
        
        try {
            String sql = "{call sp_listar_categorias()}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
                        
            ResultSet resultado = sentencia.executeQuery();
            
            ArrayList<Categoria> lista = new ArrayList<Categoria>();
            
            while (resultado.next()) {
                
                Categoria cat = new Categoria();
                
                cat.setCodigo(resultado.getInt("codigo"));
                cat.setNombre(resultado.getString("nombre"));
                
                lista.add(cat);
            }
            
            return lista;
                    
        } catch (SQLException ex) {
            return null;
        }
    }
    
    
}
