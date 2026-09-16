import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  var teste = ['3 x 9', '27'];
  var resposta = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: dead_code
        Icon(resposta ? Icons.check : Icons.close),
        Text(
          teste[0],
          style: GoogleFonts.msMadi(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              setState(() {
                if (value == teste[1]) {
                  resposta = true;
                } else {
                  resposta = false;
                }
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Responda',
              icon: Icon(Icons.edit),
            ),
          ),
        ),
      ],
    );
  }
}
