import 'package:flutter/material.dart';

import '../../../core/utils.dart';

class AddTimeCard extends StatelessWidget {
  const AddTimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100 + getStatusBar(context),
      right: 22,
      child: Image.asset(
        'assets/slot/add_time.png',
        height: 46,
      ),
    );
  }
}
