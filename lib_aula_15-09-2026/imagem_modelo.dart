class ImagemModelo {
  final String urlimg;
  bool like = false; //booleano false, não passa como parâmetro

  bool get liked => like;

  void mudaLike() {
    like = !like;
  }

  ImagemModelo({required this.urlimg});
}
// TODO Implement this library.