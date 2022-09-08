import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/strings.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import '../../constant/image.dart';
import '../../constant/preferences_key.dart';
import '../../model/next_song_model.dart';
import '../../model/user_model.dart';
import '../../provider/next_song_provider.dart';
import '../../widgtes/cicualer_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, dynamic> prefData;
  String? imageData = '';
  NextSongProvider nextSongProvider = NextSongProvider();
  late ApiResponseModel<NextSongModel> nextSongData;
  //music
  bool isplaying = false;
  bool audioplayed = false;
  late AudioCache audioCache;
  AudioPlayer player = AudioPlayer();
  String next = "";
  String? nextImage;

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
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.asset(ConstImages.bubbleGif,
                            fit: BoxFit.cover,
                            color: const Color.fromRGBO(255, 255, 255, 0.3),
                            colorBlendMode: BlendMode.modulate),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image.asset(
                          ConstImages.textGif,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                  bottomView(),
                  buildButton(),
                  finishButton()
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
            prefData['meditationData']['SUBTITLE'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.085,
              fontWeight: FontWeight.bold,
              color: Colours.whiteColor,
              fontFamily: 'Recoleta-SemiBold',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            prefData['meditationData']['TITLE'],
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colours.whiteColor,
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
        child: nextImage != null
            ? FadeInImage.assetNetwork(
                fadeInDuration: const Duration(milliseconds: 600),
                fadeOutDuration: const Duration(milliseconds: 1),
                fit: BoxFit.fill,
                image: nextImage!,
                placeholder: 'assets/image/image1.png',
              )
            : FadeInImage.assetNetwork(
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
    return CommanMaterialButton(
      buttonWidth: 190,
      buttonText: next == ""
          ? isplaying
              ? "Pause"
              : "Play"
          : next,
      buttonColor: Colours.whiteColor,
      onPressed: () async {
        await HapticFeedback.mediumImpact();
        // prefData['data']['ISSUBCRIBE'] == true
        //     ? navigationPageTransition(
        //         context: context,
        //         screen: MusicHomeScreen(
        //           backgroundUrl: prefData['meditationData']['URLS'] +
        //               prefData['meditationData']['IMAGE'],
        //           audioUrl: prefData['meditationData']['URLS'] +
        //               prefData['meditationData']['MUSIC'],
        //         ),
        //       )
        //     : Navigator.push(
        //         context,
        //         PageTransition(
        //           duration: const Duration(milliseconds: 300),
        //           type: PageTransitionType.fade,
        //           child: const ProfilePurchaseScreen(),
        //         ),
        //       );
        audioCache = AudioCache(fixedPlayer: player);

        if (next == "Next") {
          nextSongData = await nextSongProvider.nextSongProvider();
          print(
              "=================>${nextSongData.data!.data!.uRLS! + nextSongData.data!.data!.mUSIC!}");
          player.play(
            nextSongData.data!.data!.uRLS! + nextSongData.data!.data!.mUSIC!,
          );
          player.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            audioplayed = true;
            isplaying = true;
            nextImage = nextSongData.data!.data!.uRLS! +
                nextSongData.data!.data!.iMAGE!;
          });
          next = "";
        } else if (!audioplayed && !isplaying) {
          player.play(
            prefData['meditationData']['URLS'] +
                prefData['meditationData']['MUSIC'],
          );
          print(
              "===============>${prefData['meditationData']['URLS'] + prefData['meditationData']['MUSIC']}");
          player.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            audioplayed = true;
            isplaying = true;
          });
          player.notificationService.setNotification(
            title: prefData['meditationData']['SUBTITLE'],
            imageUrl: prefData['meditationData']['URLS'] +
                prefData['meditationData']['IMAGE'],
          );
        } else {
          if (audioplayed && !isplaying) {
            await player.resume();
            setState(() {
              isplaying = true;
              audioplayed = true;
            });
          } else {
            await player.pause();
            setState(() {
              isplaying = false;
            });
          }
        }
      },
    );
  }

  Widget finishButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();

        setState(() {
          next = "Next";
          player.stop();
          isplaying = false;
          audioplayed = false;
        });
        player.notificationService.clearNotification();
      },
      child: Text(
        !audioplayed ? "" : Strings.finishButtonTExt,
        style: const TextStyle(
          fontSize: 20,
          color: Colours.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
