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
  String texto = 'Rosa';
  bool azul = false;

  @override
  void initState() {
    super.initState();
    buscaX();
  }

  void buscaX() async {
    final prefs = await SharedPreferences.getInstance();
    bool valor = await prefs.getBool('cor') ?? false;
    setState(() {
      azul = valor;
    });
  }

  void salvar() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('cor', azul);
  }

  void mudaAzul(bool valor) async {
    setState(() {
      azul = !azul;
      texto = azul ? "Azul" : "Rosa";
    });
    salvar();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('Cor: $texto'),
              Switch(
                value: azul,
                onChanged: mudaAzul,
                activeColor: Colors.lightBlue,
                inactiveThumbColor: Colors.pink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
