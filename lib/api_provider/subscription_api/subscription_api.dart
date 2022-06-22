import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meditation_app/constant/api.dart';
import 'package:meditation_app/model/user_model.dart';

import '../../model/subscription_model/subscription_model.dart';

class SubscriptionApi {
  Future<ApiResponseModel<SubscriptionModel>> subscriptionApi({
    required int id,
    required int type,
  }) async {
    final postData = {
      "USER_ID": id,
      "SUBCRIPTION_TYPE": type,
    };
    final res = await http.post(
      Uri.parse("${ApiUrls.baseUrl}${ApiUrls.subscriptionUrl}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(postData),
    );

    if (res.statusCode == 200) {
      return ApiResponseModel<SubscriptionModel>(
        data: SubscriptionModel.fromJson(jsonDecode(res.body)),
        status: true,
      );
    } else {
      return ApiResponseModel<SubscriptionModel>(status: false);
    }
  }
}
