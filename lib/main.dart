import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_app/core/routes/app_route_config.dart';
import 'package:music_app/core/theme/theme_bloc/theme_bloc.dart';
import 'package:music_app/injection_injectable_package.dart';
import 'injection_injectable_package.dart' as di;

Future<void> main() async {
  di.configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeBloc themeBloc = getIt<ThemeBloc>();
  @override
  void initState() {
    themeBloc.add(GetCurrentThemeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        bloc: themeBloc,
        builder: (context, state) {
          if (state.status == ThemeStatus.loaded) {
            return MaterialApp.router(
              theme: state.themeData,
              routerConfig: MyAppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
