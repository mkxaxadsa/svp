import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/texts/text_r.dart';

class GameTitleCard extends StatefulWidget {
  const GameTitleCard({super.key, required this.id});

  final int id;

  @override
  State<GameTitleCard> createState() => _GameTitleCardState();
}

class _GameTitleCardState extends State<GameTitleCard> {
  bool description = false;

  String getDescriptionText() {
    if (widget.id == 2) {
      return 'In the game “Happy Monkey” you travel through the tropical jungle, collecting rows of bananas, lianas and monkeys. For successful combinations you get coins and open new levels. Act fast to become the true owner of “Happy Monkey”';
    }
    if (widget.id == 3) {
      return 'In the game “Lucky Joker” you get into the world of bright circus lights, where you need to collect rows of fruits and jewels. For successful combinations you get coins and open new levels. Act quickly to become a master of “Lucky Joker”';
    }
    return 'In the game “Gold Buffalo” you go to the Wild West where you need to collect rows of cowboys, horses and gold bars to get coins. Each successful combination opens new levels. Limited time forces you to act fast to become a legendary gold digger.';
  }

  Color getCardBorderColor() {
    if (widget.id == 2) return const Color(0xff15390C);
    if (widget.id == 3) return const Color(0xff3A1010);
    return const Color(0xff441A5B);
  }

  List<Color> getCardGradientColors() {
    if (widget.id == 2) {
      return [
        const Color(0xff54A329),
        const Color(0xff0D5726),
      ];
    }
    if (widget.id == 3) {
      return [
        const Color(0xff7E1511),
        const Color(0xff782E25),
      ];
    }
    return [
      const Color(0xff7E114D),
      const Color(0xff56117E),
    ];
  }

  void onTap() {
    setState(() {
      description = !description;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: description
          ? Container(
              height: 110,
              width: 340,
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
                vertical: 5,
              ),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border(
                  bottom: BorderSide(
                    width: 3,
                    color: getCardBorderColor(),
                  ),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffDE89FF),
                    blurRadius: 25,
                  )
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: getCardGradientColors(),
                ),
              ),
              child: TextR(
                getDescriptionText(),
                fontSize: 12,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
            )
          : SizedBox(
              height: 110 + 24,
              child: SvgPicture.asset('assets/game_title${widget.id}.svg'),
            ),
    );
  }
}
