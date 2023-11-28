<%@page import="dao.*, dominio.*, controle.*"%>
<jsp:useBean id="end" class="dominio.Endereco"></jsp:useBean>
<jsp:setProperty property="*" name="end"/>

<%
	String clienteId = request.getParameter("clienteId");
	ClienteController endereco = new ClienteController();	
	
	if (end instanceof EntidadeDominio) {
    EntidadeDominio entidade = (EntidadeDominio) end;    
    String i = endereco.excluir(entidade);	        
    response.sendRedirect("viewEnderecos.jsp?id=" + clienteId);	
	        
    } else {
    	out.println("O objeto end não é uma instância de EntidadeDominio.");
    }
	
   
%>