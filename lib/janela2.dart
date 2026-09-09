import 'package:flutter/material.dart';
import 'pergunta.dart';
import 'questoes.dart';

class Janela2 extends StatefulWidget {
  const Janela2({
    super.key,
  });

  @override
  State<Janela2> createState() => _Janela2State();
}

class _Janela2State extends State<Janela2> {
  var testeVez = 0;
  void testeSeguinte() {
    setState(() {
      if (testeVez >= 0) {
        testeVez += 1;
        print(testeVez);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Pergunta teste1 = questoes[testeVez];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Opacity(
              opacity: 0.8,
              child: Image.asset(
                'assets/imagens/palhaco_ouve.png',
                //color: const Color.fromARGB(40, 244, 67, 54),
              ),
            ),
          ),
          Text(teste1.texto),
          const SizedBox(
            height: 10,
          ),
          ...teste1.respostas.map((item) {
            return BotaoResposta(
              // chamar: () {
              //   print('Apertado: 1');
              // },
              chamar: testeSeguinte,
              texto: item,
            );
          }),
        ],
      ),
    );
  }
}

class BotaoResposta extends StatelessWidget {
  const BotaoResposta({
    super.key,
    required this.texto,
    required this.chamar,
  });

  final String texto;
  final Function() chamar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ElevatedButton(
        // style: ButtonStyle(shape: RoundedRectangleBorder(borderRadius: 8.0),),
        onPressed: chamar,
        child: Text(texto),
      ),
    );
  }
}
