import 'package:flutter/material.dart';

void main() {
  runApp(const Janela());
}

class Janela extends StatelessWidget {
  const Janela({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Principal()),
    );
  }
}

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  var frases = [
    ['Penso, logo existo.', 'René Descartes'],
    ['Só sei que nada sei.', 'Sócrates'],
    [
      'Um pequeno passo para o homem, um salto gigante para a humanidade.',
      'Neil Armstrong'
    ]
  ];

  int atual = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(frases[atual][0]),
        Text(frases[atual][1]),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if (atual < 2) {
                  atual++;
                } else {
                  atual = 0;
                }
              });
            },
            child: Text('Próxima'))
      ],
    );
  }
}
