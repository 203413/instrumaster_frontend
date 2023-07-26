import 'package:bloc/bloc.dart';
import 'package:instrumaster_v1/features/resources/Domain/entities/resources.dart';
import 'package:meta/meta.dart';
import '../../Domain/usecases/get_resourcebylid_usecase.dart';

part 'resources_event.dart';
part 'resources_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final GetResourceByLIdUsecase getResourceByLIdUsecase;

  ResourceBloc({required this.getResourceByLIdUsecase})
      : super(InitialStateR()) {
    on<ResourceEvent>((event, emit) async {
      if (event is GetResourceByLessonID) {
        try {
          emit(LoadingR());
          List<Resource> response =
              await getResourceByLIdUsecase.execute(event.id_lesson);
          emit(LoadedR(resources: response));
        } catch (e) {
          emit(ErrorR(error: e.toString()));
        }
      }
    });
  }
}
