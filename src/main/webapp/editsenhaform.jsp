<!DOCTYPE html>
<html lang = "pt-br">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Edicao Cliente</title>	
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
	    <h1>Alterar Senha</h1>
	    <form action="editsenha.jsp" method="post">
	    	<input type="hidden" name="id" value="${cliente.getId()}"/>
	    	<table>
		    	<tr>
			    	<td><label for="senhaAtual">Senha Atual:</label></td>
			   		<td><input type="password" name="senhaAtual" required></td>
			    </tr>
				<tr>			    			    
				    <td><label for="novaSenha">Nova Senha:</label></td>
				    <td><input type="password" name="novaSenha" required></td>
			    </tr>
			    <tr>
				    <td><label for="confirmaSenha">Confirmar Nova Senha:</label></td>
				    <td><input type="password" name="confirmaSenha" required></td>
			    </tr>
			    <tr>	
			    	<td colspan="2">		    
			    		<button type="submit">Alterar Senha</button>
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
