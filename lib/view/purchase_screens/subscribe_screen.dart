import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant/colors.dart';
import '../home/home_screen.dart';
import 'Subscription_button.dart';

class SubScribeScreen extends StatefulWidget {
  const SubScribeScreen({Key? key}) : super(key: key);

  @override
  State<SubScribeScreen> createState() => _SubScribeScreenState();
}

class _SubScribeScreenState extends State<SubScribeScreen>
    with TickerProviderStateMixin {
  late int _pos = 0;
  Timer? _timer;
  late Map<String, dynamic> prefData;
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  List<Map<String, dynamic>> imageList = [
    {
      'image': 'assets/image/purchase1.png',
      'subtitleText':
          "Scape has had a major impact \non my stress and anxiety, it's\n like night and day.\"",
      'authorName': '- Kristine Sundjer',
    },
    {
      'image': 'assets/image/purchase2.png',
      'subtitleText':
          "\"I've used Scape for 2 weeks \nand it's by far the most\n calming app I've ever tried\"",
      'authorName': '- Frederic Karlsen',
    },
    {
      'image': 'assets/image/purchase3.png',
      'subtitleText':
          "\"Scape has had a major impact \non my stress and anxiety, \nit's like night and day.\"",
      'authorName': '- Kristine Sundkjer',
    },
  ];

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _fadeInFadeOut = Tween<double>(begin: 0, end: 5).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });

    animation.forward();

    Timer.periodic(const Duration(seconds: 6), (Timer t) {
      setState(() {
        _pos = (_pos + 1) % imageList.length;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FadeTransition(
              opacity: animation,
              child: Image.asset(
                imageList[_pos]['image'],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.07,
                  right: MediaQuery.of(context).size.width * 0.04,
                  top: MediaQuery.of(context).size.height * 0.07,
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: headerView(),
              ),
              buildCenterView(),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.062,
                ),
                child: Column(
                  children: [
                    SubscriptionButton(screenType: 'Subscribe'),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    const Text(
                      '\$69/year',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colours.whiteColor,
                        fontFamily: 'FuturaMediumBT',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget headerView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
        ),
        GestureDetector(
          onTap: () async {
            await HapticFeedback.mediumImpact();
            Navigator.of(context).push(
              PageTransition(
                type: PageTransitionType.fade,
                //child: const BeginnerInfoScreen(),
                child: const HomeScreen(),
              ),
            );
          },
          child: Icon(
            Icons.cancel,
            color: Colours.greyColor,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
      ],
    );
  }

  Widget buildCenterView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Continue your\n journey with Scape',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.036,
              color: Colours.whiteColor,
              fontFamily: 'Recoleta-SemiBold',
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          FadeTransition(
            opacity: animation,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                imageList[_pos]['subtitleText'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.024,
                  color: Colours.whiteColor,
                  letterSpacing: 0.7,
                  height: 1.3,
                  fontFamily: 'FuturaBookFont',
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          FadeTransition(
            opacity: animation,
            child: Text(
              imageList[_pos]['authorName'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                letterSpacing: 0.7,
                height: 1.3,
                fontSize: 16,
                color: Colours.whiteColor,
                fontFamily: 'FuturaMediumBT',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
