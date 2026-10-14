import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aula_d3dm1_mauro_13102026/helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Garante a inicialização correta dos Widgets do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // SE ESTIVER RODANDO NO WINDOWS OU LINUX, INICIALIZA O MOTOR FFI
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaDono = TextEditingController();
  TextEditingController controlaIdade = TextEditingController();

  Future<void> salvarNoBanco() async {
// Monta o mapa com os dados no formato que a tabela espera
    Map<String, dynamic> novoCao = {
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': controlaIdade.text,
    };

    // Salva no banco de dados local usando nossa classe auxiliar
    await DatabaseHelper.inserirCao(novoCao);

    // Feedback
    print('${controlaNome.text} salvo com sucesso!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaNome,
                  decoration: InputDecoration(
                    labelText: 'Nome do pet',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaDono,
                  decoration: InputDecoration(
                    labelText: 'Nome do dono',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaIdade,
                  decoration: InputDecoration(
                    labelText: 'Idade do pet',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(controlaNome.text);
                    print(controlaDono.text);
                    print(controlaIdade.text);
                    salvarNoBanco();
                  },
                  child: Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
