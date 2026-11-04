import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaCameraExemplo(),
    );
  }
}

class TelaCameraExemplo extends StatefulWidget {
  const TelaCameraExemplo({super.key});

  @override
  State<TelaCameraExemplo> createState() => _TelaCameraExemploState();
}

class _TelaCameraExemploState extends State<TelaCameraExemplo> {
  // Variável para armazenar o arquivo da imagem tirada
  File? _imagemSelecionada;
  String tirou = 'Exemplo de Câmera em Flutter';

  // Método para abrir a câmera e capturar a foto
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();

    // Dispara a câmera do dispositivo
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60, // Opcional: reduz a qualidade para otimizar o tamanho
    );

    if (pickedFile != null) {
      setState(() {
        // Atualiza o estado com o caminho do arquivo gerado pela câmera
        _imagemSelecionada = File(pickedFile.path);
        tirou = 'Feito!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tirou),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Área onde a foto será exibida
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200],
                ),
                child: _imagemSelecionada != null
                    ? Image.file(
                        _imagemSelecionada!,
                        fit: BoxFit.cover,
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 60, color: Colors.grey),
                          SizedBox(height: 8),
                          Text('Nenhuma foto tirada ainda'),
                        ],
                      ),
              ),
              const SizedBox(height: 24),
              // Botão para acionar a câmera
              ElevatedButton.icon(
                onPressed: _tirarFoto,
                icon: const Icon(Icons.camera),
                label: const Text('Tirar Foto com a Câmera'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
