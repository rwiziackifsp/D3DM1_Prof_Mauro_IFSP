// main.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'frase_controle.dart';

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

  TextEditingController controladorTexto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //   Usando Google fonts, ajuste a fonte da frase para Montserrat e do autor para Ms Madi, use o tamanho 28 para o texto e 18 para o autor.

        Text(
          controle.fraseAtual.texto,
          style: GoogleFonts.montserrat(fontSize: 28),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              controle.fraseAtual.mudaLike();
            });
          },
          child: Icon(controle.fraseAtual.liked
              ? Icons.favorite
              : Icons.favorite_border),
        ),
        Text(
          controle.fraseAtual.autor,
          style: GoogleFonts.msMadi(fontSize: 22),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              print(controladorTexto.text);
              controle.proximaFrase();
            });
          },
          child: Text('Próxima'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controladorTexto,
            decoration: InputDecoration(
              icon: Icon(Icons.edit),
              border: OutlineInputBorder(),
              hintText: 'Comente...',
            ),
          ),
        )
      ],
    );
  }
}
