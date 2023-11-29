<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang = "pt-br">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
		
	<title>Cadastro</title>	
	<link rel="stylesheet" href="./css/style.css">
</head>
<body>

	<%@page import="dao.*, dominio.*, controle.*"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
	<jsp:setProperty property="*" name="cli" />
	
	<% 
		TipoEnderecoDAO tipoEnderecoDAO = new TipoEnderecoDAO();	
		TipoLogradouroDAO tipoLogradouroDAO = new TipoLogradouroDAO();
		TipoResidenciaDAO tipoResidenciaDAO = new TipoResidenciaDAO();
		TipoTelefoneDAO tipoTelefoneDAO = new TipoTelefoneDAO();
		
		PaisDAO paisDAO = new PaisDAO();
		EstadoDAO estadoDAO = new EstadoDAO();
		CidadeDAO cidadeDAO = new CidadeDAO();
		
		List<TipoEndereco> listaTiposEnd = tipoEnderecoDAO.consultar();
		List<TipoLogradouro> listaTiposLog = tipoLogradouroDAO.consultar();
		List<TipoResidencia> listaTiposRes = tipoResidenciaDAO.consultar();
		List<TipoTelefone> listaTiposTel = tipoTelefoneDAO.consultar();
		List<Pais> listaPaises = paisDAO.consultar();
		List<Estado> listaEstados = estadoDAO.consultar();
		List<Cidade> listaCidades = cidadeDAO.consultar();		
							
		request.setAttribute("listaTiposEnd", listaTiposEnd);	
		request.setAttribute("listaTiposLog", listaTiposLog);
		request.setAttribute("listaTiposRes", listaTiposRes);
		request.setAttribute("listaTiposTel", listaTiposTel);	
		request.setAttribute("listaPaises", listaPaises);
		request.setAttribute("listaEstados", listaEstados);
		request.setAttribute("listaCidades", listaCidades);			
	%>
	
	<div class="container">
		<div class="form_box">
			<h1 class="title">Cadastro de Cliente</h1>
			<h2 class="title2">Dados pessoais</h2>
			<form class="form" action="addcliente.jsp" method="post">
			<input type="hidden" name="idCliente" value="${cli.getId()}"/>	
				<div class="container-input">
					<label for="nome">Nome:*</label>
					<input type="text" name="nome" placeholder="Insira o nome" required />
				</div>
				<div class="container-input">
					<label for="cpf">CPF:*</label>
					<input type="text" name="cpf" placeholder="Insira o CPF" required />
				</div>
				<div class="container-input">
					<label for="email">E-mail:*</label>
					<input type="email" name="email" placeholder="Insira o E-mail" required />
				</div>
				<div class="container-input">
					<label for="password">Senha:*</label>
					<input type="password" name="senha" placeholder="Insira a Senha" required />
				</div>
				<div class="container-input">
					<label for="password">Confirmar Senha:*</label>
					<input type="password" name="confirmarSenha" placeholder="Confirme a Senha" required />
				</div>
				<div class="container-input">
					<label for="genero">Gênero:*</label>
					<div>
						<div class="radio-options">					
							<input type="radio" id="feminino" name="genero" value="FEMININO">
							<label for="feminino">Feminino</label>
						</div>
						<div class="radio-options">
							<input type="radio" id="masculino" name="genero" value="MASCULINO">
							<label for="masculino">Masculino</label>
						</div>
						<div class="radio-options">
							<input type="radio" id="outro" name="genero" value="OUTRO">
							<label for="outro">Outro</label>				
						</div>
					</div>
				</div>
				<div class="container-input">
					<label for="dataNascimento">Data Nascimento:*</label>
					<input type="date" name="dataNascimento" required />
				</div>
				
				<h3 class="title3">Telefone</h3>
				<div class="container-input">					
				    <label for="telefone">Tipo Telefone:*</label>			    
				        <select name="tipo" id="tipo">
				            <c:forEach var="tipoTel" items="${listaTiposTel}">
				                <option value="<c:out value='${tipoTel.nome}'/>">${tipoTel.nome}</option>
				            </c:forEach>
				        </select>			    
				</div>
				
				<div class="container-input">
					<label for="ddd">DDD:* </label>
					<input type="text" name="ddd" placeholder="Insira o DDD" required />
				</div>
				<div class="container-input">
					<label for="numero">Número Telefone:*</label>
					<input type="text" name="numero" placeholder="Insira o Número de Telefone" required />
				</div>
				
				<h2 class="title2">Endereço</h2>
				<h3 class="title3">Endereço Residencial</h3>
				<div class="container-input">					
				    <label for="pais">País:*</label>			    
				        <select name="nomePaisRes" id="nomePaisRes">
				            <c:forEach var="pais" items="${listaPaises}">
				                <option value="<c:out value='${pais.getId()}'/>">${pais.getNome()}</option>
				            </c:forEach>
				        </select>			    
				</div>				
				<div class="container-input">					
				    <label for="estado">Estado:*</label>	
				    <select name="nomeEstadoRes" id="nomeEstadoRes">
		                <c:forEach var="estado" items="${listaEstados}">
		                   <option value="<c:out value='${estado.getId()}'/>">${estado.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="cidade">Cidade:*</label>				    
				   	<select name="nomeCidadeRes" id="nomeCidadeRes">
		                <c:forEach var="cid" items="${listaCidades}">
		                    <option value="<c:out value='${cid.getNome()}'/>">${cid.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_logradouro">Tipo Logradouro:*</label>				    
				    <select name="tipoLogradouroRes" id="tipoLogradouroRes">
		                <c:forEach var="tipoLog" items="${listaTiposLog}">
		                   <option value="<c:out value='${tipoLog.descricao}'/>">${tipoLog.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_residencia">Tipo Residência:*</label>				    
				    <select name="tipoResidenciaRes" id="tipoResidenciaRes">
		                <c:forEach var="tipoRes" items="${listaTiposRes}">
		                   <option value="<c:out value='${tipoRes.descricao}'/>">${tipoRes.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">
					<label for="cep">CEP:*</label>
					<input type="text" name="cepRes" placeholder="Insira o CEP" required />
				</div>
				<div class="container-input">
					<label for="logradouro">Logradouro:*</label>
					<input type="text" name="logradouroRes" placeholder="Insira o Logradouro" required />
				</div>
				<div class="container-input">
					<label for="numero">Numero:*</label>
					<input type="text" name="numeroRes" placeholder="Insira o Número" required />
				</div>
				<div class="container-input">
					<label for="bairro">Bairro:*</label>
					<input type="text" name="bairroRes" placeholder="Insira o Bairro" required />
				</div>
				<div class="container-input">
					<label for="observacao">Observação:</label>
					<input type="text" name="observacaoRes" placeholder="Insira uma Observação"/>
				</div>
				
				<h3 class="title3">Endereço Cobrança</h3>
				<div class="container-input">					
				    <label for="pais">País:*</label>			    
				        <select name="nomePaisCob" id="nomePaisCob">
				            <c:forEach var="pais" items="${listaPaises}">
				                <option value="<c:out value='${pais.getId()}'/>">${pais.getNome()}</option>
				            </c:forEach>
				        </select>			    
				</div>				
				<div class="container-input">					
				    <label for="estado">Estado:*</label>	
				    <select name="nomeEstadoCob" id="nomeEstadoCob">
		                <c:forEach var="estado" items="${listaEstados}">
		                   <option value="<c:out value='${estado.getId()}'/>">${estado.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="cidade">Cidade:*</label>				    
				   	<select name="nomeCidadeCob" id="nomeCidadeCob">
		                <c:forEach var="cid" items="${listaCidades}">
		                    <option value="<c:out value='${cid.getNome()}'/>">${cid.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_logradouro">Tipo Logradouro:*</label>				    
				    <select name="tipoLogradouroCob" id="tipoLogradouroCob">
		                <c:forEach var="tipoLog" items="${listaTiposLog}">
		                   <option value="<c:out value='${tipoLog.descricao}'/>">${tipoLog.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_residencia">Tipo Residência:*</label>				    
				    <select name="tipoResidenciaCob" id="tipoResidenciaCob">
		                <c:forEach var="tipoRes" items="${listaTiposRes}">
		                   <option value="<c:out value='${tipoRes.descricao}'/>">${tipoRes.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">
					<label for="cep">CEP:*</label>
					<input type="text" name="cepCob" placeholder="Insira o CEP" required />
				</div>
				<div class="container-input">
					<label for="logradouro">Logradouro:*</label>
					<input type="text" name="logradouroCob" placeholder="Insira o Logradouro" required />
				</div>
				<div class="container-input">
					<label for="numero">Numero:*</label>
					<input type="text" name="numeroCob" placeholder="Insira o Número" required />
				</div>
				<div class="container-input">
					<label for="bairro">Bairro:*</label>
					<input type="text" name="bairroCob" placeholder="Insira o Bairro" required />
				</div>
				<div class="container-input">
					<label for="observacao">Observação:</label>
					<input type="text" name="observacaoCob" placeholder="Insira uma Observação"/>
				</div>
				
				<h3 class="title3">Endereço Entrega</h3>
				<div class="container-input">					
				    <label for="pais">País:*</label>			    
				        <select name="nomePaisEnt" id="nomePaisEnt">
				            <c:forEach var="pais" items="${listaPaises}">
				                <option value="<c:out value='${pais.getId()}'/>">${pais.getNome()}</option>
				            </c:forEach>
				        </select>			    
				</div>				
				<div class="container-input">					
				    <label for="estado">Estado:*</label>	
				    <select name="nomeEstadoEnt" id="nomeEstadoEnt">
		                <c:forEach var="estado" items="${listaEstados}">
		                   <option value="<c:out value='${estado.getId()}'/>">${estado.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="cidade">Cidade:*</label>				    
				   	<select name="nomeCidadeEnt" id="nomeCidadeEnt">
		                <c:forEach var="cid" items="${listaCidades}">
		                    <option value="<c:out value='${cid.getNome()}'/>">${cid.getNome()}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_logradouro">Tipo Logradouro:*</label>				    
				    <select name="tipoLogradouroEnt" id="tipoLogradouroEnt">
		                <c:forEach var="tipoLog" items="${listaTiposLog}">
		                   <option value="<c:out value='${tipoLog.descricao}'/>">${tipoLog.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">					
				    <label for="tipo_residencia">Tipo Residência:*</label>				    
				    <select name="tipoResidenciaEnt" id="tipoResidenciaEnt">
		                <c:forEach var="tipoRes" items="${listaTiposRes}">
		                   <option value="<c:out value='${tipoRes.descricao}'/>">${tipoRes.descricao}</option>
		                </c:forEach>
            		</select>
				</div>
				<div class="container-input">
					<label for="cep">CEP:*</label>
					<input type="text" name="cepEnt" placeholder="Insira o CEP" required />
				</div>
				<div class="container-input">
					<label for="logradouro">Logradouro:*</label>
					<input type="text" name="logradouroEnt" placeholder="Insira o Logradouro" required />
				</div>
				<div class="container-input">
					<label for="numero">Numero:*</label>
					<input type="text" name="numeroEnt" placeholder="Insira o Número" required />
				</div>
				<div class="container-input">
					<label for="bairro">Bairro:*</label>
					<input type="text" name="bairroEnt" placeholder="Insira o Bairro" required />
				</div>
				<div class="container-input">
					<label for="observacao">Observação:</label>
					<input type="text" name="observacaoEnt" placeholder="Insira uma Observação"/>
				</div>				
				
				<div class="buttons-container">
					<button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'">Voltar</button>
					<a href="viewClientes.jsp" class="botao-proximo-link">
						<button type="submit">Cadastrar</button>
					</a>					
				</div>
			</form>
		</div>
	</div>
</body>