import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import '../../bottom_bar.dart';
import '../../constant/colors.dart';
import '../purchase_screens/Subscription_button.dart';

class ProfilePurchaseScreen extends StatefulWidget {
  const ProfilePurchaseScreen({Key? key}) : super(key: key);

  @override
  State<ProfilePurchaseScreen> createState() => _ProfilePurchaseScreenState();
}

class _ProfilePurchaseScreenState extends State<ProfilePurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colours.blackColor,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/image/purchase.png',
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.07,
              top: MediaQuery.of(context).size.height * 0.05,
              bottom: MediaQuery.of(context).size.height * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                headerView(),
                centerViewText(),
                buildButtonView(),
              ],
            ),
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
                child: BottomBarscreen(selectBottmTab: 0),
              ),
            );
          },
          child: Icon(
            Icons.cancel,
            color: Colours.whiteColor,
            size: MediaQuery.of(context).size.height * 0.04,
          ),
        ),
      ],
    );
  }

  Widget centerViewText() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.23,
        ),
        Text(
          'Create a calm \nmind with Scape',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.04,
            color: Colours.whiteColor,
            fontFamily: 'Recoleta-SemiBold',
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.054),
          child: Text(
            "Get full access to Scape's daily \nguided meditations.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.021,
              color: Colours.whiteColor,
              letterSpacing: 0.7,
              height: 1.3,
              fontFamily: 'FuturaBookFont',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildButtonView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '\$69/year after 7 days free trial.',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.018,
            color: Colours.whiteColor,
            fontFamily: 'FuturaMediumBT',
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
        SubscriptionButton(screenType: 'Subscribe'),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.025,
        ),
      ],
    );
  }
}
