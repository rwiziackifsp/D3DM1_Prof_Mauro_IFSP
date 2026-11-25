import 'package:flutter/material.dart';
import 'imagem_controle.dart';
import 'imagem_modelo.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatefulWidget {
  const MeuApp({super.key});

  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  ImagemControle controle = ImagemControle();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Galeria Wikipedia'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.image), text: 'Todas'),
                Tab(icon: Icon(Icons.check_circle), text: 'Aprovadas'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Aba 1: 4 imagens pequenas
              AbaTodasImagens(
                controle: controle,
                aoAtualizar: () {
                  setState(() {});
                },
              ),
              // Aba 2: Página de resultados (StatelessWidget)
              PaginaAprovadas(listaAprovadas: controle.aprovadas),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// ABA 1: EXIBE AS 4 IMAGENS PEQUENAS COM GESTUREDETECTOR
// =========================================================================
class AbaTodasImagens extends StatelessWidget {
  final ImagemControle controle;
  final VoidCallback aoAtualizar;

  const AbaTodasImagens({
    super.key,
    required this.controle,
    required this.aoAtualizar,
  });

  // Abre a nova janela, envia a imagem e aguarda o retorno do Navigator.pop()
  void abrirPaginaAvaliacao(BuildContext context, ImagemModelo img) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaginaAvaliacao(imagem: img),
      ),
    );

    // Se retornou true ou false da outra tela, atualiza o estado
    if (resultado != null) {
      img.like = resultado;
      aoAtualizar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              quadroImagem(context, controle.imagens[0]),
              const SizedBox(width: 20),
              quadroImagem(context, controle.imagens[1]),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              quadroImagem(context, controle.imagens[2]),
              const SizedBox(width: 20),
              quadroImagem(context, controle.imagens[3]),
            ],
          ),
        ],
      ),
    );
  }

  Widget quadroImagem(BuildContext context, ImagemModelo img) {
    return GestureDetector(
      onTap: () {
        abrirPaginaAvaliacao(context, img);
      },
      child: Column(
        children: [
          Image.network(
            img.urlimg,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
          ),
          Icon(
            img.liked ? Icons.thumb_up : Icons.thumb_down,
            color: img.liked ? Colors.green : Colors.grey,
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// NOVA JANELA: RECEBE DADOS PELO CONSTRUTOR E RETORNA COM NAVIGATOR.POP()
// =========================================================================
class PaginaAvaliacao extends StatefulWidget {
  final ImagemModelo imagem;

  // Construtor recebe os dados por parâmetro
  const PaginaAvaliacao({super.key, required this.imagem});

  @override
  State<PaginaAvaliacao> createState() => _PaginaAvaliacaoState();
}

class _PaginaAvaliacaoState extends State<PaginaAvaliacao> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aprovar ou Reprovar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // State acessa o parâmetro usando "widget."
            Image.network(
              widget.imagem.urlimg,
              width: 250,
              height: 250,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Retorna true (aprovada) para a tela anterior
                    Navigator.pop(context, true);
                  },
                  child: const Text('Aprovar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Retorna false (reprovada) para a tela anterior
                    Navigator.pop(context, false);
                  },
                  child: const Text('Reprovar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// ABA 2 (RESULTADO): STATELESSWIDGET QUE MOSTRA SOMENTE AS APROVADAS
// =========================================================================
class PaginaAprovadas extends StatelessWidget {
  final List<ImagemModelo> listaAprovadas;

  const PaginaAprovadas({super.key, required this.listaAprovadas});

  @override
  Widget build(BuildContext context) {
    if (listaAprovadas.isEmpty) {
      return const Center(
        child: Text('Nenhuma imagem aprovada.'),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < listaAprovadas.length; i++)
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(
                  listaAprovadas[i].urlimg,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
