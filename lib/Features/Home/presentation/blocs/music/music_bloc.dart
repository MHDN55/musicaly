import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/Features/Home/domain/usecases/get_songs_usecase.dart';
import 'package:music_app/core/Strings/failures.dart';
import 'package:music_app/core/error/failures.dart';
import 'package:music_app/core/lefted_song_cach_helper/lefted_song_cach_helper.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/injection_injectable_package.dart';

part 'music_event.dart';
part 'music_state.dart';

@lazySingleton
class MusicBloc extends Bloc<MusicEvent, MusicState> {
  OnAudioQuery audioQuery = getIt<OnAudioQuery>();

  AudioPlayer audioPlayer = getIt<AudioPlayer>();

  PageController pageController = getIt<PageController>();

  final GetSongsUseCase songsUseCase;

  MusicBloc({required this.songsUseCase})
      : super(
          const MusicState(
            statusPermition: MusicStatus.initial,
            hasSongs: false,
            status: MusicStatus.initial,
            items: [],
            index: 0,
          ),
        ) {
    final List<AudioSource> listSource = [];

    on<MusicEvent>(
      (event, emit) async {
        if (event is GetSongsEvent) {
          emit(state.copyWith(status: MusicStatus.loading));

          // final permisson = await audioQuery.permissionsStatus();

          final Either<Failure, List<SongModel>> itemsOrNot = await songsUseCase();

          final int index = await LeftedSongCachHelper().getCachedIndex();

          itemsOrNot.fold(
            (failure) => _mapFailureToMessage(failure),
            (items) {
              if (items.isNotEmpty) {
                try {
                  for (var element in items) {
                    listSource.add(
                      AudioSource.uri(
                        Uri.parse(element.uri!),
                        tag: MediaItem(
                          id: element.id.toString(),
                          album: element.album,
                          title: element.title,
                          artUri: Uri.parse('https://example.com/albumart.jpg'),
                        ),
                      ),
                    );
                  }

                  audioPlayer.setAudioSource(
                    ConcatenatingAudioSource(children: listSource),
                    initialIndex: index,
                  );
                } on Exception {
                  log("Error parsing song");
                }
                emit(
                  state.copyWith(
                    status: MusicStatus.loaded,
                    items: items,
                    index: index,
                    hasSongs: true,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DeviceSongsFailure _:
        return DEVICE_SONGS_FAILURE_MESSAGE;

      default:
        return "Unexpected Error , please try again later .";
    }
  }
}
