import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meditation_app/constant/api.dart';
import 'package:meditation_app/model/user_model.dart';

import '../../model/streack_count_model/streack_count_model.dart';

class StreckCoutApiProvider {
  Future<ApiResponseModel<CountStrackModel>> streckCoutApi({
    required int userId,
  }) async {
    final postData = {
      "USER_ID": userId,
    };
    final res = await http.post(
      Uri.parse("${ApiUrls.baseUrl}${ApiUrls.streckCountUrl}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (res.statusCode == 200) {
      return ApiResponseModel<CountStrackModel>(
        data: CountStrackModel.fromJson(jsonDecode(res.body)),
        status: true,
      );
    } else {
      return ApiResponseModel<CountStrackModel>(status: false);
    }
  }
}
