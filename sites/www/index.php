<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>dockerbox</title>
    <link rel="stylesheet" href="css/normalize.css"/>
    <link rel="stylesheet" href="css/estilos.css"/>
</head>
<body>
<main>
    <h1>dockerbox</h1>
    <p>Entorno de desarrollo para programación web con PHP en Docker.</p>
    <p>Más información en el <a target="_blank" href="https://github.com/ijaureguialzo/dockerbox">repositorio de
            GitHub</a>.</p>
</main>
<footer>
    <span>
        <?php
        // REF: Formato de fecha y hora: https://stackoverflow.com/a/16921843
        $dt = new DateTime;
        $formatter = new IntlDateFormatter('es', IntlDateFormatter::FULL, IntlDateFormatter::LONG, new DateTimeZone("Europe/Madrid"));
        echo $formatter->format($dt);
        ?></span>
    <span class="separador">·</span>
    <span>Versión de PHP: <?php echo phpversion() ?></span>
</footer>
</body>
</html>
