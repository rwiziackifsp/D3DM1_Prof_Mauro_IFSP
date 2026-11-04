<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mostrando</title>
</head>
<body>
<?php
$usuarioBD = "root";
$senhaBD = "";
$nomeBD = "if0_43338559_site";
$host = "localhost";

$conexao = new PDO("mysql:host=$host;dbname=$nomeBD", $usuarioBD, $senhaBD);
$comandoSQL = "SELECT `id`, `nome` FROM `fotos` WHERE `id` > 0";

if(isset($_GET['id'])) {
    $comandoSQL = "SELECT `id`, `nome` FROM `fotos` WHERE `id` >= {$_GET['id']}";
} 

$sth = $conexao->prepare($comandoSQL);
$sth->execute();

$resultado = $sth->fetch(PDO::FETCH_ASSOC);

if($resultado) {
    echo "{$resultado['nome']} - ";
    echo "ID: {$resultado['id']}";
} else {
    echo "Nada aqui!";
}
?>
</body>
</html>