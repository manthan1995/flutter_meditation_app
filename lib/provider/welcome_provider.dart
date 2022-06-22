import 'package:flutter/material.dart';

class WelcomeProvider extends ChangeNotifier {
  int changeText = 0;

  void chnageTextProvider(int text) {
    changeText = text;
    notifyListeners();
  }
}
