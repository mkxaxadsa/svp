import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/router.dart';

class WheelButton extends StatelessWidget {
  const WheelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        context.push(Routes.spinner);
      },
      padding: EdgeInsets.zero,
      child: SvgPicture.asset('assets/wheel_button.svg'),
    );
  }
}
