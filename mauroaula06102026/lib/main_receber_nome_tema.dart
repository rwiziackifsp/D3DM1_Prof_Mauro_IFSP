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
  String texto = 'Claro';
  bool tema = false;

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
      tema = valor;
      // texto = prefs.getString('y') ?? '';
    });
  }

  void salvar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      texto;
      tema;
    });
    await prefs.setBool('cor', tema);
    await prefs.setString('texto cor', texto);
    print('tema -> salvar: $tema, , Texto: $texto');
  }

  void mudatema(bool valor) async {
    setState(() {
      // texto = 'tema';;
      texto = tema ? "Rosa" : "tema";
      tema = !tema;
      salvar();
      print('tema -> mudartema: $tema, Texto: $texto');
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
                value: tema,
                onChanged: mudatema,
                activeColor: Colors.lightBlue,
                inactiveThumbColor: Colors.pink,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insira seu nome',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Insira seu nome',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
