<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 09 | Registro JSP Moderno</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #FF4500; --secondary: #FFD700; /* Colores diferentes para JSP */ }
        * { box-sizing: border-box; font-family: 'Poppins', sans-serif; margin: 0; padding: 0; }
        body {
            background: linear-gradient(135deg, #f12711 0%, #f5af19 100%); /* Fondo llamativo */
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 500px;
            border-top: 5px solid var(--primary);
        }
        h2 { text-align: center; color: #333; margin-bottom: 25px; font-weight: 600; }
        .form-group { margin-bottom: 15px; }
        label { display: block; font-size: 0.9rem; color: #555; margin-bottom: 5px; font-weight: 600; }
        input, textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: #f9f9f9;
        }
        input:focus, textarea:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 8px rgba(255, 69, 0, 0.3);
            background: #fff;
        }
        textarea { resize: vertical; min-height: 80px; }
        button {
            width: 100%;
            padding: 15px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(255, 69, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>🔥 Formulario de Contacto (JSP)</h2>
        <form action="registro.jsp" method="POST">
            <div class="form-group">
                <label>Nombre Completo</label>
                <input type="text" name="nombre" required placeholder="Ej. Carlos Pérez">
            </div>
            <div class="form-group">
                <label>Correo Electrónico</label>
                <input type="email" name="correo" required placeholder="carlos@ejemplo.com">
            </div>
            <div class="form-group">
                <label>Teléfono</label>
                <input type="tel" name="telefono" required placeholder="+51 999 888 777">
            </div>
            <div class="form-group">
                <label>Asunto</label>
                <input type="text" name="asunto" required placeholder="Motivo de contacto">
            </div>
            <div class="form-group">
                <label>Mensaje</label>
                <textarea name="mensaje" required placeholder="Escribe tu mensaje aquí..."></textarea>
            </div>
            <button type="submit">Enviar Registro</button>
        </form>
    </div>
</body>
</html>