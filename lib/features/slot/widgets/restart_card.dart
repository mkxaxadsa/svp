import 'package:flutter/material.dart';

import '../../../core/utils.dart';

class RestartCard extends StatelessWidget {
  const RestartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100 + getStatusBar(context),
      left: 22,
      child: Image.asset(
        'assets/slot/restart.png',
        height: 46,
      ),
    );
  }
}
