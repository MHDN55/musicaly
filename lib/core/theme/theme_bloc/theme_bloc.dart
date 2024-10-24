import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:music_app/core/theme/app_theme.dart';

import 'package:music_app/core/theme/theme_cache_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

@lazySingleton
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(status: ThemeStatus.initial, themeData: ThemeData())) {
    on<ThemeEvent>((event, emit) async {
      if (event is GetCurrentThemeEvent) {
        final themeIndex = await ThemeCacheHelper().getCachedThemeIndex();
        final theme = AppTheme.values
            .firstWhere((appTheme) => appTheme.index == themeIndex);

        emit(state.copyWith(
            status: ThemeStatus.loaded, themeData: appThemeData[theme]!));
      } else if (event is ThemeChangedEvent) {
        final themeIndex = event.theme.index;
        await ThemeCacheHelper().cacheThemeIndex(themeIndex);
        emit(state.copyWith(
            status: ThemeStatus.loaded, themeData: appThemeData[event.theme]!));
      }
    });
  }
}
