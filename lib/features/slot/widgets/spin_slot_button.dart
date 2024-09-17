import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpinSlotButton extends StatelessWidget {
  const SpinSlotButton({
    super.key,
    required this.id,
    required this.onPressed,
  });

  final int id;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          if (id == 3)
            Positioned(
              right: -1,
              bottom: -1,
              child: Image.asset(
                'assets/play3.png',
                height: 170,
              ),
            ),
          SvgPicture.asset('assets/slot/spin_button$id.svg'),
        ],
      ),
    );
  }
}
