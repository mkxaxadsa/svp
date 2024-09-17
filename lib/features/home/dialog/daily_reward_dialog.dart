import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:project22/common/assets.dart';
import 'package:project22/core/db/prefs.dart';
import 'package:project22/core/utils.dart';

class DailyRewardDialog extends StatefulWidget {
  const DailyRewardDialog({super.key});

  @override
  State<DailyRewardDialog> createState() => _DailyRewardDialogState();
}

class _DailyRewardDialogState extends State<DailyRewardDialog> {
  bool tapped = false;
  bool luck = false;

  int getRandom() {
    Random random = Random();
    List<int> options = [1, 2, 3];
    return options[random.nextInt(options.length)];
  }

  void onRewardTap(int id) {
    int random = getRandom();
    tapped = true;
    if (random == id) {
      luck = true;
      addCoins(100);
    } else {
      luck = false;
    }
    setState(() {});
    var iso = DateTime.now().add(Duration(days: 1));
    setTimeDailyRewards(time: iso.toIso8601String());
  }

  void onGet() {
    // save coins
    context.pop();
  }

  @override
  void initState() {
    super.initState();
    getTimer();
  }

  ValueNotifier<int> playButtonTime = ValueNotifier(0);

  getTimer() async {
    DateTime? timeDiamonds = await getTimeDailyRewards();
    if (timeDiamonds != null) {
      var time = DateTime.now().difference(timeDiamonds);
      var isAfter = DateTime.now().isAfter(timeDiamonds);
      if (!isAfter) {
        playButtonTime.value = time.inSeconds.abs();
        Timer.periodic(Duration(seconds: 1), (timer) {
          if (playButtonTime.value < 1) {
            timer.cancel();
          }
          playButtonTime.value--;
        });
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // playButtonTime.value = 1;
    return PopScope(
      onPopInvokedWithResult: (didPop, a) {
        print(a.runtimeType);
        print('POP');
        // save coins
      },
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          height: 380,
          width: 360,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 8,
                right: 8,
                // bottom: 40,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 323,
                    width: 34,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 0,
                          spreadRadius: 0,
                          color: Color(0xffFFFFFF),
                        ),
                        BoxShadow(
                          blurRadius: 13,
                          spreadRadius: 0,
                          color: Color(0xffFF8E8E),
                        ),
                      ],
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffE2229C),
                          Color(0xFFE22225),
                        ],
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(3),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
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
                          Image.asset(
                            Assets.imagesDailyBonusTitle,
                            height: 40,
                            width: 140,
                          ),
                          Image.asset(
                            'assets/gift.png',
                            height: 96,
                          ),

                          const SizedBox(height: 24),
                          const Text(
                            'Choose one of the cards and\nfind out what bonus awaits you',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (tapped)
                            Center(
                              child: Container(
                                height: 45,
                                width: 150,
                                // constraints: BoxConstraints(minWidth: 90,maxWidth: 150),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: const Color(0xff10223D),
                                    border:
                                        Border.all(color: Color(0xFFE22226))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (luck) ...[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset('assets/coin.png'),
                                      ),
                                      const Text(
                                        '180',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            height: 1.7),
                                      ),
                                      SizedBox(width: 5)
                                    ] else ...[
                                      Text(
                                        'Better luck next time',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            )
                          else
                            ValueListenableBuilder(
                              valueListenable: playButtonTime,
                              builder: (context, value, child) {
                                if (value > 0) {
                                  return Text(
                                    "${formatTime(playButtonTime.value)}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  );
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _Reward(id: 1, onPressed: onRewardTap),
                                    const SizedBox(width: 20),
                                    _Reward(id: 2, onPressed: onRewardTap),
                                    const SizedBox(width: 20),
                                    _Reward(id: 3, onPressed: onRewardTap),
                                  ],
                                );
                              },
                            ),
                          // const SizedBox(height: 36),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Column(
                  children: [
                    if (tapped || playButtonTime.value > 0) ...[
                      if (luck) ...[
                        CupertinoButton(
                          onPressed: onGet,
                          padding: EdgeInsets.zero,
                          minSize: 40,
                          child: Image.asset(
                            Assets.imagesGetActive,
                            height: 64,
                          ),
                        ),
                      ] else ...[
                        CupertinoButton(
                          onPressed: () {
                            context.pop();
                            if (playButtonTime.value < 1) {
                              var iso = DateTime.now().add(Duration(days: 1));
                              setTimeDailyRewards(time: iso.toIso8601String());
                            }
                          },
                          padding: EdgeInsets.zero,
                          minSize: 40,
                          child: Image.asset(
                            Assets.imagesGetInactive,
                            height: 64,
                          ),
                        ),
                      ]
                    ] else ...[
                      Stack(
                        children: [
                          Image.asset(
                            Assets.imagesOk,
                            height: 64,
                          ),
                          Image.asset(
                            Assets.imagesGetInactive,
                            height: 64,
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Positioned(
                top: -6,
                right: 0,
                child: CupertinoButton(
                  onPressed: () {
                    context.pop();
                  },
                  padding: EdgeInsets.zero,
                  minSize: 25,
                  child: SvgPicture.asset('assets/close.svg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int second = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = second.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}

class _Reward extends StatelessWidget {
  const _Reward({
    required this.id,
    required this.onPressed,
  });

  final int id;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        onPressed(id);
      },
      padding: EdgeInsets.zero,
      child: Container(
        height: 55,
        width: 55,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff10223D),
        ),
        child: Center(
          child: Image.asset(
            'assets/gift2.png',
            height: 55,
          ),
        ),
      ),
    );
  }
}
