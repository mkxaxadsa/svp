import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/utils.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({super.key, this.home = false});

  final bool home;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20 + getStatusBar(context),
      left: 22,
      child: CupertinoButton(
        onPressed: () {
          context.pop();
          if (home) context.pop();
        },
        padding: EdgeInsets.zero,
        child: SvgPicture.asset('assets/back.svg'),
      ),
    );
  }
}
