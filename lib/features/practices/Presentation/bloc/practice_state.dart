part of 'practice_bloc.dart';

@immutable
abstract class PracticeState {}

class InitialStateP extends PracticeState {}

class LoadingP extends PracticeState {}

class LoadedP extends PracticeState {
  final List<Practice> practices;

  LoadedP({required this.practices});
}

class ErrorP extends PracticeState {
  final String error;

  ErrorP({required this.error});
}
