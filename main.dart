import 'package:flutter/material.dart';

import 'dart:math';

void main() {
  runApp(const NovaApp());
}

class NovaApp extends StatefulWidget {
  const NovaApp({super.key});

  @override
  State<NovaApp> createState() => _NovaAppState();
}

class _NovaAppState extends State<NovaApp> {
  var x = Random().nextInt(5) + 1;
  var mostrar = '';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (x == 1) {
                      mostrar = 'Acertou';
                    } else {
                      mostrar = 'Errou';
                    }
                  });
                },
                child: const Text('1'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (x == 2) {
                      mostrar = 'Acertou';
                    } else {
                      mostrar = 'Errou';
                    }
                  });
                },
                child: const Text('2'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (x == 3) {
                      mostrar = 'Acertou';
                    } else {
                      mostrar = 'Errou';
                    }
                  });
                },
                child: const Text('3'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (x == 4) {
                      mostrar = 'Acertou';
                    } else {
                      mostrar = 'Errou';
                    }
                  });
                },
                child: const Text('4'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (x == 5) {
                      mostrar = 'Acertou';
                    } else {
                      mostrar = 'Errou';
                    }
                  });
                },
                child: const Text('5'),
              ),
              Text(mostrar),
            ],
          ),
        ),
      ),
    );
  }
}
