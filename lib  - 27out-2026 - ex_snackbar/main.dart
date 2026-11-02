import 'package:flutter/material.dart';

//===========================================================================================================
// INÍCIO DE TUDO
//===========================================================================================================
void main() => runApp(const MyApp());

//===========================================================================================================
// APP DA MULTIPLICAÇÃO SEM ESTADO É A CONFIG. INICIAL
//===========================================================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override // BUILDA COM MATERIALAPP QUE É QUEM VAI MOSTRAR A TELA INICIAL
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Tabuada(), // CHAMA O COMPONENTE DA TABUADA
        ),
      ),
    );
  }
}

//===========================================================================================================
// SEÇÃO DO CÓDIGO PARA A PÁGINA DA TABUADA
//===========================================================================================================
// CLASSE COM ESTADO
class Tabuada extends StatefulWidget {
  const Tabuada({super.key});

  @override
  State<Tabuada> createState() => _TabuadaState(); // CHAMA A CRIAÇÃO DO ESTADO
}

//===========================================================================================================
class _TabuadaState extends State<Tabuada> {
  // CLASSE ONDE DE FATO OCORRERÁ AÇÕES, MUDANÇAS DE ESTADO
  final TextEditingController controlador = TextEditingController();

  int fator1 =
      1; // VARIÁVEL PARA O FATOR DA MULTIPLICAÇÃO INICIANDO DA TABUADA DO 1
  int fator2 = 1; // VARIÁVEL DO COMEÇO DA MULTIPLICAÇÃO, INICIA NO 1
  double posicao = 0.0; // VARIÁVEL PARA O PROGRESSO DA INDICADOR DE PROGRESSO LINEAR (LINEARPROGRESSINDICATOR) que vai de 0.0 a 1.0

  //===========================================================================================================
  // FUNÇÃO QUE VERIFICA A RESPOSTA
  //===========================================================================================================
  void verificaResposta() {
    int respostaCorreta = fator1 * fator2;
    int? respostaInserida = int.tryParse(
      controlador.text,
    ); // PASSA O TEXTO EM NÚMERO INTEIRO

    if (respostaInserida == respostaCorreta) {
      controlador.clear();

      // SNACKBAR
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Acertou!')));

      // MUDA ESTADO DE FORMA QUE AVANCE
      setState(() {
        posicao += 0.1; //AUMENDA A BARRA DE PROGRESSO EM 0.1

        if (fator2 < 10) {
          fator2++; // INCREMENTA O FATOR ATÉ  A TABUADA DO 9 APENAS
        } else {
          // ACERTOU TODAS AVANÇA PARA O PRÓXIMO FATOR1 E RECOMEÇA O FATOR2 NO 1
          fator1++;
          fator2 = 1;
          posicao = 0.0; // REINICIA O PROGRESSO PARA 0.0
        }
      });
    } else {
      // AGUARDA FATOR1, FATOR2 E A POSIÇÃO DA BARRA ANTERIORES PARA QUANDO USUÁRIO CLICAR EM "CONTINUAR"
      int voltarFator1 = fator1;
      int voltarFator2 = fator2;
      double voltarPosicao = posicao;

      // MUDA A TABUDA SE ERRAR
      setState(() {
        fator1++;
        fator2 = 1;
        posicao = 0.0;
        controlador.clear();
      });

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        content: const Text('Errou!'),
        action: SnackBarAction(
          label: 'Continuar',
          textColor: Colors.white,
          onPressed: () {
            // ALTERA O ESTADO QUANDO CLICAR NO "CONTINUAR" PARA SEGUIR COM A TABUADA ANTERIOR
            setState(() {
              fator1 = voltarFator1;
              fator2 = voltarFator2;
              posicao = voltarPosicao;
              controlador.clear();
            });
          },
        ),
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //===========================================================================================================
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ========= BARRA DE PROGRESSO =========
        LinearProgressIndicator(value: posicao),
        const SizedBox(height: 16),
        // ========= MOSTA A OPERAÇÃO DA MULTIPLICAÇÃO  =========
        Text(
          '$fator1 x $fator2 = ?',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        // ========= CAMPO PARA A RESPOSTA =========
        TextField(
          controller: controlador,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Digite a resposta',
          ),
        ),
        const SizedBox(height: 16),
        // ========= BOTÃO DE "VERIFICAR" A RESPOSTA =========
        ElevatedButton(
          onPressed: verificaResposta,
          child: const Text('Verificar'),
        ),
      ],
    );
  }
}
//=======================================     fim     =============================================
