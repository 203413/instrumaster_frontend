class UnbordingContent {
  String title;
  String description;
  String description2;
  String description3;
  String image;

  UnbordingContent({
    required this.title,
    required this.description,
    required this.image,
    required this.description2,
    required this.description3,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Elige tu instrumento',
    description: 'Aprende a tocar el ',
    description2: 'instrumento que siempre',
    description3: 'has querido',
    image: 'assets/images/Onboarding_img/OB1.png',
  ),
  UnbordingContent(
    title: 'Aprende a tu ritmo',
    description: 'Cumple tus lecciones al ',
    description2: 'paso que mas se acomode ',
    description3: 'a tus necesidades',
    image: 'assets/images/Onboarding_img/OB2.png',
  ),
  UnbordingContent(
    title: 'Practica tu instrumento',
    description: 'Toca con tu instrumento  ',
    description2: 'diferentes lecciones y',
    description3: 'practicas para mejorar',
    image: 'assets/images/Onboarding_img/OB3.png',
  ),
  UnbordingContent(
    title: 'Diviertete',
    description: 'Aprende tu nueva habilidad ',
    description2: 'de manera intuitiva y ',
    description3: 'entretenida',
    image: 'assets/images/Onboarding_img/PH.png',
  ),
];
