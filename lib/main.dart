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
  final itens = [
    'https://agenciamarcospontes.com.br/wp-content/uploads/2020/03/turismo-aurora-boreal.jpg',
    'https://thumb.wikimedia.org/wikipedia/commons/thumb/5/52/Aurora_australis_ISS.jpg/250px-Aurora_australis_ISS.jpg?utm_source=pt.wikipedia.org&utm_campaign=parser&utm_content=thumbnail',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Jo0aeWbFbjXPRnvvB0pvU6TKm5-HUxj2Z8mQxv5YEwMV8nxM1TREJWYz&s=10',
    'https://aventurasnahistoria.com.br/wp-content/uploads/2025/11/Design-sem-nome-2025-11-25T145607.255.jpg'
  ];
  String resposta = '';

  Future<void> esperaResposta(x, BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (context) => Teste(x)),
    );

    if (!context.mounted) return;

    print('Respondeu: $resultado');

    setState(() {
      print(x);
      if (resultado ?? false) {
        itens.remove(x); // e mapeado em itens
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            esperaResposta(e, context);
          },
          child: Column(
            children: [
              ...itens.map((e) {
                return Image.network(
                  e.toString(),
                  width: 200,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class Teste extends StatefulWidget {
  Teste(this.x, {super.key});

  final x;

  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  var operacao = '';
  int numeroAleatorio = 0;
  int esperado = 0;
  String resultado = '';
  TextEditingController controlaTexto = TextEditingController();

  @override
  void initState() {
    // numeroAleatorio = Random().nextInt(9) + 1;
    // operacao = '${widget.x} + $numeroAleatorio';
    // esperado = widget.x + numeroAleatorio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ida')),
      body: Center(
        child: Column(
          children: [
            Image.network(e),
            Text(operacao),
            TextField(
              controller: controlaTexto,
            ),
            ElevatedButton(
                onPressed: () {
                  resultado = controlaTexto.text;
                  if (esperado.toString() == resultado) {
                    print('Retornando: true');
                    Navigator.pop(context, true);
                  } else {
                    print('Retornando: false');
                    Navigator.pop(context, false);
                  }
                },
                child: Text('Aprovar')),
            ElevatedButton(
                onPressed: () {
                  resultado = controlaTexto.text;
                  if (esperado.toString() == resultado) {
                    print('Retornando: true');
                    Navigator.pop(context, true);
                  } else {
                    print('Retornando: false');
                    Navigator.pop(context, false);
                  }
                },
                child: Text('Rerovar'))
          ],
        ),
      ),
    );
  }
}
