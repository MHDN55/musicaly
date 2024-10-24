// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'panel_bloc.dart';

enum PanelStatus { initial, loaded }

class PanelState extends Equatable {
  final PanelStatus statusPanel;

  final bool isBigSize;

  const PanelState({
    required this.statusPanel,
    required this.isBigSize,
  });

  @override
  List<Object> get props => [
        statusPanel,
        isBigSize,
      ];

  PanelState copyWith({
    PanelStatus? statusPanel,
    bool? isBigSize,
  }) {
    return PanelState(
      statusPanel: statusPanel ?? this.statusPanel,
      isBigSize: isBigSize ?? this.isBigSize,
    );
  }
}
