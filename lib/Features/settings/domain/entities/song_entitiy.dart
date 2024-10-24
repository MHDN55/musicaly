// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Song extends Equatable {
  final String songName;
  final String artistName;
  final String albumArtImagePath;
  final String audioPath;
  const Song({
    required this.songName,
    required this.artistName,
    required this.albumArtImagePath,
    required this.audioPath,
  });

  @override
  List<Object?> get props => [
        songName,
        artistName,
        albumArtImagePath,
        audioPath,
      ];
}
