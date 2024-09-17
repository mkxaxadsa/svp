import 'package:flutter/material.dart';

import '../utils.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.bg = 1,
  });

  final Widget body;
  final int bg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xff193257),
                  ),
                ),
                Image.asset(
                  'assets/bg/bg$bg.png',
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: getHeight(context) / 3,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          const Color(0xff000000).withOpacity(0),
                          const Color(0xff193257),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: getHeight(context) / 3,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          const Color(0xff000000).withOpacity(0),
                          const Color(0xff193257),
                        ],
                      ),
                    ),
                  ),
                ),
                body,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
