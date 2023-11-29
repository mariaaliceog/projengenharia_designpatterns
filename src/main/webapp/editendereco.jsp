<%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="end" class="dominio.Endereco"></jsp:useBean>
<jsp:setProperty property="*" name="end" />

<%	
	String clienteId = request.getParameter("idCliente"); 
	out.println(clienteId);
	ClienteController clienteController = new ClienteController();
	
	if (end instanceof EntidadeDominio){
		EntidadeDominio entidade = (EntidadeDominio) end;
		clienteController.alterar(entidade);		
		response.sendRedirect("viewEnderecos.jsp?id=" + clienteId);		
	}else{
		out.println("O objeto nao e uma instancia de entidade dominio");
	}
%>