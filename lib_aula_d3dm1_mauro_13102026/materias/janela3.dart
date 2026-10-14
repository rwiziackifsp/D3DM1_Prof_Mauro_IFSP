import 'package:flutter/material.dart';

class Janela3 extends StatefulWidget {
  const Janela3({super.key});

  @override
  State<Janela3> createState() => _MyAppState();
}

class _MyAppState extends State<Janela3> {
  TextEditingController controlaNome = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaNome,
                  decoration: InputDecoration(
                    labelText: 'Nome do pet',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(controlaNome.text);
                  },
                  child: Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
