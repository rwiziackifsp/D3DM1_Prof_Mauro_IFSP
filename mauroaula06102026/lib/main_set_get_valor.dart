import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controlador = TextEditingController();

  int valor = 0;

  @override
  void initState() {
    super.initState();
    buscaValor();
  }

  void buscaValor() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      //para mostra na tela
      valor = prefs.getInt('x') ?? 0;
    });
    // final valor = prefs.getInt('x') ?? 0;
    print('Mostrando valor: $valor');
  }

  void removeValor() async {
    final prefs = await SharedPreferences.getInstance();
    // remove x
    await prefs.remove('x');
    valor = 0;
    setState(() {
      //para mostra na tela
      valor;
    });
  }

  void salvar() async {
    final prefs = await SharedPreferences.getInstance();
    // String texto_digitado = controlador.text;
    // int valor = int.parse(texto_digitado);
    setState(() {
      int.parse(controlador.text);
    });
    await prefs.setInt('x', valor);
    print('Valor salvo:' + controlador.text);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              const Text('Antes de salvar'),
              Text('Valor salvo: $valor'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Digite um número!',
                    border: OutlineInputBorder(),
                  ),
                  controller: controlador,
                ),
              ),
              ElevatedButton(
                onPressed: salvar,
                child: Text('Salvar'),
              ),
              ElevatedButton(
                onPressed: removeValor,
                child: Text('Remover'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
