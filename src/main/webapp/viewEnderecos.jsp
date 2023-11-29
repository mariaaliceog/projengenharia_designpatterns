<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visualização de Enderecos</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>    
    <%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <jsp:useBean id="end" class="dominio.Endereco"></jsp:useBean>
	<jsp:setProperty property="*" name="end" />

    <%       
    	String clienteId = request.getParameter("id");
    	
    	ClienteController enderecoController = new ClienteController(); 
    	
    	Endereco endereco = new Endereco();
    	endereco.setIdCliente(Integer.parseInt(clienteId));
    	    	
   	    if (end instanceof EntidadeDominio) {
   	        EntidadeDominio entidade = (EntidadeDominio) end;
   	        try {
   	        	List<EntidadeDominio> listaEnderecos = enderecoController.consultar(endereco);
                request.setAttribute("endereco", endereco);
   	        	request.setAttribute("listaEnderecos", listaEnderecos);
   	        	request.setAttribute("clienteId", clienteId);
   	        } catch (Exception e) {
   	            out.println("Erro ao processar: " + e.getMessage());
   	            e.printStackTrace();
   	        }
   	    }  	    
   	    
    %>
    
    <div class="container">
    <h1>Enderecos cadastrados</h1>
    <input type="hidden" name="idCliente" value="${endereco.getIdCliente()}"/>	
    <a href="enderecoform.jsp?id=${endereco.getIdCliente()}" class="botao-proximo-link">
		<button type="button">Adicionar Endereco</button>
	</a>
    <br> 
    <table border="1">
        <tr>
        	<th>ID</th>
        	<th>Tipo Endereço</th> 
        	<th>Tipo Logradouro</th>
        	<th>Tipo Residência</th>        	      	
            <th>CEP</th>
            <th>Logradouro</th>
            <th>Número</th>
            <th>Bairro</th>
            <th>Editar</th>   
            <th>Excluir</th>
        </tr>
        <c:forEach items="${listaEnderecos}" var="endereco">           
            <tr>
                <td>${endereco.getId()}</td> 
                <td>${endereco.getTipoEndereco().getDescricao()}</td>
                <td>${endereco.getTipoLogradouro().getDescricao()}</td>
                <td>${endereco.getTipoResidencia().getDescricao()}</td>                                        
                <td>${endereco.getCep()}</td>
                <td>${endereco.getLogradouro()}</td>
                <td>${endereco.getNumero()}</td>
                <td>${endereco.getBairro()}</td>   
                <td><a href="editenderecoform.jsp?id=${endereco.getId()}" class="editar-endereco">Editar</a></td>             
                <td><a href="deleteendereco.jsp?id=${endereco.getId()}&clienteId=${clienteId}" class="excluir-endereco" style="color: red">Excluir</a></td>
            </tr>
        </c:forEach>                            
    </table>			
			<button class="botao-voltar" type="button" onclick="window.location.href='viewClientes.jsp'" style='margin-top:10px'>Voltar</button>
    </div>
</body>
</html>