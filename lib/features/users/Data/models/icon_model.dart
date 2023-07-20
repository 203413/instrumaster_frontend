import '../../Domain/entities/icon.dart';

class IconModel extends IconProfile {
  IconModel({
    required int id,
    required String name,
    required String image,
  }) : super(
          id: id,
          name: name,
          image: image,
        );

  factory IconModel.fromJson(Map<String, dynamic> json) {
    return IconModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  factory IconModel.fromEntity(IconProfile user) {
    return IconModel(
      id: user.id,
      name: user.name,
      image: user.image,
    );
  }
}
