import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class ConsumableStore {
  static const String _kPrefKey = 'consumables';
  static Future<void> writes = Future<void>.value();

  // static Future<void> save(String id) {
  //   writes = writes.then((void_) => _doSave(id));
  //   return writes;
  // }

  static Future<void> consume(String id) {
    writes = writes.then((void_) => _doConsume(id));
    return writes;
  }

  static Future<List<String>> load() async {
    return (await SharedPreferences.getInstance()).getStringList(_kPrefKey) ??
        <String>[];
  }

  // static Future<void> _doSave(String id) async {
  //   final List<String> cached = await load();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   cached.add(id);
  //   await prefs.setStringList(_kPrefKey, cached);
  // }

  static Future<void> _doConsume(String id) async {
    final List<String> cached = await load();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    cached.remove(id);
    await prefs.setStringList(_kPrefKey, cached);
  }
}
