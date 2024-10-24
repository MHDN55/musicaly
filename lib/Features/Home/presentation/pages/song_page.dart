// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:music_app/Features/Home/presentation/blocs/play_song/play_song_bloc.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// import 'package:music_app/core/widgets/loading_widget.dart';
// import 'package:music_app/core/widgets/neu_box_widget.dart';
// import 'package:music_app/injection_injectable_package.dart';

// class SongPage extends StatefulWidget {
//   const SongPage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SongPage> createState() => _SongPageState();
// }

// class _SongPageState extends State<SongPage> {
//   AudioPlayer audioPlayer = getIt<AudioPlayer>();

//   OnAudioQuery audioQuery = getIt<OnAudioQuery>();


//   PlaySongBloc playSongBloc = getIt<PlaySongBloc>();

//   String formatTime(Duration duration) {
//     String towDigitSecounds =
//         duration.inSeconds.remainder(60).toString().padLeft(2, "0");
//     String formattedTime = "${duration.inMinutes}:$towDigitSecounds";
//     return formattedTime;
//   }

//   void changeToSeconds(int seconds) {
//     Duration duration = Duration(seconds: seconds);
//     audioPlayer.seek(duration);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PlaySongBloc, PlaySongState>(
//       bloc: playSongBloc,
//       builder: (context, state) {
//         if (state.statusSong == PlaySongStatus.loaded) {
//           // Stream for current index
//           return StreamBuilder<int?>(
//             stream: audioPlayer.currentIndexStream,
//             builder: (context, valueIndex) {
//               final int currentIndex;
//               if (valueIndex.data == null) {
//                 currentIndex = state.index;
//               } else {
//                 currentIndex = valueIndex.data!;
//               }
//               return Scaffold(
//                 body: SafeArea(
//                   child: Column(
//                     children: [
//                       // Custom appBar
//                       Padding(
//                         padding: EdgeInsets.all(15.h),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             // Back arrow icon
//                             IconButton(
//                               onPressed: () {
//                                 (context).pop();
//                               },
//                               icon: const Icon(Icons.arrow_back_rounded),
//                             ),
//                             // Text PLAYLIST
//                             Text(
//                               "P L A Y L I S T",
//                               maxLines: 1,
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.w100,
//                               ),
//                             ),
//                             // Menu iconButton
//                             IconButton(
//                               onPressed: () {},
//                               icon: const Icon(Icons.menu_rounded),
//                             ),
//                           ],
//                         ),
//                       ),
//                       // Song image
//                       NeuBox(
//                         height: 250.h,
//                         width: 270.w,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                               top: 18.h, left: 18.w, right: 18.w, bottom: 18.h),
//                           child: QueryArtworkWidget(
//                             controller: audioQuery,
//                             id: state.items[currentIndex].id,
//                             type: ArtworkType.AUDIO,
//                             nullArtworkWidget:
//                                 Icon(Icons.music_note_rounded, size: 100.h),
//                           ),
//                         ),
//                       ),
//                       // Song title
//                       Padding(
//                         padding: EdgeInsets.only(
//                             top: 25.h, bottom: 5.h, right: 11.w, left: 11.w),
//                         child: Center(
//                           child: Text(
//                             state.items[currentIndex].title,
//                             maxLines: 1,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 20.sp,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Song artist name
//                       Padding(
//                         padding: EdgeInsets.only(bottom: 35.h),
//                         child: Center(
//                           child: Text(
//                             state.items[currentIndex].artist == "<unknown>"
//                                 ? "No Artist"
//                                 : state.items[currentIndex].artist!,
//                             maxLines: 1,
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 14.sp,
//                               color: Theme.of(context).colorScheme.primary,
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Slider
//                       StreamBuilder<Duration>(
//                         stream: audioPlayer.positionStream,
//                         builder: (context, value) {
//                           final double time;
//                           if (value.data != null) {
//                             time = value.data!.inSeconds.toDouble();
//                           } else {
//                             time = 0;
//                           }
//                           return SliderTheme(
//                             data: SliderTheme.of(context).copyWith(
//                                 trackHeight: 7,
//                                 minThumbSeparation: 20,
//                                 mouseCursor: const MaterialStatePropertyAll(
//                                     MouseCursor.uncontrolled),
//                                 thumbShape: const RoundSliderThumbShape(
//                                     enabledThumbRadius: 10)),
//                             child: SizedBox(
//                               height: 15.h,
//                               child: Slider(
//                                 activeColor: Colors.green,
//                                 value: time,
//                                 max: state.items[currentIndex].duration!
//                                         .toDouble() /
//                                     1000,
//                                 min: 0,
//                                 onChanged: (valueChanged) {
//                                   changeToSeconds(valueChanged.toInt());
//                                   valueChanged = valueChanged;
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                       // time playing (position and duration)
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           // Time possition
//                           Padding(
//                             padding: EdgeInsets.only(left: 25.w),
//                             child: StreamBuilder<Duration>(
//                               stream: audioPlayer.positionStream,
//                               builder: (context, value) {
//                                 final String formatedPosition;
//                                 if (value.data != null) {
//                                   formatedPosition = formatTime(value.data!);
//                                 } else {
//                                   formatedPosition = "0:00";
//                                 }
//                                 return Text(
//                                   formatedPosition,
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           // Time Duration
//                           Padding(
//                             padding: EdgeInsets.only(right: 25.w),
//                             child: StreamBuilder(
//                               stream: audioPlayer.durationStream,
//                               builder: (context, value) {
//                                 final String formatedDuration;
//                                 if (value.data != null) {
//                                   formatedDuration = formatTime(value.data!);
//                                 } else {
//                                   formatedDuration = "0:00";
//                                 }
//                                 return Text(
//                                   formatedDuration,
//                                   style: TextStyle(
//                                     fontSize: 13.sp,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       // Buttons (previous - play_pause - next)
//                       Padding(
//                         padding: EdgeInsets.only(top: 25.h),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             // Button previous
//                             InkWell(
//                               borderRadius: BorderRadius.circular(8),
//                               onTap: () async {
//                                 audioPlayer.seekToPrevious();

