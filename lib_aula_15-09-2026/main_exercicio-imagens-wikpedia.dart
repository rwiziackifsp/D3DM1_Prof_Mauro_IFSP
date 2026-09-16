// // main.dart

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../frase_controle.dart';

// void main() {
//   runApp(const Janela());
// }

// class Janela extends StatelessWidget {
//   const Janela({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Scaffold(body: Principal()),
//     );
//   }
// }

// class Principal extends StatefulWidget {
//   const Principal({super.key});

//   @override
//   State<Principal> createState() => _PrincipalState();
// }

// class _PrincipalState extends State<Principal> {
//   FraseControle controle = FraseControle();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         //   Usando Google fonts, ajuste a fonte da frase para Montserrat e do autor para Ms Madi, use o tamanho 28 para o texto e 18 para o autor.

//         Text(
//           controle.fraseAtual.texto,
//           style: GoogleFonts.montserrat(fontSize: 28),
//         ),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               controle.fraseAtual.mudaLike();
//             });
//           },
//           child: Icon(controle.fraseAtual.liked
//               ? Icons.favorite
//               : Icons.favorite_border),
//         ),
//         Text(
//           controle.fraseAtual.autor,
//           style: GoogleFonts.msMadi(fontSize: 22),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             setState(() {
//               controle.proximaFrase();
//             });
//           },
//           child: Text('Próxima'),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             decoration: InputDecoration(
//               border: OutlineInputBorder(),
//               hintText: 'Comente...',
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

// // pubspec.yaml

//   google_fonts: 6.1.0

// // frase_controle.dart

// import '../frase_modelo.dart';

// class FraseControle {
//   final List<FraseModelo> frases = [
//     FraseModelo(texto: 'Penso, logo existo.', autor: 'René Descartes'),
//     FraseModelo(texto: 'Só sei que nada sei.', autor: 'Sócrates'),
//     FraseModelo(
//         texto:
//             'Um pequeno passo para o homem, um salto gigante para a humanidade.',
//         autor: 'Neil Armstrong'),
//   ];

//   int atual = 0;

//   FraseModelo get fraseAtual => frases[atual];

//   void proximaFrase() {
//     if (atual < frases.length - 1) {
//       atual++;
//     } else {
//       atual = 0;
//     }
//   }
// }

// // frase_modelo.dart

// class FraseModelo {
//   final String texto;
//   final String autor;
//   bool like = false;

//   FraseModelo({required this.texto, required this.autor});

//   bool get liked => like;

//   void mudaLike() {
//     like = !like;
//   }
// }
