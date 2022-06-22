import 'dart:convert';
import 'package:meditation_app/constant/api.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:http/http.dart' as http;

import '../../constant/preferences_key.dart';
import '../../model/auth/create_account_model.dart';

class CreateAccountApiProvider {
  //Email

  Future<ApiResponseModel<CreateAccountModel>> createAccountApiProvider({
    required String userType,
    required String username,
    required String email,
    required String password,
    required bool isSocial,
    required String companyCode,
  }) async {
    Map bodyData = companyCode == ''
        ? {
            "TYPE": userType,
            "USER_NAME": username,
            "EMAIL": email,
            "PASSWORD": password,
            "ISSOCIAL": isSocial
          }
        : {
            "TYPE": userType,
            "USER_NAME": username,
            "EMAIL": email,
            "PASSWORD": password,
            "ISSOCIAL": isSocial,
            "COMPANY_CODE": companyCode
          };
    var body = json.encode(bodyData);
    final response = await http.post(
        Uri.parse(ApiUrls.baseUrl + ApiUrls.createAccountUrl),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      final loginBody = CreateAccountModel.fromJson(json.decode(response.body));
      final bodyToMap = loginBody.toJson();
      await preferences.setString(Keys.userReponse, jsonEncode(bodyToMap));
      return ApiResponseModel<CreateAccountModel>(
        status: true,
        data: CreateAccountModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ApiResponseModel<CreateAccountModel>(
        status: false,
        data: CreateAccountModel.fromJson(json.decode(response.body)),
      );
    }
  }

  //social

  Future<ApiResponseModel<CreateAccountModel>> createSocialAccountApiProvider({
    required String userType,
    required String username,
    required String email,
    required String socialId,
    required String profilePic,
    required bool isSocial,
  }) async {
    Map bodyData = {
      "TYPE": userType,
      "USER_NAME": username,
      "EMAIL": email,
      "SOCIAL_ID": socialId,
      "PROFILE_PIC": profilePic,
      "ISSOCIAL": isSocial,
    };
    var body = json.encode(bodyData);
    final response = await http.post(
        Uri.parse(ApiUrls.baseUrl + ApiUrls.createAccountUrl),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (response.statusCode == 200) {
      final loginBody = CreateAccountModel.fromJson(json.decode(response.body));
      final bodyToMap = loginBody.toJson();
      await preferences.setString(Keys.userReponse, jsonEncode(bodyToMap));
      return ApiResponseModel<CreateAccountModel>(
        status: true,
        message: Strings.accountCreateSuccStr,
        data: CreateAccountModel.fromJson(json.decode(response.body)),
      );
    } else {
      return ApiResponseModel<CreateAccountModel>(
        status: false,
        message: Strings.emailAlreadyExistStr,
      );
    }
  }
}
