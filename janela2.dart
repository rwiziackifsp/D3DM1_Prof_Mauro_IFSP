import 'package:flutter/material.dart';
import 'package:flutter_application_tabuada/pergunta.dart';
import 'package:flutter_application_tabuada/questoes.dart';

class Janela2 extends StatelessWidget {
  const Janela2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Pergunta teste1 = Pergunta('1 + 1', ['3', '2', '4', '5']);
    Pergunta teste1 = questoes[2];
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/imagens/palhaco_ouve.png',
                // width: 200,
                // color: Color.fromARGB(24, 97, 64, 62),
              ),
            ),
          ),
          // const Text('1 + 1 = ?'),
          Text(teste1.texto),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            // child: const Text('respostas 1'),
            child: Text(teste1.respostas[0]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            // child: const Text('respostas 2'),
            child: Text(teste1.respostas[1]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            // child: const Text('respostas 3'),
            child: Text(teste1.respostas[2]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            // child: const Text('respostas 4'),
            child: Text(teste1.respostas[3]),
          ),
        ],
      ),
    );
  }
}
