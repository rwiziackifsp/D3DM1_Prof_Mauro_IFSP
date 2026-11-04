<?php
header('Content-Type: application/json; charset=utf-8');

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
    echo json_encode($resultado, JSON_UNESCAPED_UNICODE);
} else {
    echo json_encode(["erro" => "Nenhuma imagem encontrada"], JSON_UNESCAPED_UNICODE);
}
?>