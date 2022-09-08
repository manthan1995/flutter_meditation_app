import 'dart:convert';

import 'package:meditation_app/model/next_song_model.dart';

import '../../constant/api.dart';
import '../../model/user_model.dart';
import 'package:http/http.dart' as http;

class NextSongApiProvider {
  Future<ApiResponseModel<NextSongModel>> nextSongApi() async {
    final res = await http.post(
      Uri.parse("${ApiUrls.baseUrl}${ApiUrls.nextSongUrl}"),
      headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode == 200) {
      return ApiResponseModel<NextSongModel>(
        data: NextSongModel.fromJson(jsonDecode(res.body)),
        status: true,
      );
    } else {
      return ApiResponseModel<NextSongModel>(status: false);
    }
  }
}
