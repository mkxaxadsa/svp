import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

class Prefs {
  static ValueNotifier<int> coins = ValueNotifier(100);
  static ValueNotifier<int> gems = ValueNotifier(100);

  static String coinsKEY = 'coinsKEY';
  static String gemsKEY = 'gemsKEY';
}

Future<void> getData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove(Prefs.onboard);
    // await prefs.clear();
    Prefs.coins.value = prefs.getInt(Prefs.coinsKEY) ?? 100;
    Prefs.gems.value = prefs.getInt(Prefs.gemsKEY) ?? 5;
  } catch (e) {
    logger(e);
  }
}

addCoins(int coin) async {
  final prefs = await SharedPreferences.getInstance();
  Prefs.coins.value += coin;
  prefs.setInt(Prefs.coinsKEY, Prefs.coins.value);
}

minusCoins(int coin) async {
  final prefs = await SharedPreferences.getInstance();
  Prefs.coins.value -= coin;
  prefs.setInt(Prefs.coinsKEY, Prefs.coins.value);
}

addDiamonds(int gems) async {
  final prefs = await SharedPreferences.getInstance();
  Prefs.gems.value += gems;
  prefs.setInt(Prefs.gemsKEY, Prefs.gems.value);
}

minusDiamonds(int gems) async {
  final prefs = await SharedPreferences.getInstance();
  Prefs.gems.value -= gems;
  prefs.setInt(Prefs.gemsKEY, Prefs.gems.value);
}

Future<void> saveString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> saveInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}
