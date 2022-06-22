import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/api_provider/auth/apple_signin_api_provider.dart';
import 'package:meditation_app/api_provider/auth/login_api_provider.dart';
import 'package:meditation_app/api_provider/auth/facebook_signin_api_provider.dart';
import 'package:meditation_app/api_provider/auth/google_signin_api_provider.dart';
import 'package:meditation_app/model/auth/login_model.dart';
import 'package:meditation_app/model/user_model.dart';

class LoginProvider extends ChangeNotifier {
  GoogleLoginApiProvider googleLoginApiProvider = GoogleLoginApiProvider();
  FacebookApiProvider facebookApiProvider = FacebookApiProvider();
  AppleSignInApiProvider appleSignInApiProvider = AppleSignInApiProvider();
  LoginApiProvider loginProvide = LoginApiProvider();

  //email
  Future<ApiResponseModel<LoginModel>> loginProvider({
    required String email,
    required String password,
    required bool isSocial,
  }) async {
    final response = await loginProvide.loginApiProvider(
      email: email,
      password: password,
      isSocial: isSocial,
    );
    notifyListeners();
    return response;
  }

  //social
  Future<ApiResponseModel<LoginModel>> loginSocialProvider({
    required String socialId,
    required bool isSocial,
  }) async {
    final response = await loginProvide.loginSocialAccountApiProvider(
      socialId: socialId,
      isSocial: isSocial,
    );
    notifyListeners();
    return response;
  }

  //Google
  Future<ApiResponseModel<User>> googleSignInProvider() async {
    final ApiResponseModel<User> response =
        await googleLoginApiProvider.signInWithGoogle();
    notifyListeners();
    return response;
  }

//fb
  Future<ApiResponseModel> fbLoginProvider() async {
    ApiResponseModel responseModel = await facebookApiProvider.signInWithFB();
    notifyListeners();
    return responseModel;
  }

  //apple
  Future<ApiResponseModel> appleLoginProvider() async {
    ApiResponseModel responseModel =
        await appleSignInApiProvider.signInWithApple();
    notifyListeners();
    return responseModel;
  }
}
