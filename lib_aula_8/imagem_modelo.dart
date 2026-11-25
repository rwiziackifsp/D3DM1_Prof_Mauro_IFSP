class ImagemModelo {
  final String urlimg;
  bool like = false;

  ImagemModelo({required this.urlimg});

  bool get liked => like;

  void mudaLike() {
    like = !like;
  }
}
