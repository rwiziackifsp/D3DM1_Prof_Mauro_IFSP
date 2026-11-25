import 'imagem_modelo.dart';

class ImagemControle {
  final List<ImagemModelo> imagens = [
    ImagemModelo(
        urlimg:
            'https://thumb.wikimedia.org/wikipedia/commons/thumb/c/cb/Francesco_Melzi_-_Portrait_of_Leonardo.png/330px-Francesco_Melzi_-_Portrait_of_Leonardo.png?utm_source=pt.wikipedia.org&utm_campaign=parser&utm_content=thumbnail'),
    ImagemModelo(
        urlimg:
            'https://thumb.wikimedia.org/wikipedia/commons/thumb/b/b4/Mary_Wollstonecraft_Shelley_Rothwell.tif/lossy-page1-330px-Mary_Wollstonecraft_Shelley_Rothwell.tif.jpg?utm_source=pt.wikipedia.org&utm_campaign=parser&utm_content=thumbnail'),
    ImagemModelo(
        urlimg:
            'https://thumb.wikimedia.org/wikipedia/commons/thumb/4/4c/Ada_Lovelace_daguerreotype_by_Antoine_Claudet_1843_-_cropped.png/250px-Ada_Lovelace_daguerreotype_by_Antoine_Claudet_1843_-_cropped.png?utm_source=pt.wikipedia.org&utm_campaign=parser&utm_content=thumbnail'),
    ImagemModelo(
        urlimg:
            'https://thumb.wikimedia.org/wikipedia/commons/thumb/f/fc/Emily_Bront%C3%AB_by_Patrick_Branwell_Bront%C3%AB_restored.jpg/250px-Emily_Bront%C3%AB_by_Patrick_Branwell_Bront%C3%AB_restored.jpg?utm_source=pt.wikipedia.org&utm_campaign=parser&utm_content=thumbnail'),
  ];

  // Retorna apenas as imagens aprovadas
  List<ImagemModelo> get aprovadas {
    List<ImagemModelo> lista = [];
    for (int i = 0; i < imagens.length; i++) {
      if (imagens[i].liked) {
        lista.add(imagens[i]);
      }
    }
    return lista;
  }
}
