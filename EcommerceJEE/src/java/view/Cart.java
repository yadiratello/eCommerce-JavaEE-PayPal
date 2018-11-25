
package view;

import ClaseAccesoDatos.ProductoCad;
import beans.Item;
import beans.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Cart extends HttpServlet {

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
        
        if(request.getParameter("action")!=null){
            
            String a = request.getParameter("action");
            int webid = 0;
            Producto p;
            HttpSession session = request.getSession();
            
            if(a.equals("order")){
                
                webid = Integer.parseInt(request.getParameter("id"));
                
                if(session.getAttribute("cart")==null){
                    ArrayList<Item> cart = new ArrayList<>();
                    p=ProductoCad.consultarProducto(session.getAttribute("moneda").toString(), webid);
                    cart.add(new Item(p, 1));
                    session.setAttribute("cart", cart);
                }else{
                    ArrayList<Item> cart = (ArrayList<Item>) session.getAttribute("cart");
                   
                    int indice = siExisteProducto(webid, cart);
                    
                    if(indice==-1){
                        p=ProductoCad.consultarProducto(session.getAttribute("moneda").toString(), webid);
                        cart.add(new Item(p, 1));
                    }else{
                        int cantidad = cart.get(indice).getCantidad()+1;
                        cart.get(indice).setCantidad(cantidad);
                    }                    
                    
                    session.setAttribute("cart", cart);
                }
            }else if(a.equals("delete")){
                
                webid = Integer.parseInt(request.getParameter("id"));
                
                ArrayList<Item> cart =(ArrayList<Item>) session.getAttribute("cart");
                
                int indice = siExisteProducto(webid, cart);
                
                cart.remove(indice);
                
                session.setAttribute("cart", cart);
                
            }else if(a.equals("finish")){
                ArrayList<Item> cart =(ArrayList<Item>) session.getAttribute("cart");
                
                int indice = siExisteProducto(webid, cart);
                
                cart.clear();
                
                session.setAttribute("cart", cart);
                
                request.getRequestDispatcher("Inicio").forward(request, response);    
            }
        }
        request.getRequestDispatcher("WEB-INF/cart.jsp").forward(request, response);    
    }

    
    
    
    private int siExisteProducto(int webid, ArrayList<Item> cart){
        for (int i = 0; i < cart.size(); i++) {//retorna el indice del array cart
            if(cart.get(i).getPro().getWebid()==webid){//si el webid del array es = al ingresado
                return i;//retorna la posicion del webid
            }
        }
        return -1;//no se encontro
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
        processRequest(request, response);
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
        processRequest(request, response);
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
