<%@page import="java.text.NumberFormat"%>
<%@ page import="dao.*, dominio.*, java.util.*, controle.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="end" class="dominio.Endereco" scope="request"></jsp:useBean>
<jsp:setProperty property="*" name="end" />

<%	
	String clienteId = request.getParameter("idCliente");	
	out.println(clienteId);	
	
	String cidadeNome = request.getParameter("nomeCidade");	
	String estadoNome = request.getParameter("nomeEstado");
	String paisNome = request.getParameter("nomePais");
	Cidade cidade = new Cidade();
	Estado estado = new Estado();
	Pais pais = new Pais();
	
	pais.setNome(paisNome);	
	estado.setNome(estadoNome);
	estado.setPais(pais);
	cidade.setEstado(estado);
	cidade.setNome(cidadeNome);			
	end.setCidade(cidade);
	out.println(end.getCidade().getNome());
	
	try{	
	
		ClienteController endereco = new ClienteController();	
	
	if (end instanceof EntidadeDominio) {		
	    EntidadeDominio entidade = (EntidadeDominio) end;	    
	    end.setIdCliente(Integer.parseInt(clienteId));	    
	    String msg = endereco.salvar(entidade);	  	    
    
	    if ("Endereço salvo com sucesso".equals(msg)) {
	        response.sendRedirect("viewEnderecos.jsp?id=" + clienteId);		
	    } else {	        
	        out.println(msg);	
	    }
	    
	}else{
		out.println("O objeto nao e uma instancia de entidade dominio");
		
	}
	}catch(NumberFormatException e){
		e.printStackTrace();
	}

%>