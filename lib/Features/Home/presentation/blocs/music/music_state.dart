// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'music_bloc.dart';

enum MusicStatus { initial, loaded, loading, error, changedSlider }

class MusicState extends Equatable {
  final MusicStatus status;

  final MusicStatus statusPermition;


  final List<SongModel> items;

  final int index;

  final bool hasSongs;

  const MusicState({
    required this.status,
    required this.statusPermition,
    required this.items,
    required this.index,
    required this.hasSongs,
  });

  @override
  List<Object> get props => [
        status,
        statusPermition,
        items,
        index,
        hasSongs,
      ];

  MusicState copyWith({
    MusicStatus? status,
    MusicStatus? statusPermition,
    List<SongModel>? items,
    int? index,
    bool? hasSongs,
  }) {
    return MusicState(
      status: status ?? this.status,
      statusPermition: statusPermition ?? this.statusPermition,
      items: items ?? this.items,
      index: index ?? this.index,
      hasSongs: hasSongs ?? this.hasSongs,
    );
  }
}
