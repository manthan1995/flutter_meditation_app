import 'package:firebase_auth/firebase_auth.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInApiProvider {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<ApiResponseModel> signInWithApple() async {
    AuthorizationCredentialAppleID credential =
        await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    if (credential.userIdentifier != null) {
      return ApiResponseModel(
        data: credential,
        status: true,
      );
    } else {
      return ApiResponseModel(
        status: false,
      );
    }
  }
}
