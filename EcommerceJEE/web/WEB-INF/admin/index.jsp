
<%@page import="ClaseAccesoDatos.MarcaCad"%>
<%@page import="beans.Marca"%>
<%@page import="ClaseAccesoDatos.CategoriaCad"%>
<%@page import="beans.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Gestión de Productos |  Crea e-Commerce JAVA EE con pagos Online Paypal y Payu</title>
        <!--incluyendo los links css-->
        <%@include file="../css.jsp" %>
    </head><!--/head-->

    <body>
        <!--incluyendo el header-->
        <%@include file="../header.jsp" %>



        <section>
            <div class="container">
                <div class="row">
                    
                    <div class="col-sm-10 ">
                        
                        <h3>Gestionar Producto</h3>
                        <form action="ControlProducto" enctype="multipart/form-data" method="post">
                            <div class="form-one">
                                ${mensaje}
                                Nombre:<br><input class="input-sm" type="text" name="txtnombre" placeholder="Nombre Producto" required/><br><br>
                                Precio (MXN):<br><input class="input-sm" type="number" name="txtprecio" placeholder="Precio Inicial" value="0" min="0"/><br>
                                Precio Promo (MXN):<br><input type="number" name="txtprecioPromo" placeholder="Precio Nuevo" value="0" min="0"/><br><hr>
                                
                                Precio (COP):<br><input class="input-sm" type="number" name="txtprecioCOP" placeholder="Precio Inicial" value="0" min="0"/><br>
                                Precio Promo (COP):<br><input type="number" name="txtprecioPromoCOP" placeholder="Precio Nuevo" value="0" min="0"/><br><hr>
                                
                                Precio (USD):<br><input class="input-sm" type="number" name="txtprecioUSD" placeholder="Precio Inicial" value="0" min="0"/><br>
                                Precio Promo (USD):<br><input type="number" name="txtprecioPromoUSD" placeholder="Precio Nuevo" value="0" min="0"/><br><hr>
                                
                                Precio (PEN):<br><input class="input-sm" type="number" name="txtprecioPEN" placeholder="Precio Inicial" value="0" min="0"/><br>
                                Precio Promo (PEN):<br><input type="number" name="txtprecioPromoPEN" placeholder="Precio Nuevo" value="0" min="0"/><br><hr>
                                
                                Stock:<br><input type="number" name="txtcantidad" placeholder="Cantidad" value="1" min="1"/><br>
                                Marca:<br>
                                <select name="marca">
                                    <option>Seleccionar...</option>
                                    <% for (Marca marca: MarcaCad.listarTodasMarcas()) { %>
                                        
                                    <option value="<%= marca.getCodigo() %>"><%= marca.getNombre()%></option>
                                    
                                    <% } %>
                                </select><br>
                                Categoria:<br>
                                <select name="categoria">
                                    <option>Seleccionar...</option>
                                    <% for (Categoria cat: CategoriaCad.listarTodasCategorias()) { %>
                                        
                                    <option value="<%= cat.getCodigo() %>"><%= cat.getNombre()%></option>
                                    
                                    <% } %>
                                </select><br>
                                Descripción:<br><textarea name="txtdescripcion" rows="4" cols="20"></textarea><br><br>
                                Nuevo?: <input type="checkbox" name="chknuevo" value="ON" checked="checked"/>
                                Recomendado?: <input type="checkbox" name="chkrecomendado" value="ON"/>
                                Estado?: <input type="checkbox" name="chkestado" value="ON" checked="checked"/><br><br>
                                Imagen:<input type="file" name="imagen" value="seleccionar una imagen" required/><br><hr>
                                <input class="btn btn-success" name="accion" type="submit" value="registrar">
                                <input class="btn btn-default" name="accion"  type="submit" value="Consultar">
                                <input class="btn btn-warning" name="accion"  type="submit" value="Editar">
                                <input class="btn btn-danger" name="accion"  type="submit" value="Eliminar">
                            </div>
                        </form>
                        

                      
                    </div>
                </div>
            </div>
        </section>
                        
        <!--incluyendo footer-->
        <%@include file="../footer.jsp" %>
        

        <!--incluyendo jquerys-->
        <%@include file="../js.jsp" %>
    </body>
</html>
