import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditation_app/api_provider/auth/apple_signin_api_provider.dart';
import 'package:meditation_app/api_provider/auth/create_account_api_provider.dart';
import 'package:meditation_app/api_provider/auth/google_signin_api_provider.dart';
import 'package:meditation_app/model/auth/create_account_model.dart';
import 'package:meditation_app/model/user_model.dart';

import '../../api_provider/auth/facebook_signin_api_provider.dart';

class CreateAccountProvider extends ChangeNotifier {
  GoogleLoginApiProvider googleLoginApiProvider = GoogleLoginApiProvider();
  FacebookApiProvider facebookApiProvider = FacebookApiProvider();
  AppleSignInApiProvider appleSignInApiProvider = AppleSignInApiProvider();
  CreateAccountApiProvider createAccountApiProvider =
      CreateAccountApiProvider();

  //email
  Future<ApiResponseModel<CreateAccountModel>> createAccountProvider({
    required String userType,
    required String email,
    required String password,
    required String username,
    required bool isSocial,
    required String companyCode,
  }) async {
    final response = await createAccountApiProvider.createAccountApiProvider(
      email: email,
      password: password,
      username: username,
      isSocial: isSocial,
      userType: userType,
      companyCode: companyCode,
    );
    notifyListeners();
    return response;
  }

//social
  Future<ApiResponseModel<CreateAccountModel>> createSocialProvider({
    required String userType,
    required String username,
    required String email,
    required String socialId,
    required String profilePic,
    required bool isSocial,
  }) async {
    final response =
        await createAccountApiProvider.createSocialAccountApiProvider(
      email: email,
      username: username,
      socialId: socialId,
      isSocial: isSocial,
      profilePic: profilePic,
      userType: userType,
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
  Future<ApiResponseModel> applesignUpProvider() async {
    ApiResponseModel responseModel =
        await appleSignInApiProvider.signInWithApple();
    notifyListeners();
    return responseModel;
  }
}
