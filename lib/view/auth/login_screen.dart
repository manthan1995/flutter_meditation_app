import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/api_provider/auth/apple_signin_api_provider.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/image.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/model/auth/login_model.dart';
import 'package:meditation_app/model/user_model.dart';
import 'package:meditation_app/provider/auth_provider/login_provider.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:meditation_app/widgtes/cicualer_indicator.dart';
import 'package:meditation_app/widgtes/textfiled.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../bottom_bar.dart';
import '../profile_screen/profile_purchase_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginProvider loginProvider = LoginProvider();
  late Map<String, dynamic> prefData;
  AppleSignInApiProvider appleSignInApiProvider = AppleSignInApiProvider();

  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.09,
            right: MediaQuery.of(context).size.width * 0.09,
            // bottom: MediaQuery.of(context).size.height * 0.05,
          ),
          child: SingleChildScrollView(
            child: buildLoginForm(),
          ),
        ),
      ),
    );
  }

  Widget buildLoginForm() {
    return Consumer<LoginProvider>(
      builder: (context, valueOfLogin, child) => Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.09,
          ),
          Text(
            Strings.signInStr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.04,
                color: Colours.whiteColor,
                fontFamily: 'Recoleta-SemiBold'),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          buildEmailFiled(),
          const SizedBox(
            height: 20,
          ),
          buildPasswordFiled(),
          const SizedBox(
            height: 10,
          ),
          buildForgotPassword(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
          buildSignInButton(
            loginProvider: loginProvider,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          const Text(
            Strings.orSignInStr,
            style: TextStyle(
              fontSize: 15,
              color: Colours.whiteColor,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          buildSocialLogo(
            loginProvider: loginProvider,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.07,
          ),
          buildSignUpButton()
        ],
      ),
    );
  }

  Widget buildEmailFiled() {
    return CommanTextFiled(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      hintText: Strings.emailStr,
    );
  }

  Widget buildPasswordFiled() {
    return CommanTextFiled(
      controller: passwordController,
      hintText: Strings.passwordStr,
      obscureText: true,
    );
  }

  Widget buildSignInButton({
    required LoginProvider loginProvider,
  }) {
    return CommanMaterialButton(
      buttonText: Strings.signInStr,
      buttonColor: Colours.whiteColor,
      onPressed: () async {
        await HapticFeedback.mediumImpact();
        if (emailController.text != '' && passwordController.text != '') {
          showLoader(context: context);
          final ApiResponseModel<LoginModel> loginResponse =
              await loginProvider.loginProvider(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            isSocial: false,
          );

          if (loginResponse.data!.status == true) {
            hideLoader(context: context);

            preferences.setString(
                Keys.userId, loginResponse.data!.data!.uSERID.toString());
            var data = preferences.getString(Keys.userReponse);
            if (data != null) {
              prefData = jsonDecode(data);
              preferences.setString(
                  Keys.password, passwordController.text.trim());
              hideLoader(context: context);
              Navigator.push(
                context,
                PageTransition(
                    duration: const Duration(milliseconds: 400),
                    type: PageTransitionType.fade,
                    child: prefData['data']['TYPE'] == 'COMPANY'
                        ? BottomBarscreen(selectBottmTab: 0)
                        : prefData['data']['ISSUBCRIBE'] == true
                            ? BottomBarscreen(selectBottmTab: 0)
                            : const ProfilePurchaseScreen()
                    // child: prefData['data']['TYPE'] == 'COMPANY'
                    //     ? const HomeScreen()
                    //     : prefData['data']['SUBCRIPTION_DAYS'] >=
                    //             prefData['TRIAL_DAYS']
                    //         ? prefData['data']['ISSUBCRIBE'] == true
                    //             ? const HomeScreen()
                    //             : const PurchaseScreen()
                    //         : const PurchaseScreen(),
                    ),
              );
            }
          } else {
            hideLoader(context: context);
            return showCommanDialog(
              context: context,
              content: loginResponse.data!.msg.toString(),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        } else {
          hideLoader(context: context);
          return showCommanDialog(
            context: context,
            content: 'Please enter valid input',
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        }
      },
    );
  }

  Widget buildForgotPassword() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 400),
            type: PageTransitionType.fade,
            child: const ForgotPasswordScreen(),
          ),
        );
      },
      child: const Align(
        alignment: Alignment.centerRight,
        child: Text(
          Strings.forgotPasswordStr,
          style: TextStyle(
            fontWeight: FontWeight.w200,
            color: Colours.whiteColor,
          ),
        ),
      ),
    );
  }

  Widget buildSocialLogo({
    required LoginProvider loginProvider,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Platform.isAndroid
            ? Container()
            : buildAppleLogin(loginProvider: loginProvider),
        SizedBox(
          width:
              Platform.isAndroid ? 0 : MediaQuery.of(context).size.width * 0.07,
        ),
        buildFBLogin(loginProvider: loginProvider),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
        ),
        buildGoogleLogin(loginProvider: loginProvider),
      ],
    );
  }

  Widget buildAppleLogin({
    required LoginProvider loginProvider,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.appleImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();

        ApiResponseModel response = await loginProvider.appleLoginProvider();
        if (response.data != null) {
          showLoader(context: context);
          final ApiResponseModel<LoginModel> socialAccountRepsonse =
              await loginProvider.loginSocialProvider(
            socialId: response.data.userIdentifier.toString(),
            isSocial: true,
          );
          if (socialAccountRepsonse.data!.status == true) {
            hideLoader(context: context);
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data.userIdentifier);
            var data = preferences.getString(Keys.userReponse);
            if (data != null) {
              prefData = jsonDecode(data);
              Navigator.push(
                context,
                PageTransition(
                    duration: const Duration(milliseconds: 400),
                    type: PageTransitionType.fade,
                    child: prefData['data']['ISSUBCRIBE'] == true
                        ? BottomBarscreen(selectBottmTab: 0)
                        : const ProfilePurchaseScreen()
                    // child: prefData['data']['TYPE'] == 'COMPANY'
                    //     ? const HomeScreen()
                    //     : prefData['data']['SUBCRIPTION_DAYS'] >=
                    //             prefData['TRIAL_DAYS']
                    //         ? prefData['data']['ISSUBCRIBE'] == true
                    //             ? const HomeScreen()
                    //             : const PurchaseScreen()
                    //         : const PurchaseScreen(),
                    ),
              );
            }
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

  Widget buildFBLogin({
    required LoginProvider loginProvider,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.fbImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();
        showLoader(context: context);
        ApiResponseModel response = await loginProvider.fbLoginProvider();
        if (response.status == true) {
          final ApiResponseModel<LoginModel> socialAccountRepsonse =
              await loginProvider.loginSocialProvider(
            socialId: response.data!['id'].toString(),
            isSocial: true,
          );

          if (socialAccountRepsonse.data!.status == true) {
            hideLoader(context: context);
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data!['id']);
            var data = preferences.getString(Keys.userReponse);
            if (data != null) {
              prefData = jsonDecode(data);
              Navigator.push(
                context,
                PageTransition(
                    duration: const Duration(milliseconds: 400),
                    type: PageTransitionType.fade,
                    child: prefData['data']['ISSUBCRIBE'] == true
                        ? BottomBarscreen(selectBottmTab: 0)
                        : const ProfilePurchaseScreen()
                    // child: prefData['data']['TYPE'] == 'COMPANY'
                    //     ? const HomeScreen()
                    //     : prefData['data']['SUBCRIPTION_DAYS'] >=
                    //             prefData['TRIAL_DAYS']
                    //         ? prefData['data']['ISSUBCRIBE'] == true
                    //             ? const HomeScreen()
                    //             : const PurchaseScreen()
                    //         : const PurchaseScreen(),
                    ),
              );
            }
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

  Widget buildGoogleLogin({
    required LoginProvider loginProvider,
  }) {
    return DesignSocialLogo(
      logoImage: ConstImages.googleImage,
      onTap: () async {
        await HapticFeedback.mediumImpact();
        showLoader(context: context);
        ApiResponseModel<User> response =
            await loginProvider.googleSignInProvider();
        if (response.data != null) {
          final ApiResponseModel<LoginModel> socialAccountRepsonse =
              await loginProvider.loginSocialProvider(
            socialId: response.data!.uid.toString(),
            isSocial: true,
          );
          if (socialAccountRepsonse.data!.status == true) {
            hideLoader(context: context);
            preferences.setString(Keys.userId,
                socialAccountRepsonse.data!.data!.uSERID.toString());
            preferences.setString(Keys.socialID, response.data!.uid);
            var data = preferences.getString(Keys.userReponse);
            if (data != null) {
              prefData = jsonDecode(data);
              Navigator.push(
                context,
                PageTransition(
                    duration: const Duration(milliseconds: 400),
                    type: PageTransitionType.fade,
                    child: prefData['data']['ISSUBCRIBE'] == true
                        ? BottomBarscreen(selectBottmTab: 0)
                        : const ProfilePurchaseScreen()
                    // child: prefData['data']['TYPE'] == 'COMPANY'
                    //     ? const HomeScreen()
                    //     : prefData['data']['SUBCRIPTION_DAYS'] >=
                    //             prefData['TRIAL_DAYS']
                    //         ? prefData['data']['ISSUBCRIBE'] == true
                    //             ? const HomeScreen()
                    //             : const PurchaseScreen()
                    //         : const PurchaseScreen(),
                    ),
              );
            }
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

  Widget buildSignUpButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          Strings.dontHaveAccountStr,
          style: TextStyle(
            color: Colours.whiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
          onTap: () async {
            await HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
          child: const Text(
            Strings.signUpStr,
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colours.whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
