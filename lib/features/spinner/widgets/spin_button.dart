import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpinButton extends StatelessWidget {
  const SpinButton({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 120,
        width: 120,
        child: Stack(
          children: [
            Positioned(
              right: -2,
              bottom: -2,
              child: Image.asset(
                'assets/play3.png',
                height: 120,
              ),
            ),
            Center(
              child: SvgPicture.asset('assets/spinner/spinner4.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
