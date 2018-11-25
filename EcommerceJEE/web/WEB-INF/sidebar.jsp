
<%@page import="ClaseAccesoDatos.MarcaCad"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="left-sidebar">
    <h2>Categorías</h2>
    <!------------------------------ CATEGORIAS -------------------------------->
    <div class="panel-group category-products" id="accordian"><!--category-productsr-->

        <%!
            ArrayList<Categoria> lista = CategoriaCad.listarCategoria();
            //codigo de la categoria superior    
            int codigo = 0;
        %>

        <% for (int i = 0; i < lista.size(); i++) {

                codigo = lista.get(i).getCodigo();
        %>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h4 class="panel-title">
                    <a <% if (CategoriaCad.cantidadCategorias(codigo)) {%> data-toggle="collapse" data-parent="#accordian"  <% }%>  href="#<%= codigo%>">
                        <% if (CategoriaCad.cantidadCategorias(codigo)) {%><span class="badge pull-right"><i class="fa fa-plus"></i></span><% }%>
                        <a href="?category=<%=codigo%>"><%= lista.get(i).getNombre()%></a>
                    </a>
                </h4>
            </div>
            <div id="<%= codigo%>" class="panel-collapse collapse">
                <div class="panel-body">
                    <ul>
                        <% ArrayList<Categoria> listaSubCat = CategoriaCad.listarSubCategoria(codigo); %>
                        <% for (int j = 0; j < listaSubCat.size(); j++) {
                                codigo = listaSubCat.get(j).getCodigo();
                        %>
                        <li><a href="?category=<%=codigo%>"><%= listaSubCat.get(j).getNombre()%> </a></li>
                            <% } %>
                    </ul>
                </div>
            </div>
        </div>
        <% }%>
    </div><!--/category-products-->




    <div class="brands_products"><!--brands_products-->
        <h2>Marcas</h2>
        <div class="brands-name">
            <ul class="nav nav-pills nav-stacked">
                <c:forEach var="m" items="<%= MarcaCad.listarTodasMarcas() %>">
                    
                    <c:set var="cod" value="${m.codigo}"></c:set>
                    
                    <% int cod = Integer.parseInt(pageContext.getAttribute("cod").toString()); %>
                    
                    <li><a href="?brand=${m.codigo}"> <span class="pull-right">(<%= MarcaCad.contarMarcas(cod) %>)</span>${m.nombre}</a></li>
                </c:forEach>
            </ul>
        </div>
    </div><!--/brands_products-->

    <div class="shipping text-center"><!--shipping-->
        <img src="images/home/shipping.jpg" alt="" />
    </div><!--/shipping-->

</div>