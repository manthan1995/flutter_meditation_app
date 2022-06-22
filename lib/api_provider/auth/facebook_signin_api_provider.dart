import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:http/http.dart' as http;

class FacebookApiProvider {
  FacebookLogin facebookLogin = FacebookLogin();

  Future<ApiResponseModel> signInWithFB() async {
    try {
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      if (facebookLoginResult.status.name == 'success') {
        var userDetails = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken!.token}'));
        var profile = json.decode(userDetails.body);

        return ApiResponseModel(
          status: true,
          data: profile,
        );
      } else {
        return ApiResponseModel(
          status: false,
          message: Strings.somethingWentWorngStr,
        );
      }
    } on FirebaseAuthException {
      return ApiResponseModel<User>(
        status: false,
        message: Strings.somethingWentWorngStr,
      );
    }
  }
}
