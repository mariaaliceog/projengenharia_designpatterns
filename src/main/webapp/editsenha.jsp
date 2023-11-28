<%@ page import="dao.*, dominio.*, java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="cli" class="dominio.Cliente"></jsp:useBean>
<jsp:setProperty property="*" name="cli" />

<%
       
    String id = request.getParameter("id");
    String novaSenha = request.getParameter("novaSenha");

    out.println("ID: " + id);
    out.println("Nova Senha: " + novaSenha);

    ClienteDAO clienteDAO = new ClienteDAO();
    int clienteId = Integer.parseInt(id);

    int status = clienteDAO.alterarSenha(clienteId, novaSenha);

    if (status > 0) {
        response.sendRedirect("viewClientes.jsp");
    } else {
        out.println("Falha ao alterar a senha do cliente");
    }
    
%>



