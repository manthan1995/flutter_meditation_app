import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:page_transition/page_transition.dart';

import '../../bottom_bar.dart';
import '../../constant/preferences_key.dart';
import '../../provider/auth_provider/login_provider.dart';
import '../../provider/streack_provider/streack_provider.dart';

class StreakScreen extends StatefulWidget {
  late String subtitleText;
  late int streakCount;
  late int userID;

  StreakScreen({
    Key? key,
    required this.streakCount,
    required this.subtitleText,
    required this.userID,
  }) : super(key: key);

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  StreackCountProvider streackCountProvider = StreackCountProvider();
  late Map<String, dynamic> prefData;
  LoginProvider loginProvider = LoginProvider();
  @override
  void initState() {
    streackCountProvider.streackCountProvider(userId: widget.userID);
    var data = preferences.getString(Keys.userReponse);
    prefData = jsonDecode(data!);
    loginApiCalling();
    super.initState();
  }

  loginApiCalling() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colours.blackColor,
        body: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            top: MediaQuery.of(context).size.height * 0.07,
            bottom: MediaQuery.of(context).size.height * 0.097,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.07,
                ),
                child: buildCenterText(),
              ),
              buildCompleteButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCenterText() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text(
        //   '${widget.streakCount} day streak',
        //   style: TextStyle(
        //     fontSize: MediaQuery.of(context).size.height * 0.035,
        //     color: Colours.whiteColor,
        //     fontFamily: 'Recoleta-SemiBold',
        //   ),
        // ),
        // const SizedBox(
        //   height: 15,
        // ),
        Text(
          widget.subtitleText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colours.whiteColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'FuturaBookFont',
            letterSpacing: 0.7,
            height: 1.3,
            fontSize: MediaQuery.of(context).size.width * 0.06,
          ),
        ),
      ],
    );
  }

  Widget buildCompleteButton() {
    return CommanMaterialButton(
      buttonWidth: 190,
      buttonText: Strings.completeStr,
      buttonColor: Colours.whiteColor,
      onPressed: () async {
        await HapticFeedback.mediumImpact();

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
            duration: const Duration(milliseconds: 300),
            type: PageTransitionType.fade,
            child: BottomBarscreen(selectBottmTab: 2),
          ),
        );
      },
    );
  }
}
