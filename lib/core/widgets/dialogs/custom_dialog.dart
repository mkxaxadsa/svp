import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../texts/text_r.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        width: 430,
        height: size.height * .7,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 408,
                  margin: const EdgeInsets.all(33),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffFF8E8E),
                        blurRadius: 25,
                      ),
                    ],
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xffE2229C),
                        Color(0xffE22225),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: 400,
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xff007FFF),
                            Color(0xff003C78),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/rules_text.svg'),
                          const TextR(
                            'Everything is very simple - you need to collect a chain of 3 or more elements in a row. The only limitation is time, so watch it. For each successfully made combination, you will receive coins as a reward.\n\nYou also have bonuses: free moves and extra time, which can be purchased for accumulated coins.\n\nIf you fail twice in a row, you will have the opportunity to buy diamonds.\n\nIf you do not manage to collect the required number of combinations before the end of time, the game will be lost.',
                            fontSize: 15,
                            maxLines: 20,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20,
              top: 6,
              child: CupertinoButton(
                onPressed: () {
                  context.pop();
                },
                padding: EdgeInsets.zero,
                child: SvgPicture.asset('assets/close.svg'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CupertinoButton(
                onPressed: () {
                  context.pop();
                },
                padding: EdgeInsets.zero,
                child: SvgPicture.asset('assets/ok.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
