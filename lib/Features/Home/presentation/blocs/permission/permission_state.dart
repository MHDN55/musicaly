// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'permission_bloc.dart';

enum PermissionStatusb {
  initial,
  loading,
  loaded,
  error,
}

class PermissionState extends Equatable {
  final PermissionStatusb status;
  const PermissionState(
    this.status,
  );

  @override
  List<Object> get props => [
        status,
      ];

  PermissionState copyWith({
    PermissionStatusb? status,
    bool? isAllowed,
  }) {
    return PermissionState(
      status ?? this.status,
    );
  }
}
