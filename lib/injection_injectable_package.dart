import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/injection_injectable_package.config.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @lazySingleton
  Future<SharedPreferences> get prefs1 => SharedPreferences.getInstance();

  @lazySingleton
  OnAudioQuery get prefs2 => OnAudioQuery();

  @lazySingleton
  AudioPlayer get prefs3 => AudioPlayer();

  @lazySingleton 
  PageController get pageController  => PageController();
}

@InjectableInit(
  initializerName: r'$init',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => $init(getIt);
