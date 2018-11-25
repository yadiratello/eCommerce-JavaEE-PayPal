
package ClaseAccesoDatos;

import beans.Producto;
import beans.ProductoMoneda;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class ProductoCad {
    
    
    
    public static boolean registrarProducto(Producto p, ProductoMoneda cop, ProductoMoneda usd, ProductoMoneda pen){
        
        try {
            String sql = "{call sp_registrar_producto(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setString(1, p.getNombre());
            sentencia.setFloat(2, p.getPrecio());
            sentencia.setFloat(3, p.getPrecio_nuevo());
            sentencia.setInt(4, p.getStock());
            sentencia.setBoolean(5, p.isNuevo());
            sentencia.setBoolean(6, p.isRecomendado());
            sentencia.setString(7, p.getDescripcion());
            sentencia.setBoolean(8, p.isEstado());
            sentencia.setInt(9, p.getCodigo_marca());
            sentencia.setInt(10, p.getCodigo_categoria());
            sentencia.setString(11, p.getImagen());
            
            sentencia.setString(12, cop.getMoneda());
            sentencia.setFloat(13, cop.getPrecio());
            sentencia.setFloat(14, cop.getPrecio_nuevo());
            
            sentencia.setString(15, usd.getMoneda());
            sentencia.setFloat(16, usd.getPrecio());
            sentencia.setFloat(17, usd.getPrecio_nuevo());
            
            sentencia.setString(18, pen.getMoneda());
            sentencia.setFloat(19, pen.getPrecio());
            sentencia.setFloat(20, pen.getPrecio_nuevo());
                                  
            return sentencia.executeUpdate()>0;
                    
        } catch (SQLException ex) {
            return false;            
        }
    }

    public static ArrayList<Producto> listarProductosActivos(String moneda){
        
        try {
            String sql = "{call sp_listarProductosActivos(?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setString(1, moneda);
            
            ResultSet res = sentencia.executeQuery();
            
            ArrayList<Producto> lista = new ArrayList<>();
            
            while(res.next()){
                
                Producto p = new Producto();
                p.setWebid(res.getInt("webid"));
                p.setNombre(res.getString("nombre"));
                p.setImagen(res.getString("imagen"));
                p.setStock(res.getInt("stock"));
                p.setNuevo(res.getBoolean("nuevo"));
                
               
                if(!moneda.equalsIgnoreCase("MXN")){
                    p.setPrecio(res.getFloat("precio2"));
                    p.setPrecio_nuevo(res.getFloat("precioNuevo2"));
                }else{
                    p.setPrecio(res.getFloat("precio"));
                    p.setPrecio_nuevo(res.getFloat("precio_nuevo"));
                }
                lista.add(p);
            }
            return lista;       
        } catch (SQLException ex) {
            return null;            
        }
    }

    public static ArrayList<Producto> listarProductosPorCategoria(String moneda, int codcat){
        
        try {
            String sql = "{call sp_listarProductosPorCategoria(?,?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setString(1, moneda);
            sentencia.setInt(2, codcat);
            
            ResultSet res = sentencia.executeQuery();
            
            ArrayList<Producto> lista = new ArrayList<>();
            
            while(res.next()){
                
                Producto p = new Producto();
                p.setWebid(res.getInt("webid"));
                p.setNombre(res.getString("nombre"));
                p.setImagen(res.getString("imagen"));
                p.setStock(res.getInt("stock"));
                p.setNuevo(res.getBoolean("nuevo"));
                
               
                if(!moneda.equalsIgnoreCase("MXN")){
                    p.setPrecio(res.getFloat("precio2"));
                    p.setPrecio_nuevo(res.getFloat("precioNuevo2"));
                }else{
                    p.setPrecio(res.getFloat("precio"));
                    p.setPrecio_nuevo(res.getFloat("precio_nuevo"));
                }
                lista.add(p);
            }
            return lista;       
        } catch (SQLException ex) {
            return null;            
        }
    }
    
    public static ArrayList<Producto> listarProductosPorMarca(String moneda, int codmar){
        
        try {
            String sql = "{call sp_listarProductosPorMarca(?,?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setString(1, moneda);
            sentencia.setInt(2, codmar);
            
            ResultSet res = sentencia.executeQuery();
            
            ArrayList<Producto> lista = new ArrayList<>();
            
            while(res.next()){
                
                Producto p = new Producto();
                p.setWebid(res.getInt("webid"));
                p.setNombre(res.getString("nombre"));
                p.setImagen(res.getString("imagen"));
                p.setStock(res.getInt("stock"));
                p.setNuevo(res.getBoolean("nuevo"));
                
               
                if(!moneda.equalsIgnoreCase("MXN")){
                    p.setPrecio(res.getFloat("precio2"));
                    p.setPrecio_nuevo(res.getFloat("precioNuevo2"));
                }else{
                    p.setPrecio(res.getFloat("precio"));
                    p.setPrecio_nuevo(res.getFloat("precio_nuevo"));
                }
                lista.add(p);
            }
            return lista;       
        } catch (SQLException ex) {
            return null;            
        }
    }

    public static Producto consultarProducto(String moneda, int webid){
        
        try {
            String sql = "{call sp_consultarProducto(?,?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
            
            sentencia.setString(1, moneda);
            sentencia.setInt(2, webid);
            
            ResultSet res = sentencia.executeQuery();
            Producto p = null;
            
            if(res.next()){
                
                p = new Producto();
                p.setWebid(res.getInt("webid"));
                p.setNombre(res.getString("nombre"));
                p.setImagen(res.getString("imagen"));
                p.setStock(res.getInt("stock"));
                p.setNuevo(res.getBoolean("nuevo"));
                
               
                if(!moneda.equalsIgnoreCase("MXN")){
                    p.setPrecio(res.getFloat("precio2"));
                    p.setPrecio_nuevo(res.getFloat("precioNuevo2"));
                }else{
                    p.setPrecio(res.getFloat("precio"));
                    p.setPrecio_nuevo(res.getFloat("precio_nuevo"));
                }
            }
            return p;       
        } catch (SQLException ex) {
            return null;            
        }
    }
}
