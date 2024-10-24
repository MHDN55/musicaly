import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Features/Home/presentation/blocs/music/music_bloc.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtWorkSmallPanelWidget extends StatefulWidget {
  const ArtWorkSmallPanelWidget({
    super.key,
  });

  @override
  State<ArtWorkSmallPanelWidget> createState() => _ArtWorkSmallPanelWidgetState();
}

class _ArtWorkSmallPanelWidgetState extends State<ArtWorkSmallPanelWidget> {
  OnAudioQuery audioQuery = getIt<OnAudioQuery>();

  AudioPlayer audioPlayer = getIt<AudioPlayer>();

  MusicBloc musicBloc = getIt<MusicBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicBloc, MusicState>(
      bloc: musicBloc,
      builder: (context, state) {
        return StreamBuilder<int?>(
            stream: audioPlayer.currentIndexStream,
            builder: (context, valueIndex) {
              final int currentIndex;
              if (valueIndex.data == null) {
                currentIndex = state.index;
              } else {
                currentIndex = valueIndex.data!;
              }
              return QueryArtworkWidget(
                controller: audioQuery,
                id: state.items[currentIndex].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Icon(Icons.music_note_rounded),
                ),
              );
            });
      },
    );
  }
}
