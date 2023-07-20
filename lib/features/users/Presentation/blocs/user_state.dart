part of 'user_bloc.dart';

abstract class UserState {}

class InitialState extends UserState {}

class LoadingUser extends UserState {}

class LoadedUser extends UserState {
  final ProfileModel user;

  LoadedUser({required this.user});
}

class ErrorUser extends UserState {
  final String error;

  ErrorUser({required this.error});
}

class UpdatingUser extends UserState {}

class UpdatedUser extends UserState {}

class LoginSuccess extends UserState {
  final String token;

  LoginSuccess(this.token);
}

class LoadingProgress extends UserState {}

class LoadedProgress extends UserState {
  final List<Progress> progress;

  LoadedProgress({required this.progress});
}

class ErrorProgress extends UserState {
  final String error;

  ErrorProgress({required this.error});
}
