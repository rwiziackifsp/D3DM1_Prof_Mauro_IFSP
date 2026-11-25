import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Escolher());
  }
}

class Escolher extends StatefulWidget {
  const Escolher({super.key});

  @override
  State<Escolher> createState() => _EscolherState();
}

class _EscolherState extends State<Escolher> {
  final valorInteiro = Random().nextInt(5) + 1;
  final TextEditingController resposta = TextEditingController();
  String resultado = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('Digite um número de 1 até 5:'),

          TextField(controller: resposta),

          ElevatedButton(
            onPressed: () {
              if (resposta.text == valorInteiro.toString()) {
                resultado = 'Acertou!';
              } else {
                resultado = 'Errou! O número era $valorInteiro';
              }

              setState(() {});
            },
            child: Text('Verificar'),
          ),

          Text(resultado),
        ],
      ),
    );
  }
}
