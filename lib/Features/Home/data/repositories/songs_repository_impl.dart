// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/Features/Home/data/datasources/songs_local_data_source.dart';
import 'package:music_app/Features/Home/domain/repositories/songs_repository.dart';
import 'package:music_app/core/error/failures.dart';

@LazySingleton(as: SongsRepository)
class SongsRepositoryImpl implements SongsRepository {
  final SongsLocalDataSource localDataSource;
  SongsRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SongModel>>> getSongs() async {
    try {
      final localSongs = await localDataSource.getSongs();
      return right(localSongs);
    } on DeviceSongsFailure {
      return Left(DeviceSongsFailure());
    } catch (e) {
      print("===============================$e");
      return Left(DeviceSongsFailure());
    }
  }
}