//                                 // if (state.index == 0) {
//                                 //   musicBloc.add(PlaySongEvent(
//                                 //     index: state.items.length - 1,
//                                 //     items: state.items,
//                                 //   ));
//                                 // } else {
//                                 //   musicBloc.add(PlaySongEvent(
//                                 //     index: state.index - 1,
//                                 //     items: state.items,
//                                 //   ));
//                                 // }
//                               },
//                               child: NeuBox(
//                                 height: 50.h,
//                                 width: 80.w,
//                                 child: const Icon(Icons.skip_previous_rounded),
//                               ),
//                             ),
//                             // Button (play_pause)
//                             StreamBuilder<bool>(
//                               stream: audioPlayer.playingStream,
//                               builder: (context, value) {
//                                 final bool isPlaying;
//                                 if (value.data == null) {
//                                   isPlaying = false;
//                                 } else {
//                                   isPlaying = value.data!;
//                                 }
//                                 return InkWell(
//                                   borderRadius: BorderRadius.circular(8),
//                                   onTap: () {
//                                     if (value.data == true) {
//                                       audioPlayer.pause();
//                                     } else {
//                                       audioPlayer.play();
//                                     }
//                                   },
//                                   child: NeuBox(
//                                     height: 50.h,
//                                     width: 100.w,
//                                     child: isPlaying
//                                         ? const Icon(Icons.pause_rounded)
//                                         : const Icon(Icons.play_arrow_rounded),
//                                   ),
//                                 );
//                               },
//                             ),
//                             // Button next
//                             InkWell(
//                               borderRadius: BorderRadius.circular(8),
//                               onTap: () async {
//                                 await audioPlayer.seekToNext();
//                                 // if (state.index == state.items.length - 1) {
//                                 //   musicBloc.add(PlaySongEvent(
//                                 //     index: 0,
//                                 //     items: state.items,
//                                 //   ));
//                                 // } else {

//                                 //   musicBloc.add(PlaySongEvent(
//                                 //     index: state.index + 1,
//                                 //     items: state.items,
//                                 //   ));
//                                 // }
//                               },
//                               child: NeuBox(
//                                 height: 50.h,
//                                 width: 80.w,
//                                 child: const Icon(Icons.skip_next_rounded),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         } else {
//           return const LoadingWidget();
//         }
//       },
//     );
//   }
// }
