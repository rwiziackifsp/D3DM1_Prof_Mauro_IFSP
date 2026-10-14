import 'package:flutter/material.dart';
import 'package:flutter_application_4/janela2.dart';
import 'package:flutter_application_4/janela3.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Janela2(),
              Janela3(),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}
