<%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="cart" class="dominio.Cartao"></jsp:useBean>
<jsp:setProperty property="*" name="cart" />

<%	
	String clienteId = request.getParameter("idCliente");	
	ClienteController cartao = new ClienteController(); 
	
	if (cart instanceof EntidadeDominio) {			
	    EntidadeDominio entidade = (EntidadeDominio) cart;	    
	    cart.setIdCliente(Integer.parseInt(clienteId));
	    String msg = cartao.salvar(entidade);
	    
	    if("Cartão salvo com sucesso".equals(msg)){
	    	response.sendRedirect("viewCartoes.jsp?id=" + clienteId);	
		}else{
			out.println(msg);
		}
	}else{
		out.println("O objeto nao e uma instancia de entidade dominio");
	}

%>

