
<%@page import="beans.Producto"%>
<%@page import="ClaseAccesoDatos.ProductoCad"%>
<%@page import="ClaseAccesoDatos.CategoriaCad"%>
<%@page import="beans.Categoria"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Inicio |  Crea e-Commerce JAVA EE con pagos Online Paypal y Payu</title>
        <!--incluyendo los links css-->
        <%@include file="css.jsp" %>
        <!-- importando un archivo js para poder ejecutar unas acciones pararealizar el pago por paypal-->
        <script src="https://www.paypalobjects.com/api/checkout.js"></script>
    </head><!--/head-->

    <body>
        <!--incluyendo el header-->
        <%@include file="header.jsp" %>


        <section id="cart_items">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li><a href="#">Carrito</a></li>
                        <li class="active">Lista de productos</li>
                    </ol>
                </div>
                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu">
                                <td class="image">Producto</td>
                                <td class="description"></td>
                                <td class="price">Precio</td>
                                <td class="quantity">Cantidad</td>
                                <td class="total">Total</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody>
                            
                            <c:forEach items="${sessionScope.cart}" var="prod">
                              
                                <c:set var="total" value="${total+prod.pro.precio*prod.cantidad}"/>
                                
                                <tr>
                                    <td class="cart_product">
                                        <a href=""><img src="foto/${prod.pro.imagen}" width="110" alt=""></a>
                                    </td>
                                    <td class="cart_description">
                                        <h4><a href="">${prod.pro.nombre}</a></h4>
                                        <p>${prod.pro.webid}</p>
                                    </td>
                                    <td class="cart_price">
                                        <p>${prod.pro.precio}</p>
                                    </td>
                                    <td class="cart_quantity">
                                        <div class="cart_quantity_button">
                                            <a class="cart_quantity_up" href=""> + </a>
                                            <input class="cart_quantity_input" type="text" name="quantity" value="${prod.cantidad}" autocomplete="off" size="2">
                                            <a class="cart_quantity_down" href=""> - </a>
                                        </div>
                                    </td>
                                    <td class="cart_total">
                                        <p id="precio_1" class="cart_total_price">
                                            <fmt:setLocale value="en_US"/>
                                            <fmt:formatNumber value="${prod.pro.precio*prod.cantidad}" type="currency" />
                                        </p>
                                    </td>
                                    <td class="cart_delete">
                                        <a class="cart_quantity_delete" href="?action=delete&id=${prod.pro.webid}"><i class="fa fa-times"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section> <!--/#cart_items-->

        <section id="do_action">
            <div class="container">
                <div class="heading">
                    <h3>¿Qué te gustaría hacer ahora?</h3>
                    <p>Te gustaría pagar o seguir comprando?</p>
                </div>
                <div class="row">

                    <div class="col-sm-10">
                        <div class="total_area">
                            <ul>
                                <li>Sub Total <span>${total}</span></li>
                                <li>Tax/IVA(19%) <span>${total*0.19}</span></li>
                                <li><h3>Total <span>${total*1.19}</span></h3></li>
                            </ul>
                            <a class="btn btn-default update" href="Inicio">Seguir comprando</a>
                            <a class="btn btn-default check_out" href="Checkout">Realizar pago</a>
                            
                            
                            <%@include file="../WEB-INF/checkout.jsp" %>
                            
                        </div>
                    </div>
                </div>
            </div>
        </section><!--/#do_action-->

        <!--incluyendo footer-->
        <%@include file="footer.jsp" %>


        <!--incluyendo jquerys-->
        <%@include file="js.jsp" %>
    </body>
</html>