import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      home: TelaUploadFoto(),
    );
  }
}

// 1. Modelo de Dados (Model)
class Postagem {
  final int userId;
  final int id;
  final String title;
  final String body;

  const Postagem({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Postagem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
        'body': String body
      } =>
        Postagem(
          userId: userId,
          id: id,
          title: title,
          body: body,
        ),
      _ => throw const FormatException('Falha no carregamento do JSON.'),
    };
  }
}

// 2. Classe isolada responsável pelas requisições (Service)
class PostagemService {
  final String baseUrl;

  PostagemService({this.baseUrl = 'http://10.106.71.21'});

  /// Busca o caminho da imagem salva no servidor PHP por ID
  Future<String> buscarCaminhoImagemPorId(String id) async {
    final url = '$baseUrl/mostra_json.php?id=$id';
    print('[LOG SERVICE] Iniciando requisição GET para: $url');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Accept': 'application/json'},
    );

    print('[LOG SERVICE] Código HTTP Recebido: ${response.statusCode}');
    print('[LOG SERVICE] Corpo da Resposta Bruto: "${response.body}"');

    if (response.statusCode == 200 && response.body.trim().isNotEmpty) {
      try {
        final dados = jsonDecode(response.body);
        print('[LOG SERVICE] JSON Decodificado: $dados');

        // Trata a resposta se for um Map simples ou uma List contendo um Map
        Map<String, dynamic>? item;

        if (dados is Map<String, dynamic>) {
          item = dados;
        } else if (dados is List &&
            dados.isNotEmpty &&
            dados.first is Map<String, dynamic>) {
          item = dados.first as Map<String, dynamic>;
        }

        if (item != null && item.containsKey('nome')) {
          final nomeArquivo = item['nome'].toString().trim();

          // Ajusta a URL caso o 'nome' venha com pasta (ex: imagens/foto.jpg) ou só o arquivo (ex: foto.jpg)
          final urlCompleta = nomeArquivo.startsWith('http')
              ? nomeArquivo
              : (nomeArquivo.startsWith('imagens/')
                  ? '$baseUrl/$nomeArquivo'
                  : '$baseUrl/imagens/$nomeArquivo');

          print('[LOG SERVICE] URL Completa da Imagem: $urlCompleta');
          return urlCompleta;
        } else {
          print(
              '[LOG SERVICE ALERTA] A chave "nome" não foi encontrada no objeto JSON.');
        }
      } catch (e) {
        print(
            '[LOG SERVICE ERRO] Falha ao decodificar a resposta como JSON: $e');
      }
    } else {
      print(
          '[LOG SERVICE ALERTA] Servidor retornou código ${response.statusCode} ou corpo vazio.');
    }

    throw Exception('Foto não encontrada para o ID $id.');
  }

  /// Envia foto via POST Multipart para salva.php
  Future<String> enviarFoto(File imagem) async {
    final url = '$baseUrl/salva.php';
    print('[LOG SERVICE ENVIO] Iniciando POST Multipart para: $url');
    print('[LOG SERVICE ENVIO] Caminho local do arquivo: ${imagem.path}');

    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    final multipartFile =
        await http.MultipartFile.fromPath('foto', imagem.path);
    request.files.add(multipartFile);

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print('[LOG SERVICE ENVIO] Status HTTP do Envio: ${response.statusCode}');
    print('[LOG SERVICE ENVIO] Resposta do Servidor: "${response.body}"');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Erro no servidor. Status: ${response.statusCode}');
    }
  }
}

// 3. Interface Visual (UI)
class TelaUploadFoto extends StatefulWidget {
  const TelaUploadFoto({super.key});

  @override
  State<TelaUploadFoto> createState() => _TelaUploadFotoState();
}

enum ModoExibicao { local, rede }

class _TelaUploadFotoState extends State<TelaUploadFoto> {
  final PostagemService _service = PostagemService();
  final TextEditingController _idController = TextEditingController();

  File? _imagemSelecionada;
  bool _enviando = false;
  bool _carregandoUrl = false;
  String _statusMensagem = '';
  String _respostaServidor = '';

  ModoExibicao _modoExibicao = ModoExibicao.local;
  String? _urlImagemRemota;

  @override
  void dispose() {
    _idController.dispose();
    super.dispose();
  }

