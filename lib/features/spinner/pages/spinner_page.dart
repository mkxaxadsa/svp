import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project22/common/assets.dart';
import 'package:project22/core/widgets/texts/text_r.dart';

import '../../../core/db/prefs.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../home/bloc/home_bloc.dart';
import '../../home/widgets/gems_card.dart';
import '../widgets/arrow_back_button.dart';
import '../widgets/spin_button.dart';

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({super.key});

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  double turns = 0.0;
  double angle = 0;

  bool canSpin = true;

  List<double> angles = [
    2, // 2
    3,
    14, // 3
    15, // 4
    8,
    16, // 3
    19, // 4
    13,
    20, // 3
    21, // 2
    18,
    24, // 2
    26, // 1
    23,
    29, // 2
  ];

  int getGems() {
    if (angle == 2) return 2;
    if (angle == 14) return 3;
    if (angle == 15) return 4;
    if (angle == 16) return 3;
    if (angle == 19) return 4;
    if (angle == 20) return 3;
    if (angle == 21) return 2;
    if (angle == 24) return 2;
    if (angle == 26) return 1;
    if (angle == 29) return 2;
    return 0;
  }

  void getRandom() {
    Random random = Random();
    int randomIndex = random.nextInt(angles.length);
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        angle = angles[randomIndex];
        logger(angle);
      });
    });
  }

  void onSpin() async {
    if (isStop.value) {
      isStop.value = false;
    }
    if (canSpin) {
      // canSpin = false;
      setState(() {
        turns += 5 / 1;
      });
      getRandom();
      Future.delayed(const Duration(seconds: 7), () async {
        await saveInt(Prefs.gemsKEY, Prefs.gems.value + getGems()).then((_) {
          if (mounted) context.read<HomeBloc>().add(GetHomeEvent());
          isStop.value = true;

          var iso = DateTime.now().add(const Duration(days: 1));
          setTimeDiamonds(time: iso.toIso8601String());
          // print(object)
          playButtonTime.value = iso.second;
          getTimer();
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              var gems = getGems();
              return RewardDialog(
                isWin: gems != 0,
                gems: gems,
              );
            },
          );
        });
      });
    } else {
      logger('CANT SPIN');
    }
  }

  ValueNotifier<bool> isStop = ValueNotifier(false);

  ValueNotifier<int> playButtonTime = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    getTimer();
  }

  getTimer() async {
    DateTime? timeDiamonds = await getTimeDiamonds();

    if (timeDiamonds != null) {
      var time = DateTime.now().difference(timeDiamonds);
      var isAfter = DateTime.now().isAfter(timeDiamonds);
      if (!isAfter) {
        playButtonTime.value = time.inSeconds.abs();
        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (playButtonTime.value < 1) {
            timer.cancel();
          }
          playButtonTime.value--;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 4 + getStatusBar(context)),
                SvgPicture.asset('assets/spinner/title_card.svg'),
                const GemsCard(),
                const Spacer(),
                SizedBox(
                  // color: Colors.greenAccent,
                  height: 430,
                  width: 400,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset('assets/spinner/spinner3.svg'),
                      ),
                      Center(
                        child: Transform.rotate(
                          angle: angle,
                          child: AnimatedRotation(
                            turns: turns,
                            curve: Curves.easeInOutCirc,
                            duration: const Duration(seconds: 6),
                            child: Stack(
                              children: [
                                Image.asset(Assets.spinnerSpinner),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/spinner/spinner2.png',
                          height: 45,
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset('assets/spinner/spinner2.svg'),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ValueListenableBuilder(
                  valueListenable: playButtonTime,
                  builder: (context, value, child) {
                    if (value < 1) {
                      return SpinButton(onPressed: onSpin);
                    }
                    return CupertinoButton(
                      onPressed: null,
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
                              child: Text(
                                "Next\n${formatTime(playButtonTime.value)}",
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(color: Color(0xFFFFFFFF)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
          const ArrowBackButton(),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr';
  }
}

class RewardDialog extends StatelessWidget {
  final bool isWin;
  final int? gems;

  const RewardDialog({super.key, required this.isWin, this.gems});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 330,
        child: Stack(
          children: [
            Image.asset(Assets.assetsWinLoseBack),
            Positioned(
              right: 5,
              top: 0,
              child: CupertinoButton(
                onPressed: () {
                  context.pop();
                },
                padding: EdgeInsets.zero,
                child: SvgPicture.asset('assets/close.svg'),
              ),
            ),
            Positioned(
              top: 22,
              left: 10,
              right: 10,
              child: isWin
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "Congratulations!",
                          style:
                              TextStyle(fontSize: 24, color: Color(0xFFEC24FF)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.assetsGem,
                              height: 60,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 25),
                              child: Text(
                                "${Prefs.gems.value}",
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Color(0xFF3BDB26),
                                  height: .6,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "You got 3 gems",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Image.asset(
                          Assets.assetsEmot,
                          height: 75,
                        ),
                        const TextR(
                          "Oops..\nBetter luck next time",
                          fontSize: 18,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
