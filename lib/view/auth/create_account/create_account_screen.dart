import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/image.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:meditation_app/provider/auth_provider/create_account_provider.dart';
import 'package:meditation_app/view/auth/login_screen.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:meditation_app/widgtes/cicualer_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../../constant/preferences_key.dart';
import '../../../model/auth/create_account_model.dart';
import '../../profile_screen/profile_purchase_screen.dart';
import 'create_account_email.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  late Map<String, dynamic> prefData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: buildSignUpForm(),
    );
  }

  Widget buildSignUpForm() {
    return Consumer<CreateAccountProvider>(
      builder: (context, valueOfCreateAccount, child) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.09,
              right: MediaQuery.of(context).size.width * 0.09,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.signUpStr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.04,
                      color: Colours.whiteColor,
                      fontFamily: 'Recoleta-SemiBold'),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                buildSocialLogo(valueOfCreateAccount: valueOfCreateAccount),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                CommanMaterialButton(
                  buttonWidth: 190,
                  buttonText: Strings.emailStr,
                  buttonColor: Colours.whiteColor,
                  onPressed: () async {
                    await HapticFeedback.mediumImpact();
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 400),
                        type: PageTransitionType.fade,
                        child: const CreateAccountEmailScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.05),
            child: buildSignInButton(),
          ),
        ],
      ),
    );
  }

  Widget buildSocialLogo({
    required CreateAccountProvider valueOfCreateAccount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Platform.isAndroid
            ? const SizedBox()
            : buildAppleSignUp(valueOfCreateAccount: valueOfCreateAccount),
        SizedBox(
          width:
              Platform.isAndroid ? 0 : MediaQuery.of(context).size.width * 0.04,
        ),
        buildFbSignUp(
          valueOfCreateAccount: valueOfCreateAccount,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        buildGoogleSignUp(
          valueOfCreateAccount: valueOfCreateAccount,
        ),
      ],
    );
  }

  Widget buildSignInButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          Strings.alreadyHaveAccount,
          style: TextStyle(
            color: Colours.whiteColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () async {
            await HapticFeedback.mediumImpact();
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.fade,
                child: const LoginScreen(),
              ),
            );
          },
          child: const Text(
            Strings.signInStr,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colours.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAppleSignUp({
    required CreateAccountProvider valueOfCreateAccount,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.appleImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();
        ApiResponseModel response =
            await valueOfCreateAccount.applesignUpProvider();

        if (response.status == true) {
          showLoader(context: context);
          final ApiResponseModel<CreateAccountModel> socialAccountRepsonse =
              await valueOfCreateAccount.createSocialProvider(
                  isSocial: true,
                  profilePic: '',
                  userType: 'NORMAL',
                  email: response.data.userIdentifier.toString(),
                  username:
                      'User_${response.data.userIdentifier.substring(response.data.userIdentifier.length - 5)}',
                  socialId: response.data.userIdentifier.toString());

          if (socialAccountRepsonse.data!.status == true) {
            hideLoader(context: context);
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data.userIdentifier);
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.fade,
                // child: const HomeScreen()
                child: const ProfilePurchaseScreen(),
              ),
            );
          } else {
            hideLoader(context: context);
            return showCommanDialog(
              context: context,
              content: socialAccountRepsonse.data!.msg.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          hideLoader(context: context);
        }
      },
    );
  }

  Widget buildFbSignUp({
    required CreateAccountProvider valueOfCreateAccount,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.fbImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();
        showLoader(context: context);
        ApiResponseModel response =
            await valueOfCreateAccount.fbLoginProvider();

        if (response.status == true) {
          final ApiResponseModel<CreateAccountModel> socialAccountRepsonse =
              await valueOfCreateAccount.createSocialProvider(
                  isSocial: true,
                  profilePic: response.data['picture']['data']['url'],
                  userType: 'NORMAL',
                  email: response.data!['email'].toString(),
                  username: response.data!['first_name'].toString(),
                  socialId: response.data!['id'].toString());

          if (socialAccountRepsonse.data!.status == true) {
            hideLoader(context: context);
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data!['id']);
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.fade,
                // child: const HomeScreen()
                child: const ProfilePurchaseScreen(),
              ),
            );
          } else {
            hideLoader(context: context);
            return showCommanDialog(
              context: context,
              content: socialAccountRepsonse.data!.msg.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          hideLoader(context: context);
        }
      },
    );
  }

  Widget buildGoogleSignUp({
    required CreateAccountProvider valueOfCreateAccount,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.googleImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();
        showLoader(context: context);
        ApiResponseModel<User> response =
            await valueOfCreateAccount.googleSignInProvider();
        if (response.data != null) {
          final ApiResponseModel<CreateAccountModel> socialAccountRepsonse =
              await valueOfCreateAccount.createSocialProvider(
                  email: response.data!.email.toString(),
                  isSocial: true,
                  profilePic: response.data!.photoURL.toString(),
                  userType: 'NORMAL',
                  username: response.data!.displayName.toString(),
                  socialId: response.data!.uid.toString());
          if (socialAccountRepsonse.data!.status == true) {
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data!.uid);
            hideLoader(context: context);
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 400),
                type: PageTransitionType.fade,
                // child: const HomeScreen()
                child: const ProfilePurchaseScreen(),
              ),
            );
          } else {
            hideLoader(context: context);
            return showCommanDialog(
              context: context,
              content: socialAccountRepsonse.data!.msg.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          hideLoader(context: context);
        }
      },
    );
  }
}
