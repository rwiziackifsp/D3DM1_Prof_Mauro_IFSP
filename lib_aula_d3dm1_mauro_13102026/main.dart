import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JanelaCadastro(), // Começa na janela de cadastro
    );
  }
}

// ===============================================================
// JANELA DE CADASTRO E EDIÇÃO
// ===============================================================
class JanelaCadastro extends StatefulWidget {
  final Map<String, dynamic>? petParaEditar;

  const JanelaCadastro({super.key, this.petParaEditar});

  @override
  State<JanelaCadastro> createState() => _JanelaCadastroState();
}

class _JanelaCadastroState extends State<JanelaCadastro> {
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaDono = TextEditingController();
  TextEditingController controlaIdade = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Se recebeu dados, preenche os campos para editar
    if (widget.petParaEditar != null) {
      controlaNome.text = widget.petParaEditar!['nome'] ?? '';
      controlaDono.text = widget.petParaEditar!['dono'] ?? '';
      controlaIdade.text = widget.petParaEditar!['idade'].toString();
    }
  }

  Future<void> salvarNoBanco() async {
    Map<String, dynamic> novoCao = {
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': int.tryParse(controlaIdade.text) ?? 0,
    };

    if (widget.petParaEditar == null) {
      // Salva novo pet
      await DatabaseHelper.inserirCao(novoCao);
      print('${controlaNome.text} salvo com sucesso!');
    } else {
      // Atualiza pet existente
      novoCao['id'] = widget.petParaEditar!['id'];
      await DatabaseHelper.atualizarRegistro(novoCao);
      print('${controlaNome.text} alterado com sucesso!');
    }

    // Limpa os campos após salvar
    controlaNome.clear();
    controlaDono.clear();
    controlaIdade.clear();

    // Se veio da janela de lista (edição), volta para ela
    if (widget.petParaEditar != null && mounted) {
      Navigator.pop(context, true);
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.petParaEditar == null ? 'Cadastrar Pet' : 'Alterar Pet'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controlaNome,
                decoration: const InputDecoration(
                  labelText: 'Nome do pet',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controlaDono,
                decoration: const InputDecoration(
                  labelText: 'Nome do dono',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controlaIdade,
                decoration: const InputDecoration(
                  labelText: 'Idade do pet',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                salvarNoBanco();
              },
              child:
                  Text(widget.petParaEditar == null ? 'Salvar' : 'Atualizar'),
            ),
            const SizedBox(height: 16),
            // Botão para ir ver a lista em outra janela (Requisito 1)
            ElevatedButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const JanelaListagem()),
                );
                setState(() {});
              },
              child: const Text('Ver Pets Cadastrados'),
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// JANELA DE LISTAGEM DOS PETS (Requisito 1)
// ===============================================================
class JanelaListagem extends StatefulWidget {
  const JanelaListagem({super.key});

  @override
  State<JanelaListagem> createState() => _JanelaListagemState();
}

class _JanelaListagemState extends State<JanelaListagem> {
  // Função para apagar o pet (Requisito 2)
  void apagar(int id) async {
    await DatabaseHelper.deletarRegistro(id);
    setState(() {});
  }

  // Função para abrir a janela de alteração (Requisito 3)
  void editar(Map<String, dynamic> pet) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JanelaCadastro(petParaEditar: pet),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pets'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum pet cadastrado.'));
          }

          final listaPets = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              children: listaPets.map((pet) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Pet: ${pet['nome']}'),
                      Text('Dono: ${pet['dono']}'),
                      Text('Idade: ${pet['idade']}'),
                      // Botão Alterar (Requisito 3)
                      ElevatedButton(
                        onPressed: () {
                          editar(pet);
                        },
                        child: const Text('Alterar'),
                      ),
                      // Botão Apagar (Requisito 2)
                      ElevatedButton(
                        onPressed: () {
                          apagar(pet['id']);
                        },
                        child: const Text('Apagar'),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
