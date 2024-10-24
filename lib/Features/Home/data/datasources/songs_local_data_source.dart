import 'package:injectable/injectable.dart';
import 'package:music_app/Features/Home/presentation/pages/home_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

abstract class SongsLocalDataSource {
  Future<List<SongModel>> getSongs();
}

@LazySingleton(as: SongsLocalDataSource)
class SongsLocalDataSourceImlp implements SongsLocalDataSource {
  @override
  Future<List<SongModel>> getSongs() async {
    Future<List<SongModel>> queryMusic = audioQuery.querySongs(
      sortType: SongSortType.DATE_ADDED,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    List<SongModel> musicList = await queryMusic;
    List<SongModel> reversedList = musicList.reversed.toList();
    return reversedList;
  }
}
