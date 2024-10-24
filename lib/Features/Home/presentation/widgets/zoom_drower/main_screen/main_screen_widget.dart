// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:music_app/Features/Home/presentation/blocs/music/music_bloc.dart';
import 'package:music_app/Features/Home/presentation/blocs/panel/panel_bloc.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/custom_app_bar.dart';
import 'package:music_app/Features/Home/presentation/widgets/zoom_drower/main_screen/songs_list_widget.dart';
import 'package:music_app/core/widgets/loading_widget.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'animated_panel/animated_panel_widget.dart';

class MainScreenWidget extends StatefulWidget {
  final ZoomDrawerController? controller;
  const MainScreenWidget({
    super.key,
    required this.controller,
  });

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  MusicBloc musicBloc = getIt<MusicBloc>();

  PanelBloc panelBloc = getIt<PanelBloc>();

  @override
  void initState() {
    musicBloc.add(const GetSongsEvent(sortType: SongSortType.DATE_ADDED));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocBuilder<MusicBloc, MusicState>(
        bloc: musicBloc,
        builder: (context, state) {
          if (state.status == MusicStatus.loaded) {
            if (state.hasSongs == true) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    children: [
                      // custom appBar
                      CustomMainAppBarWidget(
                        controller: widget.controller,
                      ),
                      // Sonrting list
                      // SizedBox(
                      //   height: 50.h,
                      //   child: ListView.builder(
                      //     scrollDirection: Axis.horizontal,
                      //     itemCount: 4,
                      //     itemBuilder: (context, index) {
                      //       return Padding(
                      //         padding: EdgeInsets.only(
                      //             left: 5.w, right: 5.w, bottom: 10.h),
                      //         child: MaterialButton(
                      //           onPressed: () {},
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(12),
                      //           ),
                      //           color: Colors.amber,
                      //           height: 50.h,
                      //           minWidth: 80.w,
                      //           child: Text(
                      //             "Date Added",
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //               fontSize: 12.sp,
                      //               fontWeight: FontWeight.w500,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),
                      // List of device storage Songs
                      SongsListWidget(
                        items: state.items,
                      ),
                    ],
                  ),
                  // Animated panel
                  AnimatedPanelWidget(
                    index: state.index,
                    items: state.items,
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  "No songs in the device\ntry to add a song",
                  textAlign: TextAlign.center,
                ),
              );
            }
          } else if (state.status == MusicStatus.loading) {
            return const LoadingWidget();
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
