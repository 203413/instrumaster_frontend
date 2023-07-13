import 'package:instrumaster_v1/features/resources/Domain/entities/resources.dart';

import '../../Domain/repositories/resources_repository.dart';
import '../datasources/resources_remote_Datasource.dart';

class ResourceRepositoryImpl implements ResourceRepository {
  final ResourceRemoteDataSource resourceRemoteDataSource;

  ResourceRepositoryImpl({
    required this.resourceRemoteDataSource,
  });

  @override
  Future<List<Resource>> getResourceByLessonID(String id_exercise) async {
    //print('Repository');
    return await resourceRemoteDataSource.getResourceByLessonID(id_exercise);
  }
}
