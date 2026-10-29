# 🚀 Laboratorio 09: Sistema de Registro de Contacto (PHP & JSP)

**Universidad:** Universidad Nacional del Centro del Perú  
**Facultad:** Facultad de Ingeniería de Sistemas  
**Curso:** Desarrollo de Aplicaciones Web (IS093A)  
**Alumno:** Pariona Larrota Andre Sebastian
**Fecha:** 29.10.2026  

---

## 📂 1. Estructura del Proyecto
El proyecto está dividido en dos entornos independientes (PHP y JSP), junto con la documentación y capturas de pantalla.

```text
Lab09_Contacto/
├── php-app/
│   ├── index.html
│   └── registro.php
├── jsp-app/
│   ├── index.jsp
│   └── registro.jsp
├── capturas/
│   ├── php_form.png
│   ├── php_tabla.png
│   ├── jsp_form.png
│   ├── jsp_tabla.png
│   ├── error_405.png
│   └── logs.png
└── README.md

2. Ciclo de Vida HTTP (Flujo Completo)
El flujo de una petición en este sistema se documenta paso a paso de la siguiente manera:

Cliente (Navegador): El usuario llena el formulario y presiona "Enviar". El navegador construye una petición HTTP POST enviando los datos en el cuerpo (nombre=...&correo=...).

DNS (Domain Name System): El navegador busca la IP del servidor. En este caso, localhost se resuelve a la IP 127.0.0.1.

Capa TCP/IP: Se establece una conexión TCP con el servidor en el puerto correspondiente (puerto 80 para Apache/PHP y puerto 8080 para Tomcat/JSP).

HTTP Request: Se envía la petición al servidor con las cabeceras correspondientes y los datos del formulario.

Server (Recepción):

PHP: Apache recibe la petición y se la pasa al intérprete PHP.

JSP: El contenedor Tomcat recibe la petición y ejecuta el Servlet compilado.

Backend (Lógica): Se valida el método POST. Se sanitizan los campos para evitar XSS. Se guardan los datos en memoria ($_SESSION para PHP y HttpSession para JSP).

Response: El servidor genera un HTML dinámico (con los datos ingresados) y devuelve un estado HTTP 200 OK.

Render: El navegador recibe el HTML, procesa el CSS (diseño atractivo) y pinta la tabla de registros en pantalla.

<h3>⚖️ 3. Matriz Comparativa: PHP vs JSP</h3>

<table border="1" cellpadding="8" cellspacing="0" style="border-collapse: collapse; width: 100%; font-family: Arial, sans-serif;">
  <thead style="background-color: #f2f2f2;">
    <tr>
      <th>Criterio Técnico</th>
      <th>PHP (Hypertext Preprocessor)</th>
      <th>JSP (JavaServer Pages)</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Ciclo de Vida</strong></td>
      <td>Interpretado en cada petición (o cacheado con OPcache). No tiene un ciclo de vida estricto de aplicación.</td>
      <td>Compilado a un Servlet en la primera petición. Tiene un ciclo de vida estricto (init, service, destroy).</td>
    </tr>
    <tr>
      <td><strong>Rendimiento</strong></td>
      <td>Excelente para peticiones rápidas y apps ligeras. Bajo consumo de recursos.</td>
      <td>Mayor consumo de memoria (JVM), pero excelente para apps de alta concurrencia y escalabilidad.</td>
    </tr>
    <tr>
      <td><strong>Despliegue</strong></td>
      <td>Muy sencillo. Se copia el archivo <code>.php</code> en la carpeta <code>htdocs</code> de Apache.</td>
      <td>Requiere un contenedor (Tomcat). Se empaqueta en un archivo <code>.war</code> y se despliega en <code>webapps</code>.</td>
    </tr>
    <tr>
      <td><strong>Gestión de Estado</strong></td>
      <td>Nativa y simple. Se usa <code>session_start()</code> y la súper global <code>$_SESSION</code>.</td>
      <td>Más estructurada. Se usa <code>HttpSession</code> mediante objetos Java, lo cual es más seguro pero verboso.</td>
    </tr>
    <tr>
      <td><strong>Seguridad / XSS</strong></td>
      <td>Se usa <code>htmlspecialchars()</code> y <code>filter_input()</code> para sanitizar las entradas.</td>
      <td>Se usa EL/JSTL (<code>&lt;c:out&gt;</code>) o funciones Java como <code>.replace("&lt;", "&amp;lt;")</code> para escapar datos.</td>
    </tr>
    <tr>
      <td><strong>Madurez y Ecosistema</strong></td>
      <td>Enorme comunidad. Frameworks como Laravel, Symfony. Ideal para startups.</td>
      <td>Muy maduro y robusto. Frameworks como Spring Boot. Estándar en banca y grandes empresas.</td>
    </tr>
  </tbody>
</table>

🛡️ 4. Seguridad Básica Implementada
Para cumplir con los estándares de seguridad de la práctica, se implementó lo siguiente:

Validación de Método POST: Tanto registro.php como registro.jsp verifican el método de la petición ($_SERVER['REQUEST_METHOD'] y request.getMethod()). Si se intenta acceder por URL (GET), se bloquea con un código de error HTTP 405 (Method Not Allowed).

Prevención de XSS (Cross-Site Scripting):

En PHP, todos los datos se validan con filter_input y se imprimen usando htmlspecialchars(), convirtiendo etiquetas HTML en texto plano.

En JSP, los datos se escapan usando .replace("<", "&lt;") antes de imprimirse en la tabla para evitar la ejecución de scripts.

Manejo de Errores: Si los datos vienen vacíos o el correo es inválido, el backend retorna un HTTP 400 (Bad Request) con un mensaje controlado, evitando la ruptura del sistema.