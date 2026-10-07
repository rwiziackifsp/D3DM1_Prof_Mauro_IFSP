import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controlador = TextEditingController();
  String diarioConteudo = '';

  @override
  void initState() {
    super.initState();
    lerDiario();
  }

  // Pega a pasta de documentos do dispositivo
  Future<String> get _pastaDocumentos async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Cria a referência para o arquivo diario.txt
  Future<File> get _arquivo async {
    final caminho = await _pastaDocumentos;
    return File('$caminho/diario.txt');
  }

  // Lê todo o conteúdo do diário do arquivo
  void lerDiario() async {
    try {
      final arquivo = await _arquivo;
      String conteudo = await arquivo.readAsString();
      setState(() {
        diarioConteudo = conteudo;
      });
    } catch (_) {
      setState(() {
        diarioConteudo = 'Nenhuma anotação ainda.';
      });
    }
  }

  // Salva uma nova linha no arquivo com a data atual
  void salvarLinha() async {
    if (controlador.text.isEmpty) return;

    final arquivo = await _arquivo;
    DateTime agora = DateTime.now();

    // Formata a data de maneira simples (AAAA-MM-DD)
    String dataFormatada =
        '${agora.year}-${agora.month.toString().padLeft(2, '0')}-${agora.day.toString().padLeft(2, '0')}';

    String novaLinha = '$dataFormatada: ${controlador.text}\n';

    // Escreve no arquivo acumulando o texto anterior (mode: FileMode.append)
    await arquivo.writeAsString(novaLinha, mode: FileMode.append);

    controlador.clear();
    lerDiario(); // Recarrega o texto na tela
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meu Diário'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controlador,
                decoration: const InputDecoration(
                  hintText: 'Digite sua anotação...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: salvarLinha,
                child: const Text('Salvar no Diário'),
              ),
              const SizedBox(height: 20),
              const Text(
                'Histórico do Diário:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: SingleChildScrollView(
                    child: Text(diarioConteudo),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
