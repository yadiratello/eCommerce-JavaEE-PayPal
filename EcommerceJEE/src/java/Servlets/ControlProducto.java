
package Servlets;

import ClaseAccesoDatos.ProductoCad;
import beans.Producto;
import beans.ProductoMoneda;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


public class ControlProducto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    
    //metodo  que creara atributos con los nombres de los campos del formulario con su valor
    private void recibirDatos(HttpServletRequest request){
        try {
            FileItemFactory fileFactory = new DiskFileItemFactory();
            
            ServletFileUpload servletUpload = new ServletFileUpload(fileFactory);
            
            
            String nombre="";
            
            List items = servletUpload.parseRequest(request);
            
            for (int i = 0; i < items.size(); i++) {
                FileItem item = (FileItem) items.get(i);
                
                if(!item.isFormField()){//si item no es un campo normal de formulario(si no es un archivo file)
                    
                    String ruta = request.getServletContext().getRealPath("/")+"foto/";//guardando la ruta de la imagen q se almacenará en una carpeta foto
                    
                    SimpleDateFormat sdf = new SimpleDateFormat("ddMyyyyhhmmss");//formato de fecha
                    
                    String fecha = sdf.format(new Date());//fecha del sistema
                    
                    //servira para visualizar en la web
                    nombre = fecha+new Random().nextLong()+item.getName();//guardando el nombre que tendra la imagen concatenado con un numero aleatorio
                    
                    String nuevoNombre = ruta+nombre;//este nombre se almacenara en la bd
                                        
                    
                    //-------------------------escribir ese archivo en la memoria
                    //guardando la ruta del objeto
                    File folder = new File(ruta);
                    //si no existe una ruta o carpetas con ese nombre
                    if(!folder.exists()){
                        folder.mkdirs();//crear las carpetas
                    }
                    //guardar la imagen en el servidor
                    File imagen = new File(nuevoNombre);
                    
                    //verificar si es un archivo de imagen
                    if(item.getContentType().contains("image")){
                        //escribirlo en el servidor
                        item.write(imagen);
                        
                        request.setAttribute(item.getFieldName(), nombre);//capturando el nombre de la imagen 
                        
                    }
                }else{// si es un campo normal de formulario
                     request.setAttribute(item.getFieldName(), item.getString());
                }
            }
            
        } catch (FileUploadException ex) {
            request.setAttribute("subida", false);
        } catch (Exception ex) {
            request.setAttribute("subida", false);
        }
        
       
    }
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        recibirDatos(request);
        
        String url = request.getAttribute("imagen").toString();
        
        //recibiendo la informacion para registrar el producto
        String nombre = request.getAttribute("txtnombre").toString();
        float precio = Float.parseFloat(request.getAttribute("txtprecio").toString());
        float precioNuevo = Float.parseFloat(request.getAttribute("txtprecioPromo").toString());
        float precioCop = Float.parseFloat(request.getAttribute("txtprecioCOP").toString());
        float precioNuevoCop = Float.parseFloat(request.getAttribute("txtprecioPromoCOP").toString());
        float precioUsd = Float.parseFloat(request.getAttribute("txtprecioUSD").toString());
        float precioNuevoUsd = Float.parseFloat(request.getAttribute("txtprecioPromoUSD").toString());
        float precioPen = Float.parseFloat(request.getAttribute("txtprecioPEN").toString());
        float precioNuevoPen = Float.parseFloat(request.getAttribute("txtprecioPromoPEN").toString());
        int cantidad = Integer.parseInt(request.getAttribute("txtcantidad").toString());
        int marca = Integer.parseInt(request.getAttribute("marca").toString());
        int categoria = Integer.parseInt(request.getAttribute("categoria").toString());
        String descripcion = request.getAttribute("txtdescripcion").toString();
        boolean nuevo, recomendado, estado;
        try{
            nuevo = request.getAttribute("chknuevo").toString().equalsIgnoreCase("on");
        }catch(Exception e){
            nuevo = false;
            System.out.println(e.getMessage());
        }
        try{
            recomendado = request.getAttribute("chkrecomendado").toString().equalsIgnoreCase("on");
        }catch(Exception e){
            recomendado = false;
        }
        try{
            estado = request.getAttribute("chkestado").toString().equalsIgnoreCase("on");
        }catch(Exception e){
            estado = false;
        }
        String accion = request.getAttribute("accion").toString();
        
        Producto pro = new Producto();
        pro.setNombre(nombre);
        pro.setPrecio(precio);
        pro.setPrecio_nuevo(precioNuevo);
        pro.setStock(cantidad);
        pro.setNuevo(nuevo);
        pro.setRecomendado(recomendado);
        pro.setDescripcion(descripcion);
        pro.setEstado(estado);
        pro.setCodigo_marca(marca);
        pro.setCodigo_categoria(categoria);
        pro.setImagen(url);
        
        
        ProductoMoneda cop = new ProductoMoneda();
        cop.setMoneda("COP");
        cop.setPrecio(precioCop);
        cop.setPrecio_nuevo(precioNuevoCop);
        
        ProductoMoneda pmonedaUsd = new ProductoMoneda();
        pmonedaUsd.setMoneda("USD");
        pmonedaUsd.setPrecio(precioUsd);
        pmonedaUsd.setPrecio_nuevo(precioNuevoUsd);
        
        ProductoMoneda pmonedaPen = new ProductoMoneda();
        pmonedaPen.setMoneda("PEN");
        pmonedaPen.setPrecio(precioPen);
        pmonedaPen.setPrecio_nuevo(precioNuevoPen);
        
        if(accion.equalsIgnoreCase("registrar")){
            if(ProductoCad.registrarProducto(pro, cop, pmonedaUsd, pmonedaPen)){
                request.setAttribute("mensaje", "<p style='color:green'>Producto Registrado</p>");
                
            }else{
                request.setAttribute("mensaje", "<p style='color:red'>Producto NO Registrado</p>");
            }
        }else{
            request.setAttribute("mensaje", "<p style='color:red'>Acción desconocida</p>");
        }
        request.getRequestDispatcher("admin").forward(request, response);
        
        
        //response.sendRedirect("foto/"+url);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
