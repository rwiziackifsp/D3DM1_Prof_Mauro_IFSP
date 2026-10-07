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

  // minha resolução
  void buscaX() async {
    final prefs = await SharedPreferences.getInstance();
    bool valor = await prefs.getBool('cor') ?? false;
    setState(() {
      azul = valor;
      // texto = prefs.getString('y') ?? '';
    });
  }

  void salvar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      texto;
      azul;
    });
    await prefs.setBool('cor', azul);
    await prefs.setString('texto cor', texto);
    print('Azul -> salvar: $azul, , Texto: $texto');
  }

  void mudaAzul(bool valor) async {
    setState(() {
      // texto = 'Azul';;
      texto = azul ? "Rosa" : "Azul";
      azul = !azul;
      salvar();
      print('Azul -> mudarAzul: $azul, Texto: $texto');
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
