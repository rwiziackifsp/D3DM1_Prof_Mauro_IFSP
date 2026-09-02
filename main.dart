import 'package:flutter/material.dart';
import 'package:flutter_application_tabuada/janela1.dart';
import 'package:flutter_application_tabuada/janela2.dart';

void main() {
  runApp(
    Controle(),
  );
}

class Controle extends StatefulWidget {
  const Controle({super.key});

  @override
  State<Controle> createState() => _ControleState();
}

class _ControleState extends State<Controle> {
  // var atual = Janela1(); // atual do tipo Janela1
  // Widget var atual = Janela1(); // atual do tipo Widget
  // Widget? atual; // envia a função que será chamada / precisa esperar muda para ser criada
  var janela = 'um';

  // @override
  // void initState() {
  //   // atual = Janela1(muda); // espera a inicialização
  //   super.initState();
  // } // -> linhas comentadas para fazer o IF a parti de lin37

  // Criação de muda
  void muda() {
    setState(() {
      janela = 'dois';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget atual = Janela1(muda);

    // Adicionado após teste do ternário ?:
    if (janela == 'um') {
      atual = Janela1(muda);
    } else {
      atual = const Janela2();
    }

    return MaterialApp(
      // home: atual,

      home: atual,
      //home: janela == 'um' ? Janela1(muda) : Janela2()
    );
  }
}
