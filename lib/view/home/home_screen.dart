import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/widgtes/navigation.dart';
import 'package:page_transition/page_transition.dart';
import '../../constant/image.dart';
import '../../constant/preferences_key.dart';
import '../../widgtes/cicualer_indicator.dart';
import '../profile_screen/profile_purchase_screen.dart';
import 'music_play_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> prefData;
  String? imageData = '';

  @override
  void initState() {
    var data = preferences.getString(Keys.userReponse);
    prefData = jsonDecode(data!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          showCommanExitDialog(
            context: context,
            content: Strings.exitAppContent,
            title: Strings.exitAppTitle,
            okOnPressed: () => Navigator.pop(context, true),
            cancleOnPressed: () => Navigator.pop(context, false),
          ).then((exit) {
            if (exit == null) return;
            if (exit) {
              SystemNavigator.pop();
            } else {}
          });
          return false;
        },
        child: Stack(
          children: [
            buildBackGroundImage(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.05, 0.2],
                )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                top: MediaQuery.of(context).size.height * 0.1,
                bottom: MediaQuery.of(context).size.height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  headerText(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: buildButton(),
                  ),
                  bottomView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return Align(
      alignment: Alignment.topCenter,
      child: Text(
        Strings.scapeStr,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.04,
          fontWeight: FontWeight.w500,
          color: Colours.whiteColor,
          fontFamily: 'Recoleta-SemiBold',
        ),
      ),
    );
  }

  Widget bottomView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            prefData['meditationData']['TITLE'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colours.whiteColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            prefData['meditationData']['SUBTITLE'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.085,
              fontWeight: FontWeight.bold,
              color: Colours.whiteColor,
              fontFamily: 'Recoleta-SemiBold',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBackGroundImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.black,
          splashFactory: NoSplash.splashFactory,
        ),
        child: FadeInImage.assetNetwork(
          fadeInDuration: const Duration(milliseconds: 600),
          fadeOutDuration: const Duration(milliseconds: 1),
          fit: BoxFit.fill,
          image: prefData['meditationData']['URLS'] +
              prefData['meditationData']['IMAGE'],
          placeholder: 'assets/image/image1.png',
        ),
      ),
    );
  }

  Widget buildButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        prefData['data']['ISSUBCRIBE'] == true
            ? navigationPageTransition(
                context: context,
                screen: MusicHomeScreen(
                  backgroundUrl: prefData['meditationData']['URLS'] +
                      prefData['meditationData']['IMAGE'],
                  audioUrl: prefData['meditationData']['URLS'] +
                      prefData['meditationData']['MUSIC'],
                ),
              )
            : Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  type: PageTransitionType.fade,
                  child: const ProfilePurchaseScreen(),
                ),
              );
      },
      child: Image.asset(
        ConstImages.playImage,
        height: MediaQuery.of(context).size.height * 0.085,
      ),
    );
  }
}
