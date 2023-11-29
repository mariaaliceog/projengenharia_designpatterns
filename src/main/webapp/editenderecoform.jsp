<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Edição de Endereço</title>
	<link rel="stylesheet" type='text/css' href="./css/style.css">
</head>
<body>
	<%@page import="dao.*, dominio.*, controle.*"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<jsp:useBean id="end" class="dominio.Endereco"></jsp:useBean>
	<jsp:setProperty property="*" name="end" />
	
	<% 		
		TipoEnderecoDAO tipoEnderecoDAO = new TipoEnderecoDAO();	
		TipoLogradouroDAO tipoLogradouroDAO = new TipoLogradouroDAO();
		TipoResidenciaDAO tipoResidenciaDAO = new TipoResidenciaDAO();
		PaisDAO paisDAO = new PaisDAO();
		EstadoDAO estadoDAO = new EstadoDAO();
		CidadeDAO cidadeDAO = new CidadeDAO();
		
		List<TipoEndereco> listaTiposEnd = tipoEnderecoDAO.consultar();
		List<TipoLogradouro> listaTiposLog = tipoLogradouroDAO.consultar();
		List<TipoResidencia> listaTiposRes = tipoResidenciaDAO.consultar();
		List<Pais> listaPaises = paisDAO.consultar();
		List<Estado> listaEstados = estadoDAO.consultar();
		List<Cidade> listaCidades = cidadeDAO.consultar();		
							
		request.setAttribute("listaTiposEnd", listaTiposEnd);	
		request.setAttribute("listaTiposLog", listaTiposLog);
		request.setAttribute("listaTiposRes", listaTiposRes);
		request.setAttribute("listaPaises", listaPaises);
		request.setAttribute("listaEstados", listaEstados);
		request.setAttribute("listaCidades", listaCidades);	
		
	 	ClienteController enderecoController = new ClienteController();
    	if (end instanceof EntidadeDominio){
        	EntidadeDominio entidade = (EntidadeDominio) end;    
	        EntidadeDominio endereco = enderecoController.selecionar(entidade);    
	        request.setAttribute("endereco", endereco);
    	}    	
						
	%>
		
	<div class="container">
		<div class="form_box">
			<h1 class="title">Cadastro de Endereço</h1>
			<form class="form" action="editendereco.jsp" method="post">
				<input type="hidden" name="idCliente" value="${endereco.getIdCliente()}"/>							
				<div class="container-input">					
				    <label for="tipo_endereco">Tipo Endereço:</label>				    
				    <select name="tipoEndereco" id="tipoEndereco">
		                <c:forEach var="tipoEnd" items="${listaTiposEnd}">
		                   <option value="${tipoEnd.descricao}"${tipoEnd.descricao == cliente.getEndereco().getTipoEndereco() ? 'selected="selected"' : ''}>${tipoEnd.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_logradouro">Tipo Logradouro:</label>				    
				    <select name="tipoLogradouro" id="tipoLogradouro">
		                <c:forEach var="tipoLog" items="${listaTiposLog}">
		                   <option value="${tipoLog.descricao}"${tipoLog.descricao == cliente.getEndereco().getTipoLogradouro() ? 'selected="selected"' : ''}>${tipoLog.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_residencia">Tipo Residência:</label>				    
				    <select name="tipoResidencia" id="tipoResidencia">
		                <c:forEach var="tipoRes" items="${listaTiposRes}">
		                   <option value="${tipoRes.descricao}"${tipoRes.descricao == cliente.getEndereco().getTipoResidencia() ? 'selected="selected"' : ''}>${tipoRes.descricao}</option>
		                </c:forEach>
            		</select>
				</div>				
				<div class="container-input">					
				    <label for="pais">País:</label>			    
				        <select name="nomePais" id="nomePais">
				            <c:forEach var="pais" items="${listaPaises}">
				                <option value="<c:out value='${pais.getId()}'/>">${pais.getNome()}</option>
				            </c:forEach>
				        </select>			    
				</div>				
				<div class="container-input">					
				    <label for="estado">Estado:</label>	
				    <select name="nomeEstado" id="nomeEstado">
		                <c:forEach var="estado" items="${listaEstados}">
		                   <option value="<c:out value='${estado.getId()}'/>">${estado.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="cidade">Cidade:</label>				    
				   	<select name="nomeCidade" id="nomeCidade">
		                <c:forEach var="cid" items="${listaCidades}">
		                    <option value="<c:out value='${cid.getNome()}'/>">${cid.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">
				    <label for="cep">CEP:</label>
				   <input type="text" name="cep" placeholder="Insira o CEP" value="${endereco.getCep()}">
				</div>
				<div class="container-input">
					<label for="logradouro">Logradouro:</label> 
					<input type="text" name="logradouro" placeholder="Insira o Logradouro" value="${endereco.getLogradouro()}">
				</div>
				<div class="container-input">
					<label for="numero">Número:</label>
					<input type="text" name="numero" placeholder="Insira o numero" value="${endereco.getNumero()}">
				</div>
				<div class="container-input">
					<label for="bairro">Bairro:</label> 
					<input type="text" name="bairro" placeholder="Insira o bairro" value="${endereco.getBairro()}">
				</div>
				<div class="container-input">
					<label for="observacao">Observação:</label>
					<input type="text" name="observacao" placeholder="Insira uma Observação" value="${endereco.getObservacao()}"/>
				</div>
				<div class="buttons-container">		
				 	<a href="viewEnderecos.jsp?id=${endereco.getIdCliente()}" class="botao-voltar">
			            <button type="button">Voltar</button>
			        </a>	   								
			        <a href="viewEnderecos.jsp?id=${endereco.getId()}&idCliente=${endereco.getIdCliente()}" class="botao-proximo-link">
			            <button type="submit">Salvar Endereco</button>
			        </a>									
				</div>								
			</form>
		</div>
	</div>
	</body>
</html>