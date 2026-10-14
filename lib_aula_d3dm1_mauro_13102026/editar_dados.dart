import 'package:flutter/material.dart';

class EditarDados extends StatelessWidget {
  const EditarDados({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Pergunta teste1 = questoes[2];
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/imagens/palhaco_ouve.png',
              ),
            ),
          ),
          Text(teste1.texto),
          const SizedBox(
            height: 10,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text(teste1.respostas[0]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text(teste1.respostas[1]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text(teste1.respostas[2]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            child: Text(teste1.respostas[3]),
          ),
        ],
      ),
    );
  }
}
