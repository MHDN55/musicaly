import 'package:shared_preferences/shared_preferences.dart';

class LeftedSongCachHelper {
  Future cachingIndex(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("index",index);
  }

  Future<int> getCachedIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? index = prefs.getInt("index");
    return index ?? 0;
  }
}
