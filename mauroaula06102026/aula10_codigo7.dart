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
  int x = 0;

  @override
  void initState() {
    super.initState();
    buscaX();
  }

  void buscaX() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      x = prefs.getInt('x') ?? 0;
    });
    print('Mostrando x: $x');
  }

  void salvar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      x = int.parse(controlador.text);
    });

    await prefs.setInt('x', x);

    print('Salvando x:' + controlador.text);
  }

  void apagar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('x');
    setState(() {
      x = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Antes de salvar: $x'),
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
              Row(
                children: [
                  ElevatedButton(onPressed: salvar, child: Text('Salvar')),
                  ElevatedButton(onPressed: apagar, child: Text('Apagar')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
