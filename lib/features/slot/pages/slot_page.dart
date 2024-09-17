import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project22/common/assets.dart';

import '../../../core/db/prefs.dart';
import '../../../core/models/page_model.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../../../core/widgets/win_dialog.dart';
import '../../home/widgets/coins_card.dart';
import '../../home/widgets/gems_card.dart';
import '../../home/widgets/music_button.dart';
import '../../home/widgets/rules_button.dart';
import '../../spinner/widgets/arrow_back_button.dart';
import '../widgets/add_time_card.dart';
import '../widgets/lvl_card.dart';
import '../widgets/restart_card.dart';
import '../widgets/spin_slot_button.dart';

class SlotPage extends StatefulWidget {
  const SlotPage({super.key, required this.id, required this.page});

  final int id;
  final PageModel page;

  @override
  State<SlotPage> createState() => _SlotPageState();
}

class _SlotPageState extends State<SlotPage> {
  List<List<String>> slots = [[], [], [], [], []];
  List<ScrollController> scrolls = [
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
    ScrollController(),
  ];

  ValueNotifier<int> spinCount = ValueNotifier(5);
  ValueNotifier<int> timeSecond = ValueNotifier(60);

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeSecond.value < 2) {
        timer.cancel();
      }
      timeSecond.value--;
    });
    getReady();
  }

  int ran = 0;

  getReady() {
    int count = 0;
    while (count < 5) {
      List<String> slotItems = widget.page.items.toList();
      slotItems.shuffle();
      slots[count].addAll(slotItems.toList());
      count++;
    }
    ran = Random().nextInt(8);
    print("RAN: $ran");
    var length = slots[0].length - 1;

    if (ran < 4) {
      int id = Random().nextInt(widget.page.items.length - 1);
      for (int i = 0; i < 5; i++) {
        slots[i][length - ran] = widget.page.items[id];
      }
    }
    setState(() {});
  }

  void spin() async {
    if (spinCount.value < 1) {
      return;
    }
    spinCount.value--;
    int time = 0;
    for (var item in scrolls) {
      int sec = Random().nextInt(4) + 2;
      time = sec < time ? time : sec;
      item.animateTo(scrolls[0].position.maxScrollExtent,
          duration: Duration(seconds: sec), curve: Curves.easeInOut);
    }

    Future.delayed(Duration(seconds: time), () {
      if (ran < 4) {
        gift.value = (ran + 1) * 40;
        addCoins(gift.value!);
        showDialog(
          context: context,
          builder: (context) {
            return RewardSlotDialog(
              page: widget.page,
              spinCount: spinCount,
              text: 'BIG WIN!',
              isWin: true,
            );
          },
        );
        print(gift.value);
        print("----Yutuq----");
      } else {
        gift.value = -1;
        minusCoins(50);
        showDialog(
          context: context,
          builder: (context) {
            return RewardSlotDialog(
              page: widget.page,
              spinCount: spinCount,
              text: 'GAME OVER',
              isWin: false,
            );
          },
        );
      }
      getReady();
    });
  }

  ValueNotifier<int?> gift = ValueNotifier(null);

  @override
  void dispose() {
    scrolls[0].dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomScaffold(
      bg: widget.id + 1,
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                SizedBox(height: 20 + getStatusBar(context)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CoinsCard(),
                    SizedBox(width: 10),
                    GemsCard(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SvgPicture.asset('assets/slot/timer.svg'),
                    Stack(
                      children: [
                        Image.asset(
                          Assets.assetsTimerBack,
                          height: 48,
                        ),
                        Positioned(
                          top: 0,
                          bottom: 3,
                          left: 50,
                          child: Center(
                            child: ValueListenableBuilder(
                              valueListenable: timeSecond,
                              builder: (context, value, child) {
                                return TextR(formatTime(timeSecond.value),
                                    fontSize: 15);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    // SvgPicture.asset('assets/slot/count.svg'),
                    Stack(
                      children: [
                        SvgPicture.asset('assets/gems_card.svg'),
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
                            valueListenable: spinCount,
                            builder: (context, value, child) {
                              return TextR("${formatNumber(spinCount.value)}/5",
                                  fontSize: 15);
                            },
                          ),
                        ),
                      ],
                    ), // SvgPicture.asset('assets/slot/count.svg'),
                  ],
                ),
                SvgPicture.asset('assets/game_title${widget.id}.svg'),
                const Spacer(),
                Container(
                  height: size.width * .842,
                  width: size.width * .842,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: widget.page.color, width: 4),
                    gradient: widget.page.gradient,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 3,
                        color: Color(0xFF7ABBEB),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: List.generate(
                        5,
                        (index) => Expanded(
                          child: ListView.builder(
                            itemCount: slots[index].length,
                            shrinkWrap: true,
                            controller: scrolls[index],
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            itemBuilder: (context, i) {
                              var itemSize = (size.width * .835) / 5 - 6;
                              return Stack(
                                children: [
                                  Container(
                                    height: itemSize,
                                    width: itemSize,
                                    padding: const EdgeInsets.all(10),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color(0xFFFFAE00),
                                          width: 2,
                                          strokeAlign: -2),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          const Color(0xffFFAE00)
                                              .withOpacity(.2),
                                          const Color(0xffFF5D60)
                                              .withOpacity(.8),
                                        ],
                                      ),
                                    ),
                                    child: Image.asset(slots[index][i]),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // const SlotWidget(),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 22),
                    const RulesButton(),
                    const Spacer(),
                    SpinSlotButton(
                      id: widget.id,
                      onPressed: spin,
                    ),
                    const Spacer(),
                    const MusicButton(),
                    const SizedBox(width: 22),
                  ],
                ),
                SizedBox(height: 10 + getBottom(context)),
              ],
            ),
          ),
          const ArrowBackButton(home: true),
          LvlCard(
            level: widget.id,
          ),
          const RestartCard(),
          const AddTimeCard(),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    int minutes = (seconds % 3600) ~/ 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = "${seconds % 60}".padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }
}
