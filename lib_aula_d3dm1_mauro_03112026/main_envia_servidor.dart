import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TelaUploadFoto(),
    );
  }
}

class TelaUploadFoto extends StatefulWidget {
  const TelaUploadFoto({super.key});

  @override
  State<TelaUploadFoto> createState() => _TelaUploadFotoState();
}

class _TelaUploadFotoState extends State<TelaUploadFoto> {
  File? _imagemSelecionada;
  bool _enviando = false;
  String _statusMensagem = '';
  String resposta = '';

  // 1. Método para tirar a foto usando a câmera
  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // Comprime um pouco a imagem para otimizar o envio
    );

    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
        _statusMensagem = '';
      });
    }
  }

  // 2. Método para enviar a foto via POST (Multipart)
  Future<void> _enviarParaServidor() async {
    if (_imagemSelecionada == null) return;

    setState(() {
      _enviando = true;
      _statusMensagem = 'Enviando imagem...';
    });

    try {
      // Substitua pela URL da sua API
      var url = Uri.parse('http://10.106.71.21/salva.php');

      var request = http.MultipartRequest('POST', url);

      // Adiciona campos de texto adicionais, se necessário (ex: ID do usuário)
      // request.fields['usuario_id'] = '123';

      // Anexa o arquivo de imagem na requisição
      var multipartFile = await http.MultipartFile.fromPath(
        'foto', // Nome do campo esperado pelo servidor (ex: req.files['foto'])
        _imagemSelecionada!.path,
      );

      request.files.add(multipartFile);

      // Envia a requisição
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _statusMensagem = 'Upload realizado com sucesso!';
          resposta = response.body;
        });
      } else {
        setState(() {
          _statusMensagem = 'Erro no servidor: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMensagem = 'Erro de conexão: $e';
      });
    } finally {
      setState(() {
        _enviando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar Foto por POST')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 200,
                child: Text(resposta),
              ),
              // Exibe a foto tirada ou um espaço reservado
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200],
                ),
                child: _imagemSelecionada != null
                    ? Image.file(_imagemSelecionada!, fit: BoxFit.cover)
                    : const Icon(Icons.camera_alt,
                        size: 80, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _tirarFoto,
                icon: const Icon(Icons.camera),
                label: const Text('Tirar Foto'),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: (_imagemSelecionada != null && !_enviando)
                    ? _enviarParaServidor
                    : null,
                icon: const Icon(Icons.cloud_upload),
                label: _enviando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Enviar para o Servidor'),
              ),
              const SizedBox(height: 20),
              Text(
                _statusMensagem,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
