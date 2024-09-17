import 'package:flutter/material.dart';
import 'package:project22/common/assets.dart';

import '../../../core/utils.dart';

class LvlCard extends StatelessWidget {
  const LvlCard({super.key, required this.level});
  final int level;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20 + getStatusBar(context),
      right: 22,
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Image.asset(
              Assets.assetsLvlBack,
              height: 50,
            ),
            Center(
                child: Text(
              'lvl\n${level}/3',
              style: TextStyle(height: .9, fontSize: 12, color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
