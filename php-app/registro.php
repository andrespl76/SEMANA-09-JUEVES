<?php
// 1. Validar método POST (Seguridad)
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405); // Method Not Allowed
    exit('Error 405: Método no permitido');
}

// 2. Sanitización y Validación de los 5 campos
$nombre   = filter_input(INPUT_POST, 'nombre', FILTER_SANITIZE_SPECIAL_CHARS);
$correo   = filter_input(INPUT_POST, 'correo', FILTER_VALIDATE_EMAIL);
$telefono = filter_input(INPUT_POST, 'telefono', FILTER_SANITIZE_SPECIAL_CHARS);
$asunto   = filter_input(INPUT_POST, 'asunto', FILTER_SANITIZE_SPECIAL_CHARS);
$mensaje  = filter_input(INPUT_POST, 'mensaje', FILTER_SANITIZE_SPECIAL_CHARS);

// Verificar que no vengan vacíos y que el correo sea válido
if (!$nombre || !$correo || !$telefono || !$asunto || !$mensaje) {
    http_response_code(400); // Bad Request
    exit('Error 400: Datos inválidos o incompletos.');
}

// 3. Guardar en Sesión
session_start();
$_SESSION['registros'][] = [
    'nombre' => $nombre,
    'correo' => $correo,
    'telefono' => $telefono,
    'asunto' => $asunto,
    'mensaje' => $mensaje
];
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registros Exitosos (PHP)</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #8A2BE2; --secondary: #FF1493; }
        * { box-sizing: border-box; font-family: 'Poppins', sans-serif; margin: 0; padding: 0; }
        body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 40px 20px; }
        .container { background: rgba(255, 255, 255, 0.95); padding: 30px; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.2); max-width: 1000px; margin: auto; }
        h2 { color: #333; margin-bottom: 20px; text-align: center; }
        table { width: 100%; border-collapse: collapse; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: linear-gradient(to right, var(--primary), var(--secondary)); color: white; font-weight: 600; }
        tr:hover { background-color: #fcf4ff; }
        .btn { display: inline-block; margin-top: 25px; padding: 12px 25px; background: #333; color: white; text-decoration: none; border-radius: 8px; font-weight: 600; transition: background 0.3s; text-align: center; width: 100%; }
        .btn:hover { background: var(--primary); }
    </style>
</head>
<body>
    <div class="container">
        <h2>📋 Registros Almacenados en Sesión PHP</h2>
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
                <?php foreach ($_SESSION['registros'] as $index => $reg): ?>
                <tr>
                    <td><?= $index + 1 ?></td>
                    <!-- Uso de htmlspecialchars para blindar contra XSS -->
                    <td><?= htmlspecialchars($reg['nombre'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($reg['correo'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($reg['telefono'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($reg['asunto'], ENT_QUOTES, 'UTF-8') ?></td>
                    <td><?= htmlspecialchars($reg['mensaje'], ENT_QUOTES, 'UTF-8') ?></td>
                </tr>
                <?php endforeach; ?>
            </tbody>
        </table>
        <a href="index.html" class="btn">← Volver al Formulario</a>
    </div>
</body>
</html>