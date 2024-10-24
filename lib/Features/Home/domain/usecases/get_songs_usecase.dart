// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/Features/Home/domain/repositories/songs_repository.dart';
import 'package:music_app/core/error/failures.dart';

@lazySingleton
class GetSongsUseCase {
  SongsRepository repository;
  GetSongsUseCase({
    required this.repository,
  });
  Future<Either<Failure, List<SongModel>>> call() async {
    return await repository.getSongs();
  }
}
