import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_foreground_task/ui/with_foreground_task.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:meditation_app/constant/image.dart';
import 'package:meditation_app/view/timer_screen/timer_running_screen.dart';
import 'package:page_transition/page_transition.dart';

import '../../constant/colors.dart';
import '../../constant/preferences_key.dart';
import '../../constant/strings.dart';

class ChooseTimerScreeen extends StatefulWidget {
  const ChooseTimerScreeen({Key? key}) : super(key: key);

  @override
  State<ChooseTimerScreeen> createState() => _ChooseTimerScreeenState();
}

class _ChooseTimerScreeenState extends State<ChooseTimerScreeen> {
  int? isSelected;
  String? data;
  int? finalvalue;
  String? finalMusic;
  ScrollController scrollController = ScrollController();
  ScrollController? controller;
  IsInViewPortCondition? inViewPortCondition;
  late Map<String, dynamic> prefData;
  List<Map<String, dynamic>>? numberList;
  //List<int> numberList = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {});
    var data = preferences.getString(Keys.userReponse);

    prefData = jsonDecode(data!);
    numberList = [
      {
        'minit': '5',
        'music': prefData['MUSIC_URL']['FIVE'],
      },
      {
        'minit': '10',
        'music': prefData['MUSIC_URL']['TEN'],
      },
      {
        'minit': '15',
        'music': prefData['MUSIC_URL']['FIFTEEN'],
      },
      {
        'minit': '20',
        'music': prefData['MUSIC_URL']['TWENTY'],
      },
      {
        'minit': '25',
        'music': '',
      },
      {
        'minit': '30',
        'music': '',
      },
      {
        'minit': '35',
        'music': '',
      },
      {
        'minit': '40',
        'music': '',
      },
      {
        'minit': '45',
        'music': '',
      },
      {
        'minit': '50',
        'music': '',
      },
      {
        'minit': '55',
        'music': '',
      },
      {
        'minit': '60',
        'music': '',
      },
    ];
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IsInViewPortCondition condition = inViewPortCondition ??
        (double deltaTop, double deltaBottom, double vpHeight) {
          return deltaTop < (0.5 * vpHeight) && deltaBottom > (0.5 * vpHeight);
        };
    return WithForegroundTask(
      child: Scaffold(
        backgroundColor: Colours.blackColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                Strings.headingTExt,
                style: TextStyle(
                  fontFamily: 'Recoleta-SemiBold',
                  fontSize: MediaQuery.of(context).size.width * 0.088,
                  letterSpacing: 0.7,
                  color: Colours.whiteColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Text(
                Strings.subTitleButtonTExt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.044,
                  letterSpacing: 0.25,
                  fontFamily: 'FuturaBookFont',
                  height: 1.5,
                  color: Colours.whiteColor,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
              ),
              buildButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.expand,
                  children: <Widget>[
                    InViewNotifierList(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.06,
                        top: MediaQuery.of(context).size.height * 0.05,
                      ),
                      controller: controller,
                      initialInViewIds: const ['0'],
                      isInViewPortCondition: condition,
                      itemCount: numberList!.length,
                      builder: (BuildContext context, int index) {
                        return Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: InViewNotifierWidget(
                            id: index.toString(),
                            builder: (BuildContext context, bool isInView,
                                Widget? child) {
                              isSelected = isInView
                                  ? int.parse(numberList![index]['minit'])
                                  : 0;
                              data = isSelected.toString();

                              if (data!.contains(
                                  numberList![index]['minit'].toString())) {
                                HapticFeedback.mediumImpact();
                                finalvalue = int.parse(data!);
                                finalMusic = numberList![index]['music'];
                              }
                              return Text(
                                '${numberList![index]['minit'].toString()}min',
                                key: ValueKey("item-$index"),
                                style: TextStyle(
                                  fontFamily: 'FuturaBookFont',
                                  color: isInView
                                      ? Colours.whiteColor
                                      : Colours.whiteColor.withOpacity(0.4),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    IgnorePointer(
                      ignoring: true,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colours.greyColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildScrollText(
      {required String textValue, required int selectValue}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "${textValue}min",
        style: TextStyle(
          fontFamily: 'FuturaBookFont',
          color: scrollController.offset > 84
              ? Colours.whiteColor
              : Colours.whiteColor.withOpacity(0.4),
          fontSize: MediaQuery.of(context).size.width * 0.06,
        ),
      ),
    );
  }

  Widget buildButton() {
    return GestureDetector(
      onTap: () async {
        await HapticFeedback.mediumImpact();
        Navigator.push(
          context,
          PageTransition(
            duration: const Duration(milliseconds: 300),
            type: PageTransitionType.fade,
            child: MyHomePage(timerValue: finalvalue!, music: finalMusic),
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
