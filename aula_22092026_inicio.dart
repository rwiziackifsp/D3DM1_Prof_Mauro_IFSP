import 'package:flutter/material.dart';
import 'dart:math';
//================================== PARTE I DA AULA ==================================
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: GestureDetector(
//             // child: Text('Aperte!'),
//             // child: Image.asset('assets/imagens/hexgirl.png'),
//             child: Image.network(
//                 'https://i.ytimg.com/vi/rsWzvjH6Yqk/oar2.jpg?sqp=-oaymwEYCJUDENAFSFqQAgHyq4qpAwcIARUAAIhC&rs=AOn4CLB-mtvtv1P3Dk47cjXcF-tuhMmotA&usqp=CCk'),
//             onTap: () {
//               print('Apertado!');
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

//================================== PARTE II DA AULA ==================================
// void main() {
//   runApp(const MaterialApp(title: 'Navigation Basics', home: FirstRoute()));
// }

// class FirstRoute extends StatelessWidget {
//   const FirstRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'PRIMEIRA ROTA',
//             style: TextStyle(
//               letterSpacing: 5,
//             ),
//           ),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             child: const Text('Abrir rota'),
//             onPressed: () {
//               // Navigate para a segunda rota quando pressionado.
//               Navigator.push(
//                 context,
//                 MaterialPageRoute<void>(
//                   builder: (context) => const SecondRoute(),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('SEGUNDA ROTA')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () {
//               // Navega de volta para a primeira rota quando pressionado.
//               Navigator.pop(context);
//             },
//             child: const Text('Voltar!'),
//           ),
//         ),
//       ),
//     );
//   }
// }

//================================== PARTE III DA AULA ==================================

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Escolher());
//   }
// }

// class Escolher extends StatefulWidget {
//   const Escolher({super.key});

//   @override
//   State<Escolher> createState() => _EscolherState();
// }

// class _EscolherState extends State<Escolher> {
//   final itens = [1, 2, 3, 4, 5, 6, 7, 8, 9];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ...itens.map((e) {
//             return ElevatedButton(
//               child: Text(e.toString()),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute<void>(builder: (context) => Teste(e)),
//                 );
//               },
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }

// class Teste extends StatefulWidget {
//   Teste(this.x, {super.key});

//   final int x;

//   @override
//   State<Teste> createState() => _TesteState();
// }

// class _TesteState extends State<Teste> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Ida')),
//       body: Center(child: Text('Recebido: ${widget.x}')),
//     );
//   }
// }

//================================== PARTE IV DA AULA ==================================

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Escolher());
//   }
// }

// class Escolher extends StatefulWidget {
//   const Escolher({super.key});

//   @override
//   State<Escolher> createState() => _EscolherState();
// }

// class _EscolherState extends State<Escolher> {
//   final itens = [1, 2, 3, 4, 5, 6, 7, 8, 9];
//   String resposta = '';

//   Future<void> esperaResposta(int x, BuildContext context) async {
//     final resultado = await Navigator.push(
//       context,
//       // Create the SelectionScreen in the next step.
//       MaterialPageRoute<String>(builder: (context) => Teste(x)),
//     );

//     if (!context.mounted) return;

//     print('Respondeu: $resultado');
//     setState(() {
//       // Ajuste/resposta para a atividade, ao invés de mostrar o que a essoa respondeu verificar e mostrar se ACERTOU ou ERROU
//       print(x);
//       if (int.tryParse(resultado ?? '0') == x + 3) {
//         // resposta = 'Retorno: ' + (resultado ?? 'nada');
//         resposta = 'ACERTOU';
//       } else {
//         resposta = 'ERROU!';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ...itens.map((e) {
//             return ElevatedButton(
//               child: Text(e.toString()),
//               onPressed: () {
//                 esperaResposta(e, context);
//               },
//             );
//           }),
//           Text(resposta),
//         ],
//       ),
//     );
//   }
// }

// class Teste extends StatefulWidget {
//   Teste(this.x, {super.key});

//   final int x;

//   @override
//   State<Teste> createState() => _TesteState();
// }

// class _TesteState extends State<Teste> {
//   var operacao = '1 + 1';
//   String resultado = '';
//   TextEditingController controlaTexto = TextEditingController();

