<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Cadastro de Cartão</title>
	<link rel="stylesheet" type='text/css' href="./css/style.css">
</head>
<body>
	<%@page import="dao.*, dominio.*, controle.*"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
	<jsp:setProperty property="*" name="cli" />
	
	<%
		BandeiraCartaoDAO bandeiraDAO = new BandeiraCartaoDAO();	
		List<BandeiraCartao> listaBandeiras = bandeiraDAO.consultar();				
		request.setAttribute("listaBandeiras", listaBandeiras);
		
	%>
		
	<div class="container">
		<div class="form_box">
			<h1 class="title">Cadastro de Cartão</h1>
			<form class="form" action="addcartao.jsp" method="post">
				<input type="hidden" name="idCliente" value="${cli.getId()}"/>						
				<div class="container-input">					
				    <label for="bandeira_cartao">Bandeira Cartão:</label>				    
				    <select name="bandeira" id="bandeira">
		                <c:forEach var="band" items="${listaBandeiras}">
		                   <option value="<c:out value='${band.descricao}'/>">${band.descricao}</option>
		                </c:forEach>
            		</select>
				</div>				
				<div class="container-input">
				    <label for="numero">Número do cartão:</label>
				   <input type="text" name="numero" placeholder="Insira o Número do Cartão">
				</div>
				<div class="container-input">
					<label for="nomeTitular">Nome do Titular:</label> 
					<input type="text" name="nomeTitular" placeholder="Insira o Nome do Titular">
				</div>
				<div class="container-input">
					<label for="codSeguranca">CVV:</label>
					<input type="text" name="codSeguranca" placeholder="Insira o CVV">
				</div>
				<div class="container-input">
					<label for="preferencial">Salvar como preferencial?</label> 
					<input type="checkbox" name="preferencial" id="preferencialCheckbox">
				</div>
				<div class="buttons-container">			   
			        <a href="addcartao.jsp?id=${cli.getId()}" class="botao-proximo-link">
			            <button type="submit">Salvar Cartão</button>
			        </a>
				</div>
				<div class="buttons-container">
					<a href="viewCartoes.jsp?id=${cli.getId()}" class="ver-cartoes">Voltar</a>					
				</div>								
			</form>
		</div>
	</div>
</body>
</html>