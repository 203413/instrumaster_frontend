import 'package:instrumaster_v1/features/exercises/Data/datasources/answer_remote_Datasource.dart';
import 'package:instrumaster_v1/features/exercises/Domain/entities/answer.dart';
import '../../Domain/repositories/answer_repository.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerRemoteDataSource answerRemoteDataSource;

  AnswerRepositoryImpl({
    required this.answerRemoteDataSource,
  });

  @override
  Future<List<Answer>> getFourAnswerByExersiceID(String id_exercise) async {
    //print('Repository');
    return await answerRemoteDataSource.getFourAnswerByExersiceID(id_exercise);
  }
}
