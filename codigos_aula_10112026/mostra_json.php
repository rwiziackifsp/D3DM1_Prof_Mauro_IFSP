<?php
header('Content-Type: application/json; charset=utf-8');

$usuarioBD = "if0_43338559";
$senhaBD = "815gnOibF9JX";
$nomeBD = "if0_43338559_site";
$host = "sql200.infinityfree.com";

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