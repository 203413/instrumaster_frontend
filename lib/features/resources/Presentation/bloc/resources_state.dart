part of 'resources_bloc.dart';

@immutable
abstract class ResourceState {}

class LoadingR extends ResourceState {}

class LoadedR extends ResourceState {
  final List<Resource> resources;

  LoadedR({required this.resources});
}

class ErrorR extends ResourceState {
  final String error;

  ErrorR({required this.error});
}
