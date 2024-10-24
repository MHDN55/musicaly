// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/core/widgets/neu_box_widget.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:vs_scrollbar/vs_scrollbar.dart';

class SongsListWidget extends StatefulWidget {
  const SongsListWidget({
    super.key,
    required this.items,
  });

  final List<SongModel> items;

  @override
  State<SongsListWidget> createState() => _SongsListWidgetState();
}

class _SongsListWidgetState extends State<SongsListWidget> {
  OnAudioQuery audioQuery = getIt<OnAudioQuery>();

  AudioPlayer audioPlayer = getIt<AudioPlayer>();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(right: 5.w),
        child: VsScrollbar(
          controller: controller,
          style: VsScrollbarStyle(
            radius: const Radius.circular(12),
            thickness: 15.w,
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            controller: controller,
            itemCount: widget.items.length,
            itemBuilder: (context, index) {
              //! Song item
              return Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10.w, right: 5.w),
                child: NeuBox(
                  height: 70.h,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      audioPlayer.seek(
                        Duration.zero,
                        index: index,
                      );
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Song Artwork
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 20.w),
                          child: QueryArtworkWidget(
                            artworkFit: BoxFit.none,
                            controller: audioQuery,
                            id: widget.items[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Container(
                              height: 50.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.music_note_rounded),
                            ),
                          ),
                        ),
                        // Text (name - artist)
                        SizedBox(
                          width: 180.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Song name
                              Text(
                                widget.items[index].title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                              ),
                              // Song Artist
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: Text(
                                  widget.items[index].artist == "<unknown>"
                                      ? "No Artist"
                                      : widget.items[index].artist ??
                                          "No Artist",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // three dots icon
                        Padding(
                          padding: EdgeInsets.only(left: 30.w),
                          child: IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {},
                            icon: const Icon(Icons.more_vert),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