  Future<void> _tirarFoto() async {
    print('[LOG UI] Abrindo câmera para capturar foto...');
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      print('[LOG UI] Foto tirada e salva em: ${pickedFile.path}');
      setState(() {
        _imagemSelecionada = File(pickedFile.path);
        _modoExibicao = ModoExibicao.local;
        _statusMensagem = 'Foto capturada!';
      });
    } else {
      print('[LOG UI] Captura de foto cancelada pelo usuário.');
    }
  }

  Future<void> _enviarParaServidor() async {
    if (_imagemSelecionada == null) return;

    setState(() {
      _enviando = true;
      _statusMensagem = 'Enviando imagem...';
    });

    try {
      final resposta = await _service.enviarFoto(_imagemSelecionada!);
      setState(() {
        _statusMensagem = 'Upload realizado com sucesso!';
        _respostaServidor = resposta;
      });
    } catch (e) {
      print('[LOG UI ERRO] Falha no upload: $e');
      setState(() {
        _statusMensagem = 'Erro de envio: $e';
      });
    } finally {
      setState(() {
        _enviando = false;
      });
    }
  }

  Future<void> _buscarImagemPorId() async {
    final String idText = _idController.text.trim();
    print('[LOG UI] Clique em buscar imagem. ID digitado: "$idText"');

    if (idText.isEmpty) {
      print('[LOG UI ALERTA] ID vazio. Abortando busca.');
      setState(() {
        _statusMensagem = 'Informe um ID válido.';
      });
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _modoExibicao = ModoExibicao.rede;
      _carregandoUrl = true;
      _urlImagemRemota = null;
      _statusMensagem = 'Buscando imagem ID: $idText...';
    });

    try {
      final urlFinal = await _service.buscarCaminhoImagemPorId(idText);
      print('[LOG UI SUCESSO] Definindo URL remota na tela: $urlFinal');
      setState(() {
        _urlImagemRemota = urlFinal;
        _carregandoUrl = false;
        _statusMensagem = 'Exibindo Imagem ID: $idText';
      });
    } catch (e) {
      print('[LOG UI ERRO] Erro ao buscar imagem por ID: $e');
      setState(() {
        _carregandoUrl = false;
        _statusMensagem = 'Erro ao buscar: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enviar e Buscar Foto por ID')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_respostaServidor.isNotEmpty)
                Container(
                  width: 300,
                  constraints: const BoxConstraints(maxHeight: 100),
                  padding: const EdgeInsets.all(8.0),
                  color: Colors.black12,
                  child: SingleChildScrollView(
                    child: Text('Resposta: $_respostaServidor'),
                  ),
                ),
              const SizedBox(height: 10),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey[200],
                ),
                child: _buildConteudoImagem(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Digite o ID da Foto',
                    hintText: 'Ex: 1, 2, 3...',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _buscarImagemPorId,
                    ),
                  ),
                  onSubmitted: (_) => _buscarImagemPorId(),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _buscarImagemPorId,
                icon: const Icon(Icons.image_search),
                label: const Text('Buscar Imagem por ID'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _enviando ? null : _tirarFoto,
                icon: const Icon(Icons.camera),
                label: const Text('Tirar Foto'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: (_imagemSelecionada != null &&
                        !_enviando &&
                        _modoExibicao == ModoExibicao.local)
                    ? _enviarParaServidor
                    : null,
                icon: const Icon(Icons.cloud_upload),
                label: _enviando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text('Enviar para o Servidor'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
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

  Widget _buildConteudoImagem() {
    if (_modoExibicao == ModoExibicao.local) {
      if (_imagemSelecionada != null) {
        return Image.file(_imagemSelecionada!, fit: BoxFit.cover);
      }
      return const Icon(Icons.camera_alt, size: 80, color: Colors.grey);
    } else {
      if (_carregandoUrl) {
        return const Center(child: CircularProgressIndicator());
      }

      if (_urlImagemRemota == null) {
        return const Center(
          child: Text(
            'Não há fotos para exibir.',
            style: TextStyle(
                fontSize: 16, color: Colors.red, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        );
      }

      print(
          '[LOG IMAGE NETWORK] Tentando renderizar imagem na URL: $_urlImagemRemota');

      return Image.network(
        _urlImagemRemota!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          print(
              '[LOG IMAGE NETWORK ERRO] Falha ao carregar a imagem na URL: $_urlImagemRemota');
          print('[LOG IMAGE NETWORK ERRO DETALHES]: $error');
          return const Center(
            child: Text(
              'Erro ao carregar a imagem da URL.',
              style: TextStyle(fontSize: 14, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        },
      );
    }
  }
}
