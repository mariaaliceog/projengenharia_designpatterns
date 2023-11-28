<%@page import="dao.*, dominio.*, controle.*"%>
<jsp:useBean id="cart" class="dominio.Cartao"></jsp:useBean>
<jsp:setProperty property="*" name="cart"/>

<%
	String clienteId = request.getParameter("clienteId");
	ClienteController clienteController = new ClienteController();	
	
	if (cart != null) {
	    EntidadeDominio entidade = (EntidadeDominio) cart;
	    try {
	        String msg = clienteController.excluir(cart);	        
	        response.sendRedirect("viewCartoes.jsp?id=" + clienteId);
	        
	    } catch (Exception e) {
	        out.println("Erro ao excluir cartao: " + e.getMessage());
	        e.printStackTrace();
	    }
	}
   
%>