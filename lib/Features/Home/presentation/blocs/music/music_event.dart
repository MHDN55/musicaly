// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'music_bloc.dart';

class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}


class GetSongsEvent extends MusicEvent {
  final SongSortType sortType;
  const GetSongsEvent({
    required this.sortType,
  });

  @override
  List<Object> get props => [sortType];
}
