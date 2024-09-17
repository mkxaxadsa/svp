import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/dialogs/custom_dialog.dart';

class RulesButton extends StatelessWidget {
  const RulesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            // return const RulesDialog();
            return const CustomDialog();
          },
        );
      },
      padding: EdgeInsets.zero,
      child: SvgPicture.asset('assets/rules.svg'),
    );
  }
}
