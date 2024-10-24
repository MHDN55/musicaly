import 'package:dartz/dartz.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongsRepository {
  Future<Either<Failure,List<SongModel>>> getSongs();
}
