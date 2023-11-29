<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang = "pt-br">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Editar Cliente</title>	
	<link rel="stylesheet" href="./css/style.css">
</head>
<body>	

	<%@page import="dao.*, dominio.*, controle.*"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
	<jsp:setProperty property="*" name="cli" />
	
	<%
		TipoTelefoneDAO tipoTelefoneDAO = new TipoTelefoneDAO();
		List<TipoTelefone> listaTiposTel = tipoTelefoneDAO.consultar();
		request.setAttribute("listaTiposTel", listaTiposTel);
			
        ClienteController clienteController = new ClienteController();
    	if (cli instanceof EntidadeDominio){
        	EntidadeDominio entidade = (EntidadeDominio) cli;    
	        EntidadeDominio cliente = clienteController.selecionar(entidade);    
	        request.setAttribute("cliente", cliente);         
    	}    	
    		    	    	
    %>
	
	<div class="container">
		<div class="form_box">
		<h1 class="title">Edição de Cliente</h1>
		<h2 class="title2">Dados pessoais</h2>		
		<form class="form" action="editcliente.jsp" method="post">
			<input type="hidden" name="id" value="${cli.getId()}"/>		
			<input type="checkbox" name="status" ${cliente.getStatus() ? "checked" : ""}/> Ativo			
				<div class="container-input">				
						<label for="nome">Nome:</label>
						<input type="text" name="nome" placeholder="Insira o Nome" value="${cliente.getNome()}"/>
				</div>
				<div class="container-input">
					<label for="cpf">Cpf:</label>
					<input type="text" name="cpf" placeholder="Insira o CPF" value="${cliente.getCpf()}"/>
				</div>
				<div class="container-input">
					<label for="email">Email:</label>
					<input type="email" name="email" placeholder="Insira o E-mail" value="${cliente.getEmail()}"/>
				</div>
				<div class="container-input">
				    <label for="genero">Genero: </label>	
				    <div>		
				    	<div class="radio-options">		
					    	<input type="radio" name="genero" value="FEMININO" ${cliente.getGenero() == Genero.FEMININO ? "checked" : ""}/>Feminino    
						</div>
						<div class="radio-options">	
							<input type="radio" name="genero" value="MASCULINO" ${cliente.getGenero() == Genero.MASCULINO ? "checked" : ""}/>Masculino
						</div>
						<div class="radio-options">	
							<input type="radio" name="genero" value="OUTRO" ${cliente.getGenero() == Genero.OUTRO ? "checked" : ""}/>Outro					
						</div>
					</div>
				</div>	
				<div class="container-input">
					<label for="dataNascimento">Data de Nascimento:</label>
					<input type="date" name="dataNascimento" placeholder="Insira a Data de Nascimento" value="${cliente.getDataNascimento()}"/>
				</div>
				<h3 class="title3">Telefone</h3>
				<div class="container-input">					
				    <label for="telefone">Tipo Telefone:</label>
				    <select name="tipo">
					    <c:forEach var="tipoTel" items="${listaTiposTel}">
					        <option value="${tipoTel.nome}" ${tipoTel.nome == cliente.getTelefone().getTipo() ? 'selected="selected"' : ''}>${tipoTel.nome}</option>
					    </c:forEach>
					</select>				    
				</div>
				<div class="container-input">
					<label for="ddd">DDD: </label>
					<input type="text" name="ddd" placeholder="Insira o DDD" value="${cliente.getTelefone().getDdd()}"/>
				</div>
				<div class="container-input">
					<label for="numero">Número Telefone:</label>
					<input type="text" name="numero" placeholder="Insira o Número" value="${cliente.getTelefone().getNumero()}"/>
				</div>		
				<div class="buttons-container">											
				    <button type="submit">Editar Cliente</button>									
			        <button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'">Voltar</button>				
				</div>	
				<div class="buttons-container">
				<a href="editsenhaform.jsp?id=${cliente.getId()}" class="alterar-senha-link">
					<button type="button">Alterar Senha</button>
				</a>	
				</div>	
		</form>
		</div>
	</div>
</body>
</html>