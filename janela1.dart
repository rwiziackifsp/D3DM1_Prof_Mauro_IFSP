import 'package:flutter/material.dart';

class Janela1 extends StatelessWidget {
  // recebe a função
  const Janela1(
    this.muda, {
    // Function() muda, { // substituida pela linha 6
    super.key,
  });

  final Function() muda;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                'assets/imagens/palhaco.png',
                // width: 200,
                // color: Color.fromARGB(24, 97, 64, 62),
              ),
            ),
          ),
          const Text('Aperte o botão para  começar:'),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton.icon(
            icon: const Icon(
              Icons.arrow_right_alt,
            ),
            onPressed: () {
              print('Iniciando...');
              muda(); // executa a troca de janela /  não pode ser usada aqui, a não ser que esteja sendo setada como na linha 10
            },
            label: const Text(
                'Iniciar'), // Ao invés do child nete caso com icon e label
          ),
        ],
      ),
    );
  }
}
