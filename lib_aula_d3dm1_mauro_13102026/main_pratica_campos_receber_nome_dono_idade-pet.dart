import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaDono = TextEditingController();
  TextEditingController controlaIdade = TextEditingController();
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
                  controller: controlaIdade,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'NOME DO PET',
                  ),
                ),
              ),
              // TextField(
              //   controller: controlaNome,
              //   decoration: InputDecoration(
              //     labelText: 'Nome do pet',
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    print(controlaNome.text);
                  },
                  child: Text('Salvar')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaIdade,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'IDADE DO PET',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(controlaIdade.text);
                  },
                  child: Text('Salvar')),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controlaDono,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'NOME DO DONO',
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(controlaDono.text);
                  },
                  child: Text('Salvar'))
            ],
          ),
        ),
      ),
    );
  }
}
