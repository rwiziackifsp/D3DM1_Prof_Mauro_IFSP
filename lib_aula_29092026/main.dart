import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Postagem> buscaPostagem(String cep) async {
  final resposta = await http.get(
    Uri.parse('https://viacep.com.br/ws/$cep/json/'),
    headers: {'Accept': 'application/json'},
  );

  if (resposta.statusCode == 200) {
    // status 200 resposta OK
    return Postagem.fromJson(jsonDecode(resposta.body) as Map<String, dynamic>);
  } else {
    // status != 200 é erro!
    throw Exception('Falha ao carregar post.');
  }
}

class Postagem {
  final String logradouro;
  final String bairro;
  final String localidade;
  final String estado;

  const Postagem({
    required this.logradouro,
    required this.bairro,
    required this.localidade,
    required this.estado,
  });

  factory Postagem.fromJson(Map<String, dynamic> json) {
    print('JSON lin 36: $json');
    return switch (json) {
      {
        'logradouro': String logradouro,
        'bairro': String bairro,
        'localidade': String localidade,
        'estado': String estado,
      } =>
        Postagem(
          logradouro: logradouro,
          bairro: bairro,
          localidade: localidade,
          estado: estado,
        ),
      _ => throw const FormatException('Falha no carregamento...'),
    };
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Postagem> postFuturo;

  String rua = '';
  String bairro_ = '';
  String cidade = '';
  String uf = '';

  final controlatexto = TextEditingController();

  String cep_informado = '';

  @override
  void initState() {
    super.initState();
    postFuturo = buscaPostagem(cep_informado);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buscando dados',
      home: Scaffold(
        appBar: AppBar(title: const Text('Buscando dados')),
        body: Center(
            child: Column(
          children: [
            FutureBuilder<Postagem>(
              future: postFuturo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  rua = snapshot.data!.logradouro;
                  bairro_ = snapshot.data!.bairro;
                  cidade = snapshot.data!.localidade;
                  uf = snapshot.data!.estado;
                  return Text(
                      'RUA: $rua \n\nBAIRRO: $bairro_ \n\nCIDADE: $cidade \n\nESTADO: $uf');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return Text('Carregando...');
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controlatexto,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'INFORME O CEP (APENAS OS NÚMEROS)',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cep_informado = controlatexto.text;
                  postFuturo = buscaPostagem(cep_informado);
                  print(controlatexto.text);
                });
              },
              child: Text('BUSCAR CEP'),
            ),
          ],
        )),
      ),
    );
  }
}
