import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/view/profile_screen/profile_purchase_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant/colors.dart';
import '../../constant/preferences_key.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> prefData;
  @override
  void initState() {
    var data = preferences.getString(Keys.userReponse);

    prefData = jsonDecode(data!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.05),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  top: MediaQuery.of(context).size.height * 0.1,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Text(
                  prefData['data']['USER_NAME'],
                  style: TextStyle(
                    fontFamily: 'Recoleta-SemiBold',
                    fontSize: MediaQuery.of(context).size.width * 0.088,
                    letterSpacing: 0.7,
                    color: Colours.whiteColor,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              buildProgressContainer(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              buildImage(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              prefData['data']['TYPE'] == 'COMPANY'
                  ? const SizedBox()
                  : prefData['data']['SUBCRIPTION_DAYS'] >
                          prefData['TRIAL_DAYS']
                      ? prefData['data']['ISSUBCRIBE'] == false
                          ? buildPlusButton()
                          : const SizedBox()
                      : buildPlusButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProgressContainer() {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colours.backGroundColor,
        borderRadius: BorderRadius.circular(
          MediaQuery.of(context).size.width * 0.05,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildContainerText(
                centerText: '${prefData['data']['STRIKE']}d',
                valueText: 'Current \nstreak',
              ),
              buildContainerText(
                centerText: '${prefData['data']['TOTAL_STRIKE']}d',
                valueText: 'Total \n days',
              ),
              buildContainerText(
                centerText: '${prefData['data']['LONGEST_STRIKE']}d',
                valueText: 'Longest \nstreak',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainerText({
    required String valueText,
    required String centerText,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          centerText,
          style: const TextStyle(
            fontSize: 18,
            color: Colours.whiteColor,
            fontFamily: 'FuturaMediumBT',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          valueText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 17,
              color: Colours.whiteColor.withOpacity(0.4),
              fontFamily: 'FuturaBookFont',
              letterSpacing: 1),
        )
      ],
    );
  }

  Widget buildImage() {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.9,
          width: MediaQuery.of(context).size.width,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.black,
              splashFactory: NoSplash.splashFactory,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width * 0.06,
              ),
              child: FadeInImage.assetNetwork(
                fadeInDuration: const Duration(milliseconds: 600),
                fadeOutDuration: const Duration(milliseconds: 5),
                fit: BoxFit.fill,
                image: prefData['meditationData']['URLS'] +
                    prefData['nextMeditation']['IMAGE'],
                placeholder: 'assets/image/image1.png',
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.025,
            vertical: MediaQuery.of(context).size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tomorrow',
                style: TextStyle(
                  fontFamily: 'FuturaBookFont',
                  fontSize: 15,
                  letterSpacing: 0.7,
                  color: Colours.whiteColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                prefData['nextMeditation']['SUBTITLE'],
                style: TextStyle(
                  fontFamily: 'FuturaBookFont',
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  letterSpacing: 0.4,
                  color: Colours.whiteColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildPlusButton() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.041),
      child: Align(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () async {
            await HapticFeedback.mediumImpact();
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 300),
                type: PageTransitionType.fade,
                child: const ProfilePurchaseScreen(),
              ),
            );
          },
          child: Image.asset(
            'assets/image/add.png',
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ),
      ),
    );
  }
}
