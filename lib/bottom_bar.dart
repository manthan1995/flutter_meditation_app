import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation_app/constant/colors.dart';
import 'package:meditation_app/constant/image.dart';
import 'package:meditation_app/view/home/home_screen.dart';
import 'package:meditation_app/view/profile_screen/profile_screen.dart';
import 'package:meditation_app/view/timer_screen/choose_timer_screen.dart';

class BottomBarscreen extends StatefulWidget {
  late int selectBottmTab;

  BottomBarscreen({required this.selectBottmTab});
  @override
  State<BottomBarscreen> createState() => _BottomBarscreenState();
}

class _BottomBarscreenState extends State<BottomBarscreen> {
  @override
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ChooseTimerScreeen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) async {
    await HapticFeedback.mediumImpact();

    setState(() {
      widget.selectBottmTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _widgetOptions.elementAt(widget.selectBottmTab),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.04,
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.black,
            selectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  ConstImages.bottomHomeImage,
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: widget.selectBottmTab == 0
                      ? Colours.whiteColor
                      : Colours.whiteColor.withOpacity(0.5),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ConstImages.bottomTimerImage,
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: widget.selectBottmTab == 1
                      ? Colours.whiteColor
                      : Colours.whiteColor.withOpacity(0.5),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ConstImages.bottomProfileImage,
                  height: MediaQuery.of(context).size.height * 0.04,
                  color: widget.selectBottmTab == 2
                      ? Colours.whiteColor
                      : Colours.whiteColor.withOpacity(0.5),
                ),
                label: '',
              ),
            ],
            // currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
