import 'package:instrumaster_v1/features/practices/Domain/entities/practice.dart';

class PracticeModel extends Practice {
  PracticeModel({
    required int id,
    required int id_lesson,
    required String acordeATocar,
  }) : super(
          id: id,
          id_lesson: id_lesson,
          acordeATocar: acordeATocar,
        );

  factory PracticeModel.fromJson(Map<String, dynamic> json) {
    return PracticeModel(
      id: json['id'],
      id_lesson: json['id_lesson'],
      acordeATocar: json['acordeATocar'],
    );
  }

  factory PracticeModel.fromEntity(Practice practice) {
    return PracticeModel(
      id: practice.id,
      id_lesson: practice.id_lesson,
      acordeATocar: practice.acordeATocar,
    );
  }
}
