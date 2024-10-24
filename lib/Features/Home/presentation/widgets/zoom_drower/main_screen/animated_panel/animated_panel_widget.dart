import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/Features/Home/presentation/blocs/panel/panel_bloc.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/animated_panel/big_size/big_shape_animated_panel_widget.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/animated_panel/small_size/small_shape_animated_panel_widget.dart';
import 'package:music_app/core/lefted_song_cach_helper/lefted_song_cach_helper.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AnimatedPanelWidget extends StatefulWidget {
  const AnimatedPanelWidget({
    super.key,
    required this.index,
    required this.items,
  });
  final int index;
  final List<SongModel> items;
  @override
  State<AnimatedPanelWidget> createState() => _AnimatedPanelWidgetState();
}

AudioPlayer audioPlayer = getIt<AudioPlayer>();

PanelBloc panelBloc = getIt<PanelBloc>();

class _AnimatedPanelWidgetState extends State<AnimatedPanelWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PanelBloc, PanelState>(
      bloc: panelBloc,
      builder: (context, stateP) {
        return InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            if (stateP.isBigSize == false) {
              panelBloc.add(
                const PanelSizeChangingEvent(isBigSize: true),
              );
            }
          },
          child: StreamBuilder<int?>(
            stream: audioPlayer.currentIndexStream,
            builder: (context, valueIndex) {
              final int currentIndex;
              if (valueIndex.data == null) {
                currentIndex = widget.index;
              } else {
                currentIndex = valueIndex.data!;
              }
              LeftedSongCachHelper().cachingIndex(currentIndex);
              // animated container
              return AnimatedContainer(
                margin: stateP.isBigSize
                    ? EdgeInsets.zero
                    : EdgeInsets.only(left: 5.w, bottom: 6.h, right: 5.w),
                duration: Durations.medium2,
                curve: Easing.standard,
                height: stateP.isBigSize ? 690.h : 65.h,
                width: 360.w,
                decoration: BoxDecoration(
                  boxShadow: stateP.isBigSize
                      ? []
                      : [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.tertiary,
                            blurRadius: 10,
                            offset: const Offset(4, 4),
                          ),
                        ],
                  borderRadius: stateP.isBigSize
                      ? BorderRadius.circular(0)
                      : BorderRadius.circular(40),
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: stateP.isBigSize
                    ?
                    //! Big Size panel
                    BigShapeSlidablePanelWidget(
                        currentIndex: currentIndex,
                        items: widget.items,
                      )
                    //! Small Size panel
                    : SmallShapeSlidablePanelWidget(
                        currentIndex: currentIndex,
                        items: widget.items,
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
