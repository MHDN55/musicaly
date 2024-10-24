// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/widgets.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:just_audio/just_audio.dart' as _i8;
import 'package:on_audio_query/on_audio_query.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import 'core/theme/theme_bloc/theme_bloc.dart' as _i4;
import 'Features/Home/data/datasources/songs_local_data_source.dart' as _i10;
import 'Features/Home/data/repositories/songs_repository_impl.dart' as _i12;
import 'Features/Home/domain/repositories/songs_repository.dart' as _i11;
import 'Features/Home/domain/usecases/get_songs_usecase.dart' as _i13;
import 'Features/Home/presentation/blocs/music/music_bloc.dart' as _i14;
import 'Features/Home/presentation/blocs/panel/panel_bloc.dart' as _i5;
import 'Features/Home/presentation/blocs/permission/permission_bloc.dart'
    as _i3;
import 'injection_injectable_package.dart' as _i15;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $init(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.PermissionBloc>(() => _i3.PermissionBloc());
  gh.lazySingleton<_i4.ThemeBloc>(() => _i4.ThemeBloc());
  gh.lazySingleton<_i5.PanelBloc>(() => _i5.PanelBloc());
  gh.lazySingletonAsync<_i6.SharedPreferences>(() => registerModule.prefs1);
  gh.lazySingleton<_i7.OnAudioQuery>(() => registerModule.prefs2);
  gh.lazySingleton<_i8.AudioPlayer>(() => registerModule.prefs3);
  gh.lazySingleton<_i9.PageController>(() => registerModule.pageController);
  gh.lazySingleton<_i10.SongsLocalDataSource>(
      () => _i10.SongsLocalDataSourceImlp());
  gh.lazySingleton<_i11.SongsRepository>(() => _i12.SongsRepositoryImpl(
      localDataSource: gh<_i10.SongsLocalDataSource>()));
  gh.lazySingleton<_i13.GetSongsUseCase>(
      () => _i13.GetSongsUseCase(repository: gh<_i11.SongsRepository>()));
  gh.lazySingleton<_i14.MusicBloc>(
      () => _i14.MusicBloc(songsUseCase: gh<_i13.GetSongsUseCase>()));
  return getIt;
}

class _$RegisterModule extends _i15.RegisterModule {}
