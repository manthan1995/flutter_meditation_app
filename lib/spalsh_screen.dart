import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:meditation_app/bottom_bar.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/image.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/provider/auth_provider/login_provider.dart';
import 'package:meditation_app/view/profile_screen/profile_purchase_screen.dart';
import 'package:meditation_app/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Animation<double>? animation;
  late Map<String, dynamic> prefData;

  late AnimationController controller;
  LoginProvider loginProvider = LoginProvider();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward(from: 0);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    Timer(const Duration(seconds: 2), () async {
      var data = preferences.getString(Keys.userReponse);
      if (data != null) {
        prefData = jsonDecode(data);
        if (prefData['data']['ISSOCIAL'] == true) {
          await loginProvider.loginSocialProvider(
            socialId: preferences.getString(Keys.socialID).toString(),
            isSocial: true,
          );
        } else {
          await loginProvider.loginProvider(
            email: prefData['data']['EMAIL'],
            password: preferences.getString(Keys.password).toString(),
            isSocial: false,
          );
        }
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 1000),
            type: PageTransitionType.fade,
            child: prefData['data']['TYPE'] == 'COMPANY'
                ? BottomBarscreen(
                    selectBottmTab: 0,
                  )
                : prefData['data']['ISSUBCRIBE'] == true
                    ? BottomBarscreen(selectBottmTab: 0)
                    : const ProfilePurchaseScreen(),
          ),
        );
      } else {
        Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 1000),
              type: PageTransitionType.fade,
              child: const WelcomeScreen(),
            ));
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: animation!,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                ConstImages.splashScreenImage,
                fit: BoxFit.fill,
              ),
            ),
            Center(
              child: Text(
                Strings.scapeStr,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.08,
                  fontWeight: FontWeight.w500,
                  color: Colours.whiteColor,
                  fontFamily: 'Recoleta-SemiBold',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
