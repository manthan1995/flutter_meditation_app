// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:meditation_app/constant/colors.dart';
// import 'package:meditation_app/constant/strings.dart';
// import 'package:page_transition/page_transition.dart';
// import '../../api_provider/subscription_api/subscription_api.dart';
// import '../../bottom_bar.dart';
// import '../../constant/preferences_key.dart';
// import '../../widgtes/cicualer_indicator.dart';
// import 'Subscription_button.dart';

// // const bool _kAutoConsume = true;

// // const String _kConsumableId = 'com.scape.meditations.yearlypack';

// // const List<String> _kProductIds = <String>[
// //   _kConsumableId,
// // ];

// class PurchaseScreen extends StatefulWidget {
//   const PurchaseScreen({Key? key}) : super(key: key);
//   @override
//   State<PurchaseScreen> createState() => _PurchaseScreenState();
// }

// class _PurchaseScreenState extends State<PurchaseScreen>
//     with TickerProviderStateMixin {
//   int _pos = 0;
//   Timer? _timer;
//   late Map<String, dynamic> prefData;
//   late AnimationController animation;
//   late Animation<double> _fadeInFadeOut;

//   late int subscriptionDay = 0;

//   SubscriptionApi subscriptionApi = SubscriptionApi();

//   List<Map<String, dynamic>> imageList = [
//     {
//       'image': 'assets/image/purchase1.png',
//       'subtitleText':
//           '"This app is life-changing. I love how each daily meditation has a new theme"',
//       'authorName': '- Ann Chidester',
//     },
//     {
//       'image': 'assets/image/purchase2.png',
//       'subtitleText':
//           "\"I've used Scape for 2 weeks and it's by far the most calming app I've ever tried\"",
//       'authorName': '- Frederic Karlsen',
//     },
//     {
//       'image': 'assets/image/purchase3.png',
//       'subtitleText':
//           "\"Scape has had a major impact on my stress and anxiety, it's like night and day.\"",
//       'authorName': '- Kristine Sundkjer',
//     },
//   ];

//   @override
//   void initState() {
//     var data = preferences.getString(Keys.userReponse);

//     prefData = jsonDecode(data!);
//     animation = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 5),
//     );
//     _fadeInFadeOut = Tween<double>(begin: 0.0, end: 9.8).animate(animation);

//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         animation.reverse();
//       } else if (status == AnimationStatus.dismissed) {
//         animation.forward();
//       }
//     });

//     animation.forward();

//     Timer.periodic(const Duration(seconds: 10), (Timer t) {
//       setState(() {
//         _pos = (_pos + 1) % imageList.length;
//       });
//     });

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _timer = null;
//     animation.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colours.blackColor,
//       body: WillPopScope(
//         onWillPop: () async {
//           showCommanExitDialog(
//             context: context,
//             content: Strings.exitAppContent,
//             title: Strings.exitAppTitle,
//             okOnPressed: () => Navigator.pop(context, true),
//             cancleOnPressed: () => Navigator.pop(context, false),
//           ).then((exit) {
//             if (exit == null) return;
//             if (exit) {
//               SystemNavigator.pop();
//             } else {}
//           });
//           return false; // disable back press
//         },
//         child: Stack(
//           children: [
//             FadeTransition(
//               opacity: animation,
//               child: SizedBox(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset(
//                   imageList[_pos]['image'],
//                   fit: BoxFit.fill,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: MediaQuery.of(context).size.width * 0.07,
//                 right: MediaQuery.of(context).size.width * 0.04,
//                 top: MediaQuery.of(context).size.height * 0.07,
//                 bottom: MediaQuery.of(context).size.height * 0.05,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   headerView(),
//                   centerViewText(),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.04,
//                   ),
//                   buildButtonView(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget headerView() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.1,
//         ),
//         GestureDetector(
//           onTap: () async {
//             await HapticFeedback.mediumImpact();
//             Navigator.of(context).push(
//               PageTransition(
//                 type: PageTransitionType.fade,
//                 //child: const BeginnerInfoScreen(),
//                 child: BottomBarscreen(selectBottmTab: 0),
//               ),
//             );
//           },
//           child: Icon(
//             Icons.cancel,
//             color: Colours.greyColor,
//             size: MediaQuery.of(context).size.height * 0.04,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget centerViewText() {
//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.17,
//         ),
//         Text(
//           Strings.tryScapeFree,
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontSize: MediaQuery.of(context).size.height * 0.035,
//             color: Colours.whiteColor,
//             fontFamily: 'Recoleta-SemiBold',
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.07,
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * 0.054),
//           child: FadeTransition(
//             opacity: animation,
//             child: Text(
//               imageList[_pos]['subtitleText'],
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: MediaQuery.of(context).size.height * 0.024,
//                 color: Colours.whiteColor,
//                 letterSpacing: 0.7,
//                 height: 1.3,
//                 fontFamily: 'FuturaBookFont',
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.045,
//         ),
//         FadeTransition(
//           opacity: animation,
//           child: Text(
//             imageList[_pos]['authorName'],
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colours.whiteColor,
//               fontFamily: 'FuturaMediumBT',
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildButtonView() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SubscriptionButton(screenType: 'Try Free'),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.02,
//         ),
//         const Text(
//           'Try 7 days free,then \$69/year',
//           style: TextStyle(
//             fontSize: 12,
//             color: Colours.whiteColor,
//             fontFamily: 'FuturaMediumBT',
//           ),
//         ),
//       ],
//     );
//   }
// }
