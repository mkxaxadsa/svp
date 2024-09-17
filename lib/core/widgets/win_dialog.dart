import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/assets.dart';
import '../../features/home/widgets/coins_card.dart';
import '../models/page_model.dart';
import '../utils.dart';
import 'texts/text_r.dart';

class RewardSlotDialog extends StatefulWidget {
  const RewardSlotDialog({
    super.key,
    required this.page,
    required this.spinCount,
    required this.text,
    required this.isWin,
  });

  final String text;
  final ValueNotifier<int> spinCount;
  final PageModel page;
  final bool isWin;

  @override
  State<RewardSlotDialog> createState() => _RewardSlotDialogState();
}

class _RewardSlotDialogState extends State<RewardSlotDialog> {
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) {},
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 330,
          width: 250,
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  widget.isWin ? widget.page.win : widget.page.gameOver,
                  height: 330,
                  width: 250,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 30,
                bottom: 30,
                child: Column(
                  children: [
                    Text(
                      widget.text,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color(0xFFFFB956),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Image.asset(
                                Assets.imagesDailyBonusTitle,
                                fit: BoxFit.fill,
                                width: 60,
                              ),
                            ),
                            Stack(
                              children: [
                                SvgPicture.asset(
                                  'assets/gems_card.svg',
                                ),
                                Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Image.asset(
                                      Assets.assetsSpinCount,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  left: 45,
                                  child: ValueListenableBuilder(
                                    valueListenable: widget.spinCount,
                                    builder: (context, value, child) {
                                      return TextR(
                                        "${formatNumber(value)}/5",
                                        fontSize: 15,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.isWin
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CoinsCard(),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE2229B),
                          width: 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFB3EAD9).withOpacity(.85),
                            const Color(0xFF5F81D9).withOpacity(.85),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF2F3B8C).withOpacity(.4),
                          padding: !widget.isWin ? null : EdgeInsets.zero,
                          child: Padding(
                            padding: widget.isWin
                                ? const EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 45,
                                  )
                                : EdgeInsets.zero,
                            child: Text(
                              widget.isWin ? "Next Level" : "Retry",
                              style: const TextStyle(
                                height: 1,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          onPressed: () {
                            // if (widget.isWin) {
                            //   context.pop();
                            // }
                            context.pop();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFE2229B),
                          width: 1,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFB3EAD9).withOpacity(.85),
                            const Color(0xFF5F81D9).withOpacity(.85),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CupertinoButton(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF2F3B8C).withOpacity(.4),
                          child: const Text(
                            "Home",
                            style: TextStyle(
                              height: 1,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          onPressed: () {
                            context.pop();
                            context.pop();
                            context.pop();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
