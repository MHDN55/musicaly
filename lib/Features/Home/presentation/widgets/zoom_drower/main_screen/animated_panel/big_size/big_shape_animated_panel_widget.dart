// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/Features/Home/presentation/blocs/panel/panel_bloc.dart';
import 'package:music_app/core/widgets/neu_box_widget.dart';
import 'package:music_app/injection_injectable_package.dart';

class BigShapeSlidablePanelWidget extends StatelessWidget {
  const BigShapeSlidablePanelWidget({
    super.key,
    required this.currentIndex,
    required this.items,
  });
  final int currentIndex;

  final List<SongModel> items;

  static OnAudioQuery audioQuery = getIt<OnAudioQuery>();

  static AudioPlayer audioPlayer = getIt<AudioPlayer>();

  static PanelBloc panelBloc = getIt<PanelBloc>();

  String formatTime(Duration duration) {
    String towDigitSecounds =
        duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    String formattedTime = "${duration.inMinutes}:$towDigitSecounds";
    return formattedTime;
  }

  void changeToSeconds(int seconds) {
    Duration duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Custom appBar
          Padding(
            padding: EdgeInsets.only(
              left: 15.w,
              right: 15.w,
              bottom: 15.h,
              top: 30.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back arrow icon
                IconButton(
                  onPressed: () {
                    panelBloc
                        .add(const PanelSizeChangingEvent(isBigSize: false));
                  },
                  icon: Icon(Icons.keyboard_arrow_down_rounded, size: 30.w),
                ),
                // Text PLAYLIST
                Text(
                  "P L A Y L I S T",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                // Menu iconButton
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu_rounded),
                ),
              ],
            ),
          ),
          // Song image
          NeuBox(
            height: 250.h,
            width: 270.w,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 18.h, left: 18.w, right: 18.w, bottom: 18.h),
              child: QueryArtworkWidget(
                artworkFit: BoxFit.none,
                artworkQuality: FilterQuality.high,
                artworkBlendMode: BlendMode.hue,
                controller: audioQuery,
                id: items[currentIndex].id,
                type: ArtworkType.AUDIO,
                nullArtworkWidget: Icon(Icons.music_note_rounded, size: 100.h),
              ),
            ),
          ),
          // Song title
          Padding(
            padding: EdgeInsets.only(
                top: 25.h, bottom: 5.h, right: 11.w, left: 11.w),
            child: Center(
              child: Text(
                items[currentIndex].title,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Song artist name
          Padding(
            padding: EdgeInsets.only(bottom: 35.h),
            child: Center(
              child: Text(
                items[0].artist == "<unknown>"
                    ? "No Artist"
                    : items[currentIndex].artist!,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          // Slider
          StreamBuilder<Duration>(
            stream: audioPlayer.positionStream,
            builder: (context, value) {
              final double time;
              if (value.data != null) {
                time = value.data!.inSeconds.toDouble();
              } else {
                time = 0;
              }
              return SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 2,
                  minThumbSeparation: 10,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 9,
                  ),
                ),
                child: SizedBox(
                  height: 15.h,
                  child: Slider(
                    autofocus: true,
                    activeColor: Colors.green,
                    inactiveColor: Theme.of(context).colorScheme.primary,
                    value: time,
                    max: items[currentIndex].duration!.toDouble() / 1000,
                    min: 0,
                    onChanged: (valueChanged) {
                      changeToSeconds(valueChanged.toInt());
                      valueChanged = valueChanged;
                    },
                  ),
                ),
              );
            },
          ),
          // time playing (position and duration)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Time possition
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: StreamBuilder<Duration>(
                  stream: audioPlayer.positionStream,
                  builder: (context, value) {
                    final String formatedPosition;
                    if (value.data != null) {
                      formatedPosition = formatTime(value.data!);
                    } else {
                      formatedPosition = "0:00";
                    }
                    return Text(
                      formatedPosition,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  },
                ),
              ),
              // Time Duration
              Padding(
                padding: EdgeInsets.only(right: 25.w),
                child: StreamBuilder(
                  stream: audioPlayer.durationStream,
                  builder: (context, value) {
                    final String formatedDuration;
                    if (value.data != null) {
                      formatedDuration = formatTime(value.data!);
                    } else {
                      formatedDuration = "0:00";
                    }
                    return Text(
                      formatedDuration,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // Buttons (previous - play_pause - next)
          Padding(
            padding: EdgeInsets.only(top: 25.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Button previous
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    audioPlayer.seekToPrevious();
                  },
                  child: NeuBox(
                    height: 50.h,
                    width: 80.w,
                    child: const Icon(Icons.skip_previous_rounded),
                  ),
                ),
                // Button (play_pause)
                StreamBuilder<bool>(
                  stream: audioPlayer.playingStream,
                  builder: (context, value) {
                    final bool isPlaying;
                    if (value.data == null) {
                      isPlaying = false;
                    } else {
                      isPlaying = value.data!;
                    }
                    return InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        if (value.data == true) {
                          audioPlayer.pause();
                        } else {
                          audioPlayer.play();
                        }
                      },
                      child: NeuBox(
                        height: 50.h,
                        width: 100.w,
                        child: isPlaying
                            ? const Icon(Icons.pause_rounded)
                            : const Icon(Icons.play_arrow_rounded),
                      ),
                    );
                  },
                ),
                // Button next
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    audioPlayer.seekToNext();
                  },
                  child: NeuBox(
                    height: 50.h,
                    width: 80.w,
                    child: const Icon(Icons.skip_next_rounded),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
