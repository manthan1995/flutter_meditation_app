import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meditation_app/app.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void startCallback() {
//   FlutterForegroundTask.setTaskHandler(MyTaskHandler());
// }

void main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SharedPreferences.getInstance().then((prefs) {
    preferences = prefs;
    runApp(const MyApp());
  });
}
