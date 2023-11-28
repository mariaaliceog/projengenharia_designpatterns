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
	<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
	<jsp:setProperty property="*" name="cli" />
	
	<%
        ClienteController clienteController = new ClienteController();
    	if (cli instanceof EntidadeDominio){
        	EntidadeDominio entidade = (EntidadeDominio) cli;    
	        EntidadeDominio cliente = clienteController.selecionar(entidade);    
	        request.setAttribute("cliente", cliente);
    	}
    %>
	
	<div class="container">
	<h1>Edi��o de Cliente</h1>
	<form action="editcliente.jsp" method="post">
		<input type="hidden" name="id" value="${cliente.getId()}"/>		
		<input type="checkbox" name="status" ${cliente.getStatus() ? "checked" : ""}/> Ativo
		<table>			
			<tr>
				<td>Nome: </td>
				<td><input type="text" name="nome" placeholder="Insira o Nome" value="${cliente.getNome()}"/></td>
			</tr>
			<tr>
				<td>Cpf: </td>
				<td><input type="text" name="cpf" placeholder="Insira o CPF" value="${cliente.getCpf()}"/></td>
			</tr>
			<tr>
				<td>Email: </td>
				<td><input type="email" name="email" placeholder="Insira o E-mail" value="${cliente.getEmail()}"/></td>
			</tr>
			<tr>
			    <td>Genero: </td>
				<td>
				    <input type="radio" name="genero" value="FEMININO" ${cliente.getGenero() == Genero.FEMININO ? "checked" : ""}/>Feminino    
					<input type="radio" name="genero" value="MASCULINO" ${cliente.getGenero() == Genero.MASCULINO ? "checked" : ""}/>Masculino
					<input type="radio" name="genero" value="OUTRO" ${cliente.getGenero() == Genero.OUTRO ? "checked" : ""}/>Outro
				</td>
			</tr>
			<tr>
				<td>Data de Nascimento: </td>
				<td><input type="date" name="dataNascimento" placeholder="Insira a Data de Nascimento" value="${cliente.getDataNascimento()}"/></td>
			</tr>
			<%-- <tr>
				 <td><label for="tipoTelefone">Tipo Telefone: </label></td>
		    <td>
		        <label>
		            <input type="radio" id="celular" name="tipo_telefone" value="CELULAR" <%= (cliente != null && cliente.getTelefone() != null && cliente.getTelefone().getTipo() == TipoTelefone.CELULAR) ? "checked" : "" %>/>Celular
				</label>
		        <label>
		            <input type="radio" id="celular" name="tipo_telefone" value="CELULAR" <%= (cliente != null && cliente.getTelefone() != null && cliente.getTelefone().getTipo() == TipoTelefone.RESIDENCIAL) ? "checked" : "" %>/>Residencial
		        </label>
		        <label>
		            <input type="radio" id="celular" name="tipo_telefone" value="CELULAR" <%= (cliente != null && cliente.getTelefone() != null && cliente.getTelefone().getTipo() == TipoTelefone.COMERCIAL) ? "checked" : "" %>/>Comercial
		        </label>
		        <label>
		            <input type="radio" id="celular" name="tipo_telefone" value="CELULAR" <%= (cliente != null && cliente.getTelefone() != null && cliente.getTelefone().getTipo() == TipoTelefone.OUTRO) ? "checked" : "" %>/>Outro
		        </label>
		    </td>				
			</tr>			
			<tr>
				<td><label for="ddd">DDD: </label></td>
				<td><input type="text" name="ddd" placeholder="Insira o DDD" value="<%=(cliente != null && cliente.getTelefone() != null) ? cliente.getTelefone().getDdd() : ""%>"/></td>
			</tr>
			<tr>
				<td><label for="numero_tel">N�mero Telefone:</label></td>
				<td><input type="text" name="numero_telefone" placeholder="Insira o N�mero" value="<%=(cliente != null && cliente.getTelefone() != null) ? cliente.getTelefone().getNumero(): ""%>"/></td>
			</tr> --%>		
			<tr>				
				<td colspan="2">
				    <a href="editsenhaform.jsp?id=${cliente.getId()}" class="alterar-senha-link">Alterar Senha</a>
				</td>		    
			</tr>
			<tr>
				<td colspan="2">
			      <button type="submit">Editar Cliente</button>
			   </td>
			</tr>
			<tr>
				<td colspan="2">					
		        	<button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'">Voltar</button>
		    	</td>
			</tr>
		</table>
	</form>
	</div>
</body>
</html>