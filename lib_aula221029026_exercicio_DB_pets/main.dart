import 'package:flutter/material.dart';
import 'package:aulad3dm1_22102026/helper.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io';

//===========================================================================================================
// INÍCIO
//===========================================================================================================
void main() {
  //MAIN É O ÍNICIO DE TUDO
  WidgetsFlutterBinding.ensureInitialized(); // DOCUMENTAÇÃO (https://api.flutter.dev/flutter/widgets/WidgetsFlutterBinding/ensureInitialized.html):
  //Você só precisa chamar este método se precisar que o binding seja inicializado antes de chamar runApp

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

//===========================================================================================================
// MY APP SEM ESTADO
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override // BUILDA O CONTEXTO COM MATERIALAPP QUE POS SUA VEZ CHAMA O BOOLEANO FALSE QUE DESATIVA O BANNER EM MODO DEPURAÇÃO
  // DOCUMENTAÇÃO (https://api.flutter.dev/flutter/cupertino/CupertinoApp/debugShowCheckedModeBanner.html):
  //Esse banner tem como objetivo impedir que as pessoas reclamem da lentidão do seu aplicativo quando ele estiver no modo de depuração
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          Escolher(), // CHAMA A "FUNÇÃO ESCOLHER" PARA A MUDANÇA DE TELAS/ABAS
    );
  }
}

//===========================================================================================================
// SEÇÃO DO CÓDIGO PARA "ESCOLHER"
//===========================================================================================================
// CLASSE ESCOLHER QUE É COM MUDANÇA DE ESTADO
class Escolher extends StatefulWidget {
  const Escolher({super.key});

  @override
  State<Escolher> createState() => _EscolherState(); // CHAMA A CRIAÇÃO DE ESTADO
}

//===========================================================================================================
class _EscolherState extends State<Escolher> {
  // CLASSE ONDE DE FATO OCORRERÁ AÇÕES E MUDANÇAS DE TELA DECORRENTE DESSAS AÇÕES
  TextEditingController controlaNome = TextEditingController();
  TextEditingController controlaDono = TextEditingController();
  TextEditingController controlaIdade = TextEditingController();

  Future<void> salvarNoBanco() async {
    // NÃO MUITO ÓBVIO COMO FUNCIONA (?). RECEBE UM OBJETO COM CHAVE/VALOR
    Map<String, dynamic> novoCao = {
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': int.tryParse(controlaIdade.text) ?? 0,
    };

    await DatabaseHelper.inserirCao(
      novoCao,
    ); // A FUNÇÃO QUE MANIPULA O DB PARA INCLUIR UM NOVO REGISTRO
    setState(() {}); //chama o build que por sua vez gera a nova lista (atualizada como novo pet inserido)
  }

  @override //BUILDA O CONTEXTO DO SCAFFOLD QUE POR SUA VEZ CONTÉM A "ESTRUTURA" VISUAL DO APP: TELA CADASTRAR COM OS CAMPOS E BOTÃO DE "SALVAR" E PARA "CADASTRADOS"
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar')),
      body: Column(
        children: [
          Padding(
            // CAMPO PARA NOME DO PET
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaNome,
              decoration: InputDecoration(
                labelText: 'Nome do pet',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            // CAMPO PARA NOME DO DONO
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaDono,
              decoration: InputDecoration(
                labelText: 'Nome do dono',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            // ========= CAMPO PARA IDADE DO PET =========
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controlaIdade,
              decoration: InputDecoration(
                labelText: 'Idade do pet',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            // ========= O BOTÃO "SALVAR" =========
            onPressed: salvarNoBanco,
            child: const Text('Salvar'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            // ========= O BOTÃO PARA EXIBIR OS "CADASTRADOS" =========
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Cadastrados()),
              );
            },
            child: const Text('Cadastrados'),
          ),
        ],
      ),
    );
  }
}

//===========================================================================================================
// SEÇÃO DO CÓDIGO PARA "CADASTRADOS"
//===========================================================================================================
// CADASTRADOS É COM ESTADO, POIS, VAI OBTER DADOS PARA A "MUDANÇA DE ESTADO" PARA EXIBIÇÃO DOS REGISTROS CADASTRADOS
class Cadastrados extends StatefulWidget {
  const Cadastrados({super.key});

  @override
  State<Cadastrados> createState() => _CadastradosState(); // CHAMA A CRIAÇÃO DE ESTADO
}

//===========================================================================================================

class _CadastradosState extends State<Cadastrados> {
  // CLASSE ONDE DE FATO OCORRERÁ AÇÕES E MUDANÇAS DECORRENTE DE AÇÕES SOBRE REGISTROS NO DB
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pets Cadastrados')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.buscarTodos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum cadastro.'));
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
                      // **===== BOTÃO PARA EDITAR O CADASTRO, CHAMANDO ONPRESSED "EditarCadastro"
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarCadastro(pet: pet),
                            ),
                          );
                          setState(() {});
                        },
                        icon: Icon(Icons.edit),
                      ),
                      // **===== BOTÃO PARA DELETAR O CADASTRO, CHAMANDO ONPRESSED "deletarRegistro"
                      IconButton(
                        onPressed: () async {
                          await DatabaseHelper.deletarRegistro(
                            pet['id'],
                          ); // PEGA O ID DO REGISTRO DO PET NO DB
                          setState(() {});
                        },
                        icon: Icon(Icons.delete),
                      ),
                      Text('Pet: ${pet['nome']}'),
                      Text('Dono: ${pet['dono']}'),
                      Text('Idade do pet: ${pet['idade']}'),
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

//===========================================================================================================
// SEÇÃO DO CÓDIGO PARA "EDITAR/ATUALIZAR" REGISTROS CADASTRADOS
//===========================================================================================================
// SIMILAR AO INÍCIO ALI DOS ESTADOS DE ESCOLHER E DE CADASTRAR
class EditarCadastro extends StatefulWidget {
  final Map<String, dynamic> pet;

  const EditarCadastro({super.key, required this.pet});

  @override
  State<EditarCadastro> createState() => _EditarCadastroState();
}

//===========================================================================================================
//CLASSE ONDE OCORRERÁ AS CHAMADAS PARA AS "MUDANÇAS DE ESTADO" RELACIONADAS AO EDITARCADASTRO
class _EditarCadastroState extends State<EditarCadastro> {
  late TextEditingController controlaNome;
  late TextEditingController controlaDono;
  late TextEditingController controlaIdade;

  @override
  void initState() {
    super.initState();
    controlaNome = TextEditingController(text: widget.pet['nome']);
    controlaDono = TextEditingController(text: widget.pet['dono']);
    controlaIdade = TextEditingController(text: widget.pet['idade'].toString());
  }
  //===========================================================================================================

  Future<void> atualizar() async {
    //SIMILAR A FUNÇÃO DE SALVAR NO BANCO REGISTRO, MAS PASSANDO A FUNÇÃO DO HELPER QUE VAI MANIPULAR OS DADOS, OU SEJA, ATUALIZAR ELES
    Map<String, dynamic> dadosAtualizados = {
      'id': widget.pet['id'],
      'nome': controlaNome.text,
      'dono': controlaDono.text,
      'idade': int.tryParse(controlaIdade.text) ?? 0,
    };

    await DatabaseHelper.atualizarRegistro(dadosAtualizados);
  }
  //===========================================================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Pet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controlaNome,
              decoration: const InputDecoration(
                labelText: 'Nome do pet',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controlaDono,
              decoration: const InputDecoration(
                labelText: 'Nome do dono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controlaIdade,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade do pet',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: atualizar,
              child: const Text('Atualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
//=======================================     fim     =============================================
