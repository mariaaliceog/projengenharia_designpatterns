<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visualização de Cartões</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>    
    <%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <jsp:useBean id="cart" class="dominio.Cartao"></jsp:useBean>
	<jsp:setProperty property="*" name="cart" />

    <%
    	String clienteId = request.getParameter("id"); 
    	
    	ClienteController cartaoController = new ClienteController(); 
    	
    	Cartao cartao = new Cartao();
    	cartao.setIdCliente(Integer.parseInt(clienteId));
    	
   	    if (cart instanceof EntidadeDominio) {
   	        EntidadeDominio entidade = (EntidadeDominio) cart;
   	        try {
   	        	List<EntidadeDominio> listaCartoes = cartaoController.consultar(cartao);    
   	        	request.setAttribute("cartao", cartao);
   	        	request.setAttribute("listaCartoes", listaCartoes);
   	        	request.setAttribute("clienteId", clienteId);
   	        } catch (Exception e) {
   	            out.println("Erro ao processar: " + e.getMessage());
   	            e.printStackTrace();
   	        }
   	    }
    %>
    
    <div class="container">
    <h1>Cartões cadastrados</h1>
    <input type="hidden" name="idCliente" value="${cartao.getIdCliente()}"/>	
    <a href="cartaoform.jsp?id=${cartao.getIdCliente()}" class="botao-proximo-link">
		<button type="button">Adicionar Cartão</button>
	</a>
    <br> 
    <table border="1">
        <tr>
        	<th>ID</th>
           	<th>Bandeira Cartão</th>
            <th>Final do Cartão</th>
            <th>Nome do Titular</th>
            <th>CVV</th>
            <th>Preferencial</th>   
            <th>Excluir</th>
        </tr>
        <c:forEach items="${listaCartoes}" var="cartao">           
            <tr>
                <td>${cartao.getId()}</td>
                <td>${cartao.getBandeira().getDescricao()}
                <td>${cartao.getNumero().substring(cartao.getNumero().length() - 4)}</td>
                <td>${cartao.getNomeTitular()}</td>
                <td>***</td>
                <td class="${cartao.isPreferencial() ? 'sim' : 'nao'}" style="${cartao.isPreferencial() ? 'color: green; font-weight: bold; font-size:15px;' : 'color: red; font-weight: bold;'}">
				    <c:choose>
				        <c:when test="${cartao.isPreferencial()}">
				            Sim
				        </c:when>
				        <c:otherwise>
				            Não
				        </c:otherwise>
				    </c:choose>
				</td>
                <td><a href="deletecartao.jsp?id=${cartao.getId()}&clienteId=${clienteId}" class="excluir-cartao">Excluir</a></td>
            </tr>
        </c:forEach>                            
    </table>			
			<button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'" style='margin-top:10px'>Voltar</button>
    </div>
</body>
</html>