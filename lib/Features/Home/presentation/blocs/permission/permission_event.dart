part of 'permission_bloc.dart';

class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class CheckAndRequestPermissionsEvent extends PermissionEvent {}
