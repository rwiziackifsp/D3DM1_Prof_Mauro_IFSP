import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controleTexto = TextEditingController();

  // Função para pegar a pasta de documentos (igual ao slide 20)
  Future<String> get_pastaDocumentos() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Função para pegar a referência do arquivo (igual ao slide 22)
  Future<File> get_arquivo() async {
    final caminho = await get_pastaDocumentos();
    return File('$caminho/organiza.md');
  }

  // Função para salvar o texto no arquivo (igual ao slide 23)
  void salvarTexto() async {
    final arquivo = await get_arquivo();
    await arquivo.writeAsString(controleTexto.text);
  }

  // Função para ler o texto do arquivo (igual ao slide 24)
  void lerTexto() async {
    try {
      final arquivo = await get_arquivo();
      final conteudo = await arquivo.readAsString();
      setState(() {
        controleTexto.text = conteudo;
      });
    } catch (_) {
      // se acontecer um erro (ex: arquivo nao existe)
      controleTexto.text = '';
    }
  }

  // Função para apagar o arquivo
  void apagarTexto() async {
    try {
      final arquivo = await get_arquivo();
      if (await arquivo.exists()) {
        await arquivo.delete();
      }
    } catch (_) {}

    setState(() {
      controleTexto.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    lerTexto(); // Carrega o texto salvo assim que o app abre
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Editor de Markdown')),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controleTexto,
                  maxLines: 8,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Digite o texto em Markdown aqui',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  salvarTexto();
                },
                child: const Text('SALVAR'),
              ),
              ElevatedButton(
                onPressed: () {
                  apagarTexto();
                },
                child: const Text('APAGAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
