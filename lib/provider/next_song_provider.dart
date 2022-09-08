import 'package:flutter/material.dart';
import 'package:meditation_app/model/next_song_model.dart';

import '../api_provider/next_song/next_song.dart';
import '../model/user_model.dart';

class NextSongProvider extends ChangeNotifier {
  NextSongApiProvider nextSongApiProvider = NextSongApiProvider();

  Future<ApiResponseModel<NextSongModel>> nextSongProvider() async {
    final ApiResponseModel<NextSongModel> res =
        await nextSongApiProvider.nextSongApi();

    notifyListeners();
    return res;
  }
}
