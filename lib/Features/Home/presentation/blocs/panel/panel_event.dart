part of 'panel_bloc.dart';

sealed class PanelEvent extends Equatable {
  const PanelEvent();

  @override
  List<Object> get props => [];
}


class PanelSizeChangingEvent extends PanelEvent {
  final bool isBigSize;
  const PanelSizeChangingEvent({
    required this.isBigSize,
  });
  @override
  List<Object> get props => [isBigSize];
}
