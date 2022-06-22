import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import '../../constant/colors.dart';
import '../../constant/image.dart';
import '../../constant/strings.dart';
import '../../widgtes/navigation.dart';
import '../streak_screen/streak_screen.dart';

class MusicHomeScreen extends StatefulWidget {
  String backgroundUrl;
  String audioUrl;

  MusicHomeScreen({required this.backgroundUrl, required this.audioUrl});

  @override
  State<MusicHomeScreen> createState() => _MusicHomeScreenState();
}

class _MusicHomeScreenState extends State<MusicHomeScreen> {
  bool isplaying = false;
  bool audioplayed = false;
  late AudioCache audioCache;
  late Map<String, dynamic> prefData;
  AudioPlayer player = AudioPlayer();
  @override
  void initState() {
    var data = preferences.getString(Keys.userReponse);
    prefData = jsonDecode(data!);
    audioCache = AudioCache(fixedPlayer: player);
    player.play(
      widget.audioUrl,
    );
    audioplayed = true;
    isplaying = true;
    player.notificationService.setNotification(
      title: prefData['meditationData']['SUBTITLE'],
      imageUrl: widget.backgroundUrl,
    );
    player.onPlayerCompletion.listen((event) {
      player.notificationService.clearNotification();
      Navigator.of(context)
          .push(MaterialPageRoute(
              builder: (context) => StreakScreen(
                    streakCount: prefData['data']['STRIKE'],
                    subtitleText: prefData['meditationData']['TEXT'],
                    userID: prefData['data']['USER_ID'],
                  )))
          .then(
            (value) => setState(
              () {
                isplaying = false;
                audioplayed = false;
              },
            ),
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backGroundImage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.1, 0.2],
              )),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.086,
                    ),
                    child: buttonView(),
                  ),
                  finishButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget backGroundImage() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.11,
      width: MediaQuery.of(context).size.width,
      child: FadeInImage.assetNetwork(
        fadeInDuration: const Duration(milliseconds: 700),
        fadeOutDuration: const Duration(milliseconds: 5),
        fit: BoxFit.fill,
        image: widget.backgroundUrl,
        placeholder: 'assets/image/image1.png',
      ),
    );
  }

  Widget buttonView() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
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
      },
      child: Image.asset(
        isplaying ? ConstImages.pauseImage : ConstImages.playImage,
        height: MediaQuery.of(context).size.height * 0.085,
      ),
    );
  }

  Widget finishButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        setState(() {
          player.stop();
          isplaying = false;
          audioplayed = false;
        });
        player.notificationService.clearNotification();
        // player.notificationService.dispose();
        navigationPageTransition(
          context: context,
          screen: StreakScreen(
            streakCount: prefData['data']['STRIKE'],
            subtitleText: prefData['meditationData']['TEXT'],
            userID: prefData['data']['USER_ID'],
          ),
        );
      },
      child: const Text(
        Strings.finishButtonTExt,
        style: TextStyle(
          fontSize: 20,
          color: Colours.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
