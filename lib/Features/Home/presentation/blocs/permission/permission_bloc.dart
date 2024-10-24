import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permission_event.dart';
part 'permission_state.dart';

@injectable
class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc()
      : super(const PermissionState(
          PermissionStatusb.initial,
        )) {
    on<PermissionEvent>(
      (event, emit) async {
        if (event is CheckAndRequestPermissionsEvent) {
          emit(state.copyWith(status: PermissionStatusb.loading));

          // final bool perm = await requestPermition();

          final PermissionStatus suatus = await Permission.audio.status;

          if (suatus.isGranted) {
            emit(state.copyWith(
              status: PermissionStatusb.loaded,
            ));
          } else if (suatus.isDenied) {
            PermissionStatus perm = await Permission.audio.request();

            if (perm.isDenied) {
              add(CheckAndRequestPermissionsEvent());
            } else if (perm.isPermanentlyDenied) {
              emit(state.copyWith(
                status: PermissionStatusb.error,
              ));
            } else if (perm.isGranted) {
              emit(state.copyWith(
                status: PermissionStatusb.loaded,
              ));
            }
          } else if (suatus.isPermanentlyDenied) {
            emit(state.copyWith(
              status: PermissionStatusb.error,
            ));
          }
        }
      },
    );
  }
  // Future<bool> requestPermition() async {
  //   PermissionStatus perm = await Permission.audio.request();

  //   if (perm.isDenied == true) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }
}
