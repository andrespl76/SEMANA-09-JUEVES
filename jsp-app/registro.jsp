<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 1. Validar método POST
    if (!"POST".equals(request.getMethod())) {
        response.setStatus(405);
        out.println("<h2>Error 405: Método no permitido</h2>");
        return;
    }

    // 2. Obtener parámetros
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String telefono = request.getParameter("telefono");
    String asunto = request.getParameter("asunto");
    String mensaje = request.getParameter("mensaje");

    // Validar que no estén vacíos
    if (nombre == null || correo == null || telefono == null || asunto == null || mensaje == null || 
        nombre.trim().isEmpty() || correo.trim().isEmpty()) {
        response.setStatus(400);
        out.println("<h2>Error 400: Datos inválidos o incompletos</h2>");
        return;
    }

    // 3. Guardar en sesión (Lista de Mapas)
    HttpSession sesion = request.getSession();
    List<Map<String, String>> registros = (List<Map<String, String>>) sesion.getAttribute("registros");
    if (registros == null) {
        registros = new ArrayList<>();
    }
    Map<String, String> nuevoRegistro = new HashMap<>();
    nuevoRegistro.put("nombre", nombre);
    nuevoRegistro.put("correo", correo);
    nuevoRegistro.put("telefono", telefono);
    nuevoRegistro.put("asunto", asunto);
    nuevoRegistro.put("mensaje", mensaje);
    registros.add(nuevoRegistro);
    sesion.setAttribute("registros", registros);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registros Exitosos (JSP)</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #FF4500; --secondary: #FFD700; }
        * { box-sizing: border-box; font-family: 'Poppins', sans-serif; margin: 0; padding: 0; }
        body { background: linear-gradient(135deg, #f12711 0%, #f5af19 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 30px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 1000px; margin: auto; }
        h2 { color: #333; margin-bottom: 20px; text-align: center; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: linear-gradient(to right, var(--primary), var(--secondary)); color: white; font-weight: 600; }
        tr:hover { background-color: #fff8e1; }
        .btn { display: inline-block; margin-top: 25px; padding: 12px 25px; background: #333; color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: background 0.3s; text-align: center; width: 100%; }
        .btn:hover { background: var(--primary); }
    </style>
</head>
<body>
    <div class="container">
        <h2>🎯 Registros Almacenados en Sesión JSP</h2>
        <table>
            <thead>
                <tr>
                    <th>#</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Teléfono</th>
                    <th>Asunto</th>
                    <th>Mensaje</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (registros != null && !registros.isEmpty()) {
                        int i = 1;
                        for (Map<String, String> reg : registros) {
                            // Prevención XSS: Escapar etiquetas HTML
                            String nomSeguro = reg.get("nombre").replace("<", "&lt;").replace(">", "&gt;");
                            String corSeguro = reg.get("correo").replace("<", "&lt;").replace(">", "&gt;");
                            String telSeguro = reg.get("telefono").replace("<", "&lt;").replace(">", "&gt;");
                            String asuSeguro = reg.get("asunto").replace("<", "&lt;").replace(">", "&gt;");
                            String menSeguro = reg.get("mensaje").replace("<", "&lt;").replace(">", "&gt;");
                %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= nomSeguro %></td>
                    <td><%= corSeguro %></td>
                    <td><%= telSeguro %></td>
                    <td><%= asuSeguro %></td>
                    <td><%= menSeguro %></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr><td colspan="6" style="text-align:center;">No hay registros aún.</td></tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <a href="index.jsp" class="btn">← Volver al Formulario</a>
    </div>
</body>
</html>