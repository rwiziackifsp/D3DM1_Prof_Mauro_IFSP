class Pergunta {
  const Pergunta(this.texto, this.respostas);

  final String texto;
  final List<String> respostas;

  List<String> Embaralha() {
    var copia = List.of(respostas);
    copia.shuffle();
    return copia;
  }
}
