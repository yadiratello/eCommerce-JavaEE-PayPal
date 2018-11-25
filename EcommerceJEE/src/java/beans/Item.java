
package beans;


public class Item {
    private Producto pro;
    private int cantidad;

    public Item(Producto pro, int cantidad) {
        this.pro = pro;
        this.cantidad = cantidad;
    }

    public Producto getPro() {
        return pro;
    }

    public void setPro(Producto pro) {
        this.pro = pro;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    
}
