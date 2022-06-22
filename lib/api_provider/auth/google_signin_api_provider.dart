import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/user_model.dart';

class GoogleLoginApiProvider {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  late GoogleSignInAccount? googleSignInAccount;
  User? user;

  late GoogleSignInAuthentication googleSignInAuthentication;
  Future<ApiResponseModel<User>> signInWithGoogle() async {
    googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      user = userCredential.user;
      return ApiResponseModel<User>(
        status: true,
        data: user,
      );
    } else {
      return ApiResponseModel<User>(
        status: false,
        message: Strings.somethingWentWorngStr,
      );
    }
  }
}
