import 'dart:async';
import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant/colors.dart';
import '../../constant/image.dart';
import '../../constant/preferences_key.dart';
import '../../constant/strings.dart';
import '../../provider/auth_provider/login_provider.dart';
import '../streak_screen/streak_screen.dart';

class MyHomePage extends StatefulWidget {
  int timerValue;
  String? music;
  MyHomePage({required this.timerValue, this.music});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late Map<String, dynamic> prefData;
  bool isRunning = false;
  late AudioPlayer audioPlayer;
  late AudioCache audioCache;
  late Timer timer;
  // final service = FlutterBackgroundService();

  // Future<void> _initForegroundTask() async {
  //   await FlutterForegroundTask.init(
  //     androidNotificationOptions: AndroidNotificationOptions(
  //       channelId: 'notification_channel_id',
  //       channelName: 'Foreground Notification',
  //       channelDescription:
  //           'This notification appears when the foreground service is running.',
  //       channelImportance: NotificationChannelImportance.LOW,
  //       priority: NotificationPriority.LOW,
  //       iconData: const NotificationIconData(
  //         resType: ResourceType.mipmap,
  //         resPrefix: ResourcePrefix.ic,
  //         name: 'launcher',
  //       ),
  //       buttons: [
  //         const NotificationButton(id: 'sendButton', text: 'Send'),
  //         const NotificationButton(id: 'testButton', text: 'Test'),
  //       ],
  //     ),
  //     iosNotificationOptions: const IOSNotificationOptions(
  //       showNotification: true,
  //       playSound: false,
  //     ),
  //     foregroundTaskOptions: const ForegroundTaskOptions(
  //       interval: 5000,
  //       autoRunOnBoot: true,
  //       allowWifiLock: true,
  //     ),
  //     printDevLog: true,
  //   );
  // }

  @override
  void dispose() {
    // timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // _initForegroundTask();
    var data = preferences.getString(Keys.userReponse);

    prefData = jsonDecode(data!);

// here is music code
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.timerValue * 60),
    );
    audioPlayer.play(widget.music!);
    controller.forward().whenComplete(() async {
      //await audioCache.play("timer_song.mp3");
      Navigator.push(
        context,
        PageTransition(
          duration: const Duration(milliseconds: 300),
          type: PageTransitionType.fade,
          child: StreakScreen(
            streakCount: prefData['data']['STRIKE'],
            subtitleText: prefData['meditationData']['TEXT'],
            userID: prefData['data']['USER_ID'],
          ),
        ),
      ).then((value) {
        // t.cancel();
        timer.cancel();
      });
    });
//after counter is completed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Column(
              children: [
                //counter view
                Countdown(
                    animation: StepTween(
                  begin: widget.timerValue * 60,
                  end: 0,
                ).animate(controller)),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                beginButton(),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.0425),
              child: backButton(),
            )
          ],
        ),
      ),
    );
  }

//this code is play and pause timer
  Widget beginButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        if (!controller.isAnimating) {
          controller.forward().whenComplete(() async {
            //await audioCache.play("timer_song.mp3");
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 300),
                type: PageTransitionType.fade,
                child: StreakScreen(
                  streakCount: prefData['data']['STRIKE'],
                  subtitleText: prefData['meditationData']['TEXT'],
                  userID: prefData['data']['USER_ID'],
                ),
              ),
            );
          });
          await audioPlayer.resume();
          setState(() {
            isRunning = false;
          });
        } else {
          controller.stop();
          await audioPlayer.pause();
          setState(() {
            isRunning = true;
          });
        }
      },
      child: Image.asset(
        isRunning ? ConstImages.playImage : ConstImages.pauseImage,
        height: MediaQuery.of(context).size.height * 0.085,
      ),
    );
  }

  //finish button code

  Widget backButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        controller.dispose();
        audioPlayer.stop();
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 300),
            type: PageTransitionType.fade,
            child: StreakScreen(
              streakCount: prefData['data']['STRIKE'],
              subtitleText: prefData['meditationData']['TEXT'],
              userID: prefData['data']['USER_ID'],
            ),
          ),
        );
      },
      child: const Text(
        Strings.finishButtonTExt,
        style: TextStyle(
          color: Colours.whiteColor,
          fontSize: 20,
          fontFamily: 'FuturaMediumBT',
          fontWeight: FontWeight.w600,
          letterSpacing: 0.78,
        ),
      ),
    );
  }
}

//show counter text
class Countdown extends AnimatedWidget {
  Countdown({required this.animation}) : super(listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).truncate().toString()}:${clockTimer.inSeconds.remainder(60).truncate().toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.09,
        color: Colours.whiteColor,
        fontFamily: 'FuturaBookFont',
      ),
    );
  }
}
