import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MusicButton extends StatefulWidget {
  const MusicButton({super.key});

  @override
  State<MusicButton> createState() => _MusicButtonState();
}

class _MusicButtonState extends State<MusicButton> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        setState(() {
          active = !active;
        });
      },
      padding: EdgeInsets.zero,
      child: SvgPicture.asset(
        active ? 'assets/music1.svg' : 'assets/music2.svg',
      ),
    );
  }
}