//   @override
//   void initState() {
//     operacao = '${widget.x} + 3';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Ida')),
//       body: Center(
//         child: Column(
//           children: [
//             Text(operacao),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//                 controller: controlaTexto,
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   resultado = controlaTexto.text;
//                   print('Retornando: $resultado');
//                   Navigator.pop(context, resultado);
//                 },
//                 child: Text('Verificar'))
//           ],
//         ),
//       ),
//     );
//   }
// }

//================================== PARTE V DA AULA (PRÁTICA) ==================================

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         home: DefaultTabController(
//           length: 2,
//           child: Scaffold(
//             appBar: AppBar(
//               bottom: const TabBar(
//                 tabs: [
//                   Tab(
//                     icon: Icon(Icons.plus_one_sharp),
//                     text: ('ADIÇÃO'),
//                   ),
//                   Tab(
//                     icon: Icon(Icons.remove_circle_outline_sharp),
//                     text: ('SUBTRAÇÃO'),
//                   ),
//                 ],
//               ),
//             ),
//             body: const TabBarView(
//               children: [
//                 Soma(),
//                 Subtracao(),
//               ],
//             ),
//           ),
//         ),
//       );
// }

// class Escolher extends StatefulWidget {
//   const Escolher({super.key});

//   @override
//   State<Escolher> createState() => _EscolherState();
// }

// class _EscolherState extends State<Escolher> {
//   final itens = [1, 2, 3, 4, 5, 6, 7, 8, 9];
//   String resposta = '';

//   Future<void> esperaResposta(int x, BuildContext context) async {
//     final resultado = await Navigator.push(
//       context,
//       // Create the SelectionScreen in the next step.
//       MaterialPageRoute<String>(builder: (context) => Soma(x)),
//     );

//     if (!context.mounted) return;

//     print('Respondeu: $resultado');
//     setState(() {
//       // Ajuste/resposta para a atividade, ao invés de mostrar o que a essoa respondeu verificar e mostrar se ACERTOU ou ERROU
//       print(x);
//       if (int.tryParse(resultado ?? '0') == x + 3) {
//         // resposta = 'Retorno: ' + (resultado ?? 'nada');
//         resposta = 'ACERTOU';
//       } else {
//         resposta = 'ERROU!';
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           ...itens.map((e) {
//             return ElevatedButton(
//               child: Text(e.toString()),
//               onPressed: () {
//                 esperaResposta(e, context);
//               },
//             );
//           }),
//           Text(resposta),
//         ],
//       ),
//     );
//   }
// }

// class Soma extends StatefulWidget {
//   Soma({super.key});

//   @override
//   State<Soma> createState() => _SomaState();
// }

// class _SomaState extends State<Soma> {
//   var operacao = '1 + 1';
//   String resultado = '';
//   TextEditingController controlaTexto = TextEditingController();

//   @override
//   void initState() {
//     operacao = '1 + 3';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Ida')),
//       body: Center(
//         child: Column(
//           children: [
//             Text(operacao),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(),
//                 ),
//                 controller: controlaTexto,
//               ),
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   resultado = controlaTexto.text;
//                   print('Retornando: $resultado');
//                   Navigator.pop(context, resultado);
//                 },
//                 child: Text('Verificar'))
//           ],
//         ),
//       ),
//     );
//   }
// }

//================================== PARTE VI DA AULA ==================================

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
  final itens = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  String resposta = '';

  Future<void> esperaResposta(int x, BuildContext context) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute<bool>(builder: (context) => Teste(x)),
    );

    if (!context.mounted) return;

    print('Respondeu: $resultado');

    setState(() {
      // Ajuste/resposta para a atividade, ao invés de mostrar o que a essoa respondeu verificar e mostrar se ACERTOU ou ERROU
      print(x);
      if (resultado ?? false) {
        itens.remove(x); // e mapeado em itens
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ...itens.map((e) {
            return ElevatedButton(
              child: Text(e.toString()),
              onPressed: () {
                esperaResposta(e, context);
              },
            );
          }),
        ],
      ),
    );
  }
}

class Teste extends StatefulWidget {
  Teste(this.x, {super.key});

  final int x;

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
    numeroAleatorio = Random().nextInt(9) + 1;
    operacao = '${widget.x} + $numeroAleatorio';
    esperado = widget.x + numeroAleatorio;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ida')),
      body: Center(
        child: Column(
          children: [
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
                child: Text('Verificar'))
          ],
        ),
      ),
    );
  }
}
