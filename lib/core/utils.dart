import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/constants.dart';

double navBarHeight = 60;

int getCurrentTimestamp() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

Future<DateTime?> setTimeDailyRewards({String? time}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(SharedData.daily,
      time ?? DateTime.now().add(const Duration(hours: 24)).toIso8601String());
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

Future<DateTime?> getTimeDailyRewards() async {
  final prefs = await SharedPreferences.getInstance();
  String? time = prefs.getString(SharedData.daily);
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

String timestampToString(int timestamp) {
  // timestamp to 22.06.2000
  try {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('dd.MM.yyyy').format(date);
  } catch (e) {
    return 'Error';
  }
}

Future<DateTime?> getTimeDiamonds() async {
  final prefs = await SharedPreferences.getInstance();
  String? time = prefs.getString(SharedData.diamondsTime);
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

Future<DateTime?> setTimeDiamonds({String? time}) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(
      SharedData.diamondsTime, time ?? DateTime.now().toIso8601String());
  var dateTime = DateTime.tryParse(time ?? "");
  return dateTime;
}

String dateToString(DateTime date) {
  // DateTime to 22.06.2000
  try {
    return DateFormat('dd.MM.yyyy').format(date);
  } catch (e) {
    return 'Error';
  }
}

String timeToString(DateTime time) {
  // DateTime to 22:00
  try {
    return DateFormat('HH:mm').format(time);
  } catch (e) {
    return 'Error';
  }
}

DateTime stringToDate(String date) {
  // 22.06.2000 to DateTime
  try {
    return DateFormat('dd.MM.yyyy').parse(date);
  } catch (e) {
    return DateTime.now();
  }
}

String formatNumber(int number) {
  print(number);
  return NumberFormat('#,###').format(number);
}

double getStatusBar(BuildContext context) {
  return MediaQuery.of(context).viewPadding.top;
}

double getBottom(BuildContext context) {
  return MediaQuery.of(context).viewPadding.bottom;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

bool getButtonActive(List<TextEditingController> controllers) {
  for (TextEditingController controller in controllers) {
    if (controller.text.isEmpty) return false;
  }
  return true;
}

void logger(Object message) {
  try {
    developer.log(message.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}

void precacheImages(BuildContext context) {
  try {
    List<String> imageAssets = [
      'assets/bg/bg1.png',
      'assets/bg/bg2.png',
      'assets/bg/bg3.png',
      'assets/bg/bg4.png',
      'assets/slot1/win.png',
      'assets/slot2/win.png',
      'assets/slot3/win.png',
      'assets/slot1/gameover.png',
      'assets/slot2/gameover.png',
      'assets/slot3/gameover.png',
    ];
    for (String assets in imageAssets) {
      precacheImage(AssetImage(assets), context);
    }
  } catch (e) {
    logger(e);
  }
}
