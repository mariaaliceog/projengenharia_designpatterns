<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Visualização de Usuários</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>    
    <%@ page import="dao.*, dominio.*, java.util.*, controle.*, java.text.SimpleDateFormat" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
	<jsp:setProperty property="*" name="cli" />

    <%
        ClienteController cliente = new ClienteController();
    	if (cli instanceof EntidadeDominio){
        	EntidadeDominio entidade = (EntidadeDominio) cli;    
	        List<EntidadeDominio> listaClientes = cliente.consultar(entidade);    
	        request.setAttribute("listaClientes", listaClientes);
    	}
    %>
    
    <div class="container">
    <h1>Listagem de Clientes</h1>
    <br><br> 
    <a href="clienteform.jsp" class="botao-proximo-link">
		<button type="button">Adicionar Cliente</button>
	</a>					
    <br>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>CPF</th>
            <th>Email</th>
            <th>Genero</th>    
            <th>Dt. Nascimento</th>
            <th>Telefone</th>
            <th>Status</th>            
            <th>Cartões</th>
            <th>Endereços</th>
            <th>Editar</th>
            <th>Excluir</th>
        </tr>
        <c:forEach items="${listaClientes}" var="cliente">           
            <tr>
                <td>${cliente.getId()}</td>
                <td>${cliente.getNome()}</td>
                <td>${cliente.getCpf()}</td>
                <td>${cliente.getEmail()}</td>                
                <td>${cliente.getGenero().getDescricao()}</td>                            
                <td>
                    <fmt:parseDate var="parsedDate" value="${cliente.getDataNascimento()}" pattern="yyyy-MM-dd" />
                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                </td>
                <td>${cliente.getTelefone().getNumero()}</td>
                <td class="${cliente.getStatus() ? 'ativo' : 'inativo'}" style="${cliente.getStatus() ? 'color: green; font-weight: bold; font-size:15px;' : 'color: red; font-weight: bold;'}">
				    <c:choose>
				        <c:when test="${cliente.getStatus()}">
				            Ativo
				        </c:when>
				        <c:otherwise>
				            Inativo
				        </c:otherwise>
				    </c:choose>
				</td>			
				<td><a href="viewCartoes.jsp?id=${cliente.getId()}" class="ver-cartoes">Ver</a></td>
				<td><a href="viewEnderecos.jsp?id=${cliente.getId()}" class="ver-enderecos">Detalhes</a></td>
                <td><a href="editform.jsp?id=${cliente.getId()}" class="editar-usuario" style="background-color:rgb(25, 0, 51); color:white; width: 80px;">Editar</a></td>
                <td><a href="deletecliente.jsp?id=${cliente.getId()}" class="excluir-usuario" style="color: red">Excluir</a></td>
            </tr>
        </c:forEach>                            
    </table>               
    </div>
</body>
</html>


