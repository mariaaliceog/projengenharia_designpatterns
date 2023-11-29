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
		<div class="form_box">
	    <h1 class="title">Alterar Senha</h1>
	    <form class="form" action="editsenha.jsp" method="post">
	    	<input type="hidden" name="id" value="${cliente.getId()}"/>
	    		<div class="container-input">
			    	<label for="senhaAtual">Senha Atual:</label>
			   		<input type="password" name="senhaAtual" placeholder="Insira a senha atual" required>
			    </div>
			    <div class="container-input">			    			    
				    <label for="novaSenha">Nova Senha:</label>
				    <input type="password" name="novaSenha" placeholder="Insira a nova senha" required>
			    </div>
			    <div class="container-input">
				    <label for="confirmaSenha">Confirmar Nova Senha:</label>
				    <input type="password" name="confirmaSenha" placeholder="Confirme a nova senha" required>
			    </div>	
			    <div class="buttons-container">			    
		    		<button type="submit">Alterar Senha</button>
		    		<button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'">Voltar</button>
		    	</div>			
		</form>  
		</div>
	</div>
</body>
