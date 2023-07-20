import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrumaster_v1/features/users/Data/models/profile_model.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/profile.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/progress.dart';
import 'package:instrumaster_v1/features/users/Domain/entities/user.dart';
import 'package:instrumaster_v1/features/users/Domain/usecase/view_profile.dart';

import '../../Domain/usecase/get_progressByUId_usecase.dart';
import '../../Domain/usecase/login_usecase.dart';
import '../../Domain/usecase/register_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ViewProfileUseCase viewProfileUseCase;

  UserBloc({required this.viewProfileUseCase}) : super(InitialState()) {
    on<UserEvent>((event, emit) async {
      if (event is GetByUsername) {
        try {
          emit(LoadingUser());
          ProfileModel response =
              await viewProfileUseCase.execute(event.userId);
          emit(LoadedUser(user: response));
        } catch (e) {
          emit(ErrorUser(error: e.toString()));
        }
      }
    });
  }
}

class UserAuthentication extends Bloc<UserEvent, UserState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  UserAuthentication(
      {required this.loginUseCase, required this.registerUseCase})
      : super(UpdatingUser()) {
    on<UserEvent>((event, emit) async {
      if (event is Login) {
        try {
          emit(UpdatingUser());
          print('estas dentro del bloc');
          var auth = await loginUseCase.execute(event.username, event.password);
          emit(LoginSuccess(auth.token));
        } catch (e) {
          emit(ErrorUser(error: e.toString()));
        }
      } else if (event is Register) {
        try {
          emit(UpdatingUser());
          print('Esta entrand al bloc');
          await registerUseCase.execute(event.user);
          emit(UpdatedUser());
        } catch (e) {
          emit(ErrorUser(error: e.toString()));
        }
      }
    });
  }
}

class ProgressBloc extends Bloc<UserEvent, UserState> {
  final GetProgressByUId getProgressByUId;

  ProgressBloc({required this.getProgressByUId}) : super(LoadingProgress()) {
    on<UserEvent>((event, emit) async {
      if (event is GetProgressByUserID) {
        try {
          List<Progress> response =
              await getProgressByUId.execute(event.userId);
          emit(LoadedProgress(progress: response));
        } catch (e) {
          emit(ErrorProgress(error: e.toString()));
        }
      }
    });
  }
}
