import 'package:flutter/material.dart';

class PageModel {
  String title;
  String win;
  String gameOver;
  Color color;
  int bg;
  List<String> items;
  List<String> stories;
  LinearGradient gradient;

  PageModel(
      {required this.title,
      required this.win,
      required this.stories,
      required this.gameOver,
      required this.color,
      required this.bg,
      required this.items,
      required this.gradient});
}
