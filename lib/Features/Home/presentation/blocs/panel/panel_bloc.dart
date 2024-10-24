import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'panel_event.dart';
part 'panel_state.dart';

@lazySingleton
class PanelBloc extends Bloc<PanelEvent, PanelState> {

  PanelBloc()
      : super(
          const PanelState(
            statusPanel: PanelStatus.initial,
            isBigSize: false,
          ),
        ) {
    on<PanelEvent>(
      (event, emit) async {
        if (event is PanelSizeChangingEvent) {
          emit(state.copyWith(
              statusPanel: PanelStatus.loaded, isBigSize: event.isBigSize));
        }
      },
    );
  }
}
