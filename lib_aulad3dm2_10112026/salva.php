
    <?php
header('Content-Type: application/json; charset=utf-8');
        $usuarioBD = "root";
        $senhaBD = "";
        $nomeBD = "if0_43338559_site";
        $host = "localhost";
        $porta = "3306";

        // print_r($_FILES);
        $nome = $_FILES['foto']['name'];
        $destino = "imagens/" . $nome;

        $origem = $_FILES['foto']['tmp_name'];

        $resultado = move_uploaded_file($origem, $destino);

        if($resultado) {
//            echo "Imagem recebida!";

            $comandoSQL = "INSERT INTO `fotos` (`id`, `nome`, `texto`) VALUES (NULL, '$destino', '')";
            $conexao = new PDO("mysql:host=$host;port=$porta;dbname=$nomeBD;charset=utf8", $usuarioBD, $senhaBD);

            $resultado = $conexao->query($comandoSQL);

            if($resultado) {
                echo json_encode(["status" => "Salvo!"], JSON_UNESCAPED_UNICODE);
            } else {
                echo json_encode(["status" => "Erro ao salvar no Data Base"], JSON_UNESCAPED_UNICODE);
            }
        } else {
            echo json_encode(["status" => "Erro de envio!"], JSON_UNESCAPED_UNICODE);
        }
    ?>