class UnbordingContent {
  String title;
  String description;
  String image;

  UnbordingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<UnbordingContent> contents = [
  UnbordingContent(
    title: 'Elige tu instrumento',
    description: 'Aprende a tocar el instrumento que siempre has querido ',
    image: 'assets/images/Onboarding_img/OB1.png',
  ),
  UnbordingContent(
    title: 'Aprende a tu ritmo',
    description:
        'Cumple tus lecciones al paso que mas se acomode a tus necesidades',
    image: 'assets/images/Onboarding_img/OB2.png',
  ),
  UnbordingContent(
    title: 'Practica tu instrumento',
    description:
        'Toca con tu instrumento diferentes lecciones y practicas para mejorar',
    image: 'assets/images/Onboarding_img/OB3.png',
  ),
  UnbordingContent(
    title: 'Diviertete',
    description: 'Aprende tu nueva habilidad de manera intuitiva y entretenida',
    image: 'assets/images/Onboarding_img/PH.png',
  ),
];
