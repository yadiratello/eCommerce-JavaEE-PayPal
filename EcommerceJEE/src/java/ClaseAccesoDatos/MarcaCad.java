
package ClaseAccesoDatos;

import beans.Marca;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;


public class MarcaCad {
    
    public static ArrayList<Marca> listarTodasMarcas(){
        
        try {
            String sql = "{call sp_listar_marcas()}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
                        
            ResultSet resultado = sentencia.executeQuery();
            
            ArrayList<Marca> lista = new ArrayList<Marca>();
            
            while (resultado.next()) {
                
                Marca mar = new Marca();
                
                mar.setCodigo(resultado.getInt("codigo"));
                mar.setNombre(resultado.getString("nombre"));
                
                lista.add(mar);
            }
            
            return lista;
                    
        } catch (SQLException ex) {
            return null;
        }
    
    }
    
    
    public static int contarMarcas(int codmarca){
        
        try {
            String sql = "{call sp_contarProductosPorMarca(?)}";
            
            Connection con = Conexion.conectar();
            
            CallableStatement sentencia = con.prepareCall(sql);
                
            sentencia.setInt(1, codmarca);
            
            ResultSet resultado = sentencia.executeQuery();
            
            resultado.next();
            
            return resultado.getInt(1);//el unico campo del procedimiento alm count(*)
                    
        } catch (SQLException ex) {
            return 0;
        }
    }
}
