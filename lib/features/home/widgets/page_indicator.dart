import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    super.key,
    required this.id,
    required this.active,
    required this.onPressed,
  });

  final int id;
  final bool active;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        onPressed(id);
      },
      padding: EdgeInsets.zero,
      minSize: 15,
      child: SvgPicture.asset(
        active ? 'assets/page_indicator1.svg' : 'assets/page_indicator2.svg',
      ),
    );
  }
}
