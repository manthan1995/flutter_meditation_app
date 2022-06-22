import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/provider/welcome_provider.dart';
import 'package:meditation_app/view/auth/create_account/create_account_screen.dart';
import 'package:meditation_app/widgtes/buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'constant/colors.dart';
import 'constant/strings.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  WelcomeProvider welcomeProvider = WelcomeProvider();
  int currentText = 0;
  Animation<double>? animation;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward(from: 0);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    welcomeProvider = Provider.of<WelcomeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.blackColor,
      body: Consumer<WelcomeProvider>(
        builder: (context, valueOfText, child) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * 0.09,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: buildTextView(valueOfText),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(right: 10),
                    //   child: buildDotView(valueOfText),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                ),
                child: Center(
                  child: Column(
                    children: [
                      buildButton(valueOfText),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      buildBackButton(valueOfText),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextView(WelcomeProvider valueOfText) {
    return FadeTransition(
      opacity: animation!,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Center(
          child: Text(
            valueOfText.changeText == 0
                ? Strings.firstWelStr
                : valueOfText.changeText == 1
                    ? Strings.secondeWelStr
                    : valueOfText.changeText == 2
                        ? Strings.thirdWelStr
                        : Strings.fourthWelStr,
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
        ),
      ),
    );
  }

  // Widget buildDotView(WelcomeProvider valueOfText) {
  //   return SizedBox(
  //     height: 50,
  //     child: ListView.builder(
  //       itemCount: 4,
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       scrollDirection: Axis.horizontal,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           margin: const EdgeInsets.all(5),
  //           width: 8,
  //           height: 10,
  //           decoration: BoxDecoration(
  //               color: valueOfText.changeText == index
  //                   ? Colors.white
  //                   : Colors.white24,
  //               shape: BoxShape.circle),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget buildButton(WelcomeProvider valueOfText) {
    return CommanMaterialButton(
      buttonText: valueOfText.changeText == 3
          ? Strings.getStartedStr
          : Strings.continueStr,
      buttonColor: Colours.whiteColor,
      fontWeight: FontWeight.w600,
      buttonWidth: 190,
      onPressed: () async {
        await HapticFeedback.mediumImpact();
        controller = AnimationController(
          duration: const Duration(seconds: 2),
          vsync: this,
        )..forward(from: 0);
        animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
        if (valueOfText.changeText == 0) {
          valueOfText.chnageTextProvider(1);
        } else if (valueOfText.changeText == 1) {
          valueOfText.chnageTextProvider(2);
        } else if (valueOfText.changeText == 2) {
          valueOfText.chnageTextProvider(3);
        } else {
          valueOfText.chnageTextProvider(0);
          Navigator.push(
            context,
            PageTransition(
              duration: const Duration(milliseconds: 200),
              type: PageTransitionType.fade,
              child: const CreateAccountScreen(),
            ),
          );
        }
      },
    );
  }

  Widget buildBackButton(WelcomeProvider valueOfText) {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        controller = AnimationController(
          duration: const Duration(seconds: 2),
          vsync: this,
        )..forward(from: 0);
        animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
        if (valueOfText.changeText == 1) {
          valueOfText.chnageTextProvider(0);
        } else if (valueOfText.changeText == 2) {
          valueOfText.chnageTextProvider(1);
        } else if (valueOfText.changeText == 3) {
          valueOfText.chnageTextProvider(2);
        } else {
          valueOfText.chnageTextProvider(0);
        }
      },
      child: Text(
        valueOfText.changeText == 0 ? '' : 'Back',
        style: const TextStyle(
          fontSize: 20,
          color: Colours.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
