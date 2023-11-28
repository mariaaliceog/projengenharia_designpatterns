<%@page import="dao.*, dominio.*, controle.*"%>
<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="cli"/>

<%
	ClienteController cliente = new ClienteController();
    if (cli instanceof EntidadeDominio) {
        EntidadeDominio entidade = (EntidadeDominio) cli;
        String i = cliente.excluir(entidade); // Use a instância clienteDAO
        response.sendRedirect("viewClientes.jsp");
    } else {
    	out.println("O objeto cli não é uma instância de EntidadeDominio (Cliente).");
    }
   
%>