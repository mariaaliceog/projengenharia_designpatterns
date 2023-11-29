<%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="cli" />

<%
	ClienteController clienteController = new ClienteController();

	String dddTelefone = request.getParameter("ddd");
	String numeroTelefone = request.getParameter("numero");				
	String tipoTelefone = request.getParameter("tipo");	
	Telefone telefone = new Telefone();
	telefone.setDdd(dddTelefone);
	telefone.setNumero(numeroTelefone);		
	telefone.setTipo(TipoTelefone.valueOf(tipoTelefone));
	((Cliente) cli).setTelefone(telefone);	
	
	if (cli instanceof EntidadeDominio){
		EntidadeDominio entidade = (EntidadeDominio) cli;
		clienteController.alterar(entidade);		
		response.sendRedirect("viewClientes.jsp");		
	}else{
		out.println("O objeto nao e uma instancia de entidade dominio");
	}
%>

