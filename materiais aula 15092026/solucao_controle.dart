import 'package:flutter/material.dart';
import 'package:flutter_application_3/frase_controle.dart';

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
  FraseControle controle = FraseControle();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(controle.fraseAtual.texto),
        Text(controle.fraseAtual.autor),
        ElevatedButton(
            onPressed: () {
              setState(() {
                controle.proximaFrase();
              });
            },
            child: Text('Próxima'))
      ],
    );
  }
}
