import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/animated_panel/small_size/artwork_small_panel_widget.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SmallShapeSlidablePanelWidget extends StatefulWidget {
  const SmallShapeSlidablePanelWidget({
    super.key,
    required this.currentIndex,
    required this.items,
  });

  final int currentIndex;

  final List<SongModel> items;

  @override
  State<SmallShapeSlidablePanelWidget> createState() =>
      _SmallShapeSlidablePanelWidgetState();
}

OnAudioQuery audioQuery = getIt<OnAudioQuery>();

AudioPlayer audioPlayer = getIt<AudioPlayer>();

class _SmallShapeSlidablePanelWidgetState
    extends State<SmallShapeSlidablePanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Song image with a seek slider
        StreamBuilder<Duration>(
          stream: audioPlayer.positionStream,
          builder: (context, value) {
            final double time;
            if (value.data != null) {
              time = value.data!.inSeconds.toDouble();
            } else {
              time = 0;
            }
            return SizedBox(
              height: 55.h,
              width: 55.w,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  animDurationMultiplier: 0.5,
                  customWidths: CustomSliderWidths(
                    handlerSize: 1.w,
                    trackWidth: 3.w,
                    progressBarWidth: 3.w,
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                initialValue: time,
                innerWidget: (percentage) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: const ArtWorkSmallPanelWidget(),
                    ),
                  );
                },
                max: widget.items[widget.currentIndex].duration!.toDouble() /
                    1000,
                min: 0,
              ),
            );
          },
        ),
        // Song (title - artist name)
        SizedBox(
          width: 146.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Song title
              Text(
                widget.items[widget.currentIndex].title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              // Song artist name
              Text(
                widget.items[widget.currentIndex].artist == "<unknown>"
                    ? "No Artist"
                    : widget.items[widget.currentIndex].artist ?? "No Artist",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ),
        // Button previous song
        InkWell(
          onTap: () {
            audioPlayer.seekToPrevious();
          },
          child: SizedBox(
            height: 35.h,
            width: 35.h,
            child: const Icon(Icons.skip_previous_rounded),
          ),
        ),
        // Button (play - pause)
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
              onTap: () {
                if (value.data == true) {
                  audioPlayer.pause();
                } else {
                  audioPlayer.play();
                }
              },
              child: SizedBox(
                height: 35.h,
                width: 35.h,
                child: isPlaying
                    ? const Icon(Icons.pause_rounded)
                    : const Icon(Icons.play_arrow_rounded),
              ),
            );
          },
        ),
        // Button next song
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: InkWell(
            onTap: () {
              audioPlayer.seekToNext();
            },
            child: SizedBox(
              height: 35.h,
              width: 35.h,
              child: const Icon(Icons.skip_next_rounded),
            ),
          ),
        ),
      ],
    );
  }
}
