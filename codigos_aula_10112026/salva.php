<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Salvando</title>
</head>
<body>
    <p>Salvando foto.</p>
    <?php
        $usuarioBD = "if0_43338559";
        $senhaBD = "815gnOibF9JX";
        $nomeBD = "if0_43338559_site";
        $host = "sql200.infinityfree.com";
        $porta = "3306";

        // print_r($_FILES);
        $nome = $_FILES['foto']['name'];
        $destino = "imagens/" . $nome;

        $origem = $_FILES['foto']['tmp_name'];

        $resultado = move_uploaded_file($origem, $destino);

        if($resultado) {
            echo "Imagem recebida!";

            $comandoSQL = "INSERT INTO `fotos` (`id`, `nome`, `texto`) VALUES (NULL, '$destino', '')";
            $conexao = new PDO("mysql:host=$host;dbname=$nomeBD", $usuarioBD, $senhaBD);

            $resultado = $conexao->query($comandoSQL);

            if($resultado) {
                echo "Salva no banco!";
            } else {
                echo "Erro ao salvar no BD";
            }
        } else {
            echo "Erro no envio!";
        }
    ?>
</body>
</html>