import 'dart:convert';
import 'package:meditation_app/constant/api.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/auth/login_model.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../constant/preferences_key.dart';

class LoginApiProvider {
  //email
  Future<ApiResponseModel<LoginModel>> loginApiProvider({
    required String email,
    required String password,
    required bool isSocial,
  }) async {
    Map bodyData = {
      "EMAIL": email,
      "PASSWORD": password,
      "ISSOCIAL": false,
    };
    var body = json.encode(bodyData);
    final response = await http.post(
      Uri.parse(ApiUrls.baseUrl + ApiUrls.loginUrl),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      final loginBody = LoginModel.fromJson(json.decode(response.body));
      final bodyToMap = loginBody.toJson();
      await preferences.setString(Keys.userReponse, jsonEncode(bodyToMap));
      return ApiResponseModel(
        status: true,
        data: LoginModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ApiResponseModel(
        status: false,
      );
    }
  }

//social
  Future<ApiResponseModel<LoginModel>> loginSocialAccountApiProvider({
    required String socialId,
    required bool isSocial,
  }) async {
    Map bodyData = {
      "SOCIAL_ID": socialId,
      "ISSOCIAL": isSocial,
    };
    var body = json.encode(bodyData);
    final response = await http.post(
        Uri.parse(ApiUrls.baseUrl + ApiUrls.socialLoginUrl),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      final loginBody = LoginModel.fromJson(json.decode(response.body));
      final bodyToMap = loginBody.toJson();
      await preferences.setString(Keys.userReponse, jsonEncode(bodyToMap));
      return ApiResponseModel(
        status: true,
        data: LoginModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ApiResponseModel(
        status: false,
        message: Strings.accountnotExistStr,
      );
    }
  }
}
