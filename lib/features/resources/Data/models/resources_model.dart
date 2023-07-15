import '../../Domain/entities/resources.dart';

class ResourceModel extends Resource {
  ResourceModel({
    required int id,
    required int id_lesson,
    required String name,
    required String resource_type,
    required String description,
    required String multimedia,
  }) : super(
            id: id,
            id_lesson: id_lesson,
            name: name,
            resource_type: resource_type,
            description: description,
            multimedia: multimedia);

  factory ResourceModel.fromJson(Map<String, dynamic> json) {
    return ResourceModel(
      id: json['id'],
      id_lesson: json['id_lesson'],
      name: json['name'],
      resource_type: json['resource_type'],
      description: json['description'],
      multimedia: json['multimedia'],
    );
  }

  factory ResourceModel.fromEntity(Resource resource) {
    return ResourceModel(
      id: resource.id,
      id_lesson: resource.id_lesson,
      name: resource.name,
      resource_type: resource.resource_type,
      description: resource.description,
      multimedia: resource.multimedia,
    );
  }
}
