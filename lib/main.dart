import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:meditation_app/app.dart';
import 'package:meditation_app/constant/preferences_key.dart';
import 'package:meditation_app/view/timer_screen/foreground_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

void main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await SharedPreferences.getInstance().then((prefs) {
    preferences = prefs;
    runApp(const MyApp());
  });
}
