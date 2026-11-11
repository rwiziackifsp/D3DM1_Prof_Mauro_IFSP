import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// No XAMPP ao clicar no Admin abre o http://localhost/phpmyadmin/
// START Apache e MySQL]
// Não pode esquecer de IMPORTAR o arquivo 'if0_43338559_site'

const _baseUrl = 'http://10.106.71.13/';

// =================================================================================================================
void main() {
  runApp(const MyApp());
}

// =================================================================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TelaPrincipal(),
    );
  }
}

// =================================================================================================================
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Imagens'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.camera_alt), text: "Enviar Foto"),
              Tab(icon: Icon(Icons.photo_library), text: "Mostrar Fotos"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            AbaEnviarFoto(),
            AbaMostrarFotos(),
          ],
        ),
      ),
    );
  }
}

// ========================================== F   I   M  _TelaPrincipalState =======================================
// =================================================================================================================
class AbaEnviarFoto extends StatefulWidget {
  const AbaEnviarFoto({super.key});

  @override
  State<AbaEnviarFoto> createState() => _AbaEnviarFotoState();
}

class _AbaEnviarFotoState extends State<AbaEnviarFoto> {
  File? _imagemSelecionada;
  bool _enviando = false;

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 60,
    );

    if (pickedFile != null) {
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
      });
    }
  }

  Future<void> _enviarParaServidor() async {
    if (_imagemSelecionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tire uma foto antes de enviar!')),
      );
      return;
    }

    setState(() {
      _enviando = true;
    });

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('${_baseUrl}salva.php'));
      request.files.add(
        await http.MultipartFile.fromPath('foto', _imagemSelecionada!.path),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto enviada com sucesso!')),
        );
        setState(() {
          _imagemSelecionada = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro na conexão com o servidor.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ERRO ENVIO: $e')),
      );
    } finally {
      setState(() {
        _enviando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey[200],
            ),
            child: _imagemSelecionada != null
                ? Image.file(_imagemSelecionada!, fit: BoxFit.cover)
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 50, color: Colors.grey),
                      SizedBox(height: 8),
                      Text('Nenhuma foto capturada'),
                    ],
                  ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _tirarFoto,
            icon: const Icon(Icons.camera),
            label: const Text('Tirar Foto'),
          ),
          const SizedBox(height: 16),
          _enviando
              ? const CircularProgressIndicator()
              : ElevatedButton.icon(
                  onPressed: _enviarParaServidor,
                  icon: const Icon(Icons.cloud_upload),
                  label: const Text('Enviar ao Servidor'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
        ],
      ),
    );
  }
}

// ========================================== F   I   M  _AbaEnviarFotoState =======================================
// =================================================================================================================
class AbaMostrarFotos extends StatefulWidget {
  const AbaMostrarFotos({super.key});

  @override
  State<AbaMostrarFotos> createState() => _AbaMostrarFotosState();
}

class _AbaMostrarFotosState extends State<AbaMostrarFotos> {
  List<dynamic> fotos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    buscaFotos();
  }

  Future<void> buscaFotos() async {
    setState(() {
      _carregando = true;
    });

    try {
      // PEGA O json QUE É CONTEÚDO DA mostra_json.php
      final response = await http.get(Uri.parse('${_baseUrl}mostra_json.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data is List) {
          setState(() {
            fotos = data;
          });
        } else if (data is Map && data.containsKey('erro')) {
          setState(() {
            fotos = [];
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao carregar fotos: $e')),
      );
    } finally {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (fotos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Nenhuma foto encontrada.'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: buscaFotos,
              child: const Text('Atualizar'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: buscaFotos,
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
            itemCount: fotos.length,
            itemBuilder: (context, index) {
              final foto = fotos[index];
              final urlImagem = '$_baseUrl${foto['nome']}';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          urlImagem,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Foto ID: ${foto['id']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
// ========================================== F   I   M  _AbaMostrarFotosState ==========================================================