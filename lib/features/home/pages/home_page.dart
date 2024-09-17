import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../common/assets.dart';
import '../../../core/models/page_model.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../bloc/home_bloc.dart';
import '../widgets/bonus_button.dart';
import '../widgets/coins_card.dart';
import '../widgets/game_card.dart';
import '../widgets/game_title_card.dart';
import '../widgets/gems_card.dart';
import '../widgets/music_button.dart';
import '../widgets/page_indicator.dart';
import '../widgets/rules_button.dart';
import '../widgets/wheel_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = CarouselSliderController();

  int pageIndex = 0;
  final List<PageModel> pages = [
    PageModel(
      title: 'title',
      win: Assets.slot1Win,
      gameOver: Assets.slot1Gameover,
      color: const Color(0xFFFF5E60),
      bg: 0,
      items: [
        Assets.slot1El1,
        Assets.slot1El2,
        Assets.slot1El3,
        Assets.slot1El4,
        Assets.slot1El5,
        Assets.slot1El6,
        Assets.slot1El7,
        Assets.slot1El8,
        Assets.slot1El9,
        Assets.slot1El10,
        Assets.slot1El11,
        Assets.slot1El12,
        Assets.slot1El13,
        Assets.slot1El15,
        Assets.slot1El16,
        Assets.slot1El17,
        Assets.slot1El18,
        Assets.slot1El19,
        Assets.slot1El20,
      ],
      stories: [
        "In \"Gold Buffalo\" the player finds himself in the Wild West, where gold miners and dangerous bandits create an atmosphere of intense battles and adventures.",
        "Each level is a dusty canyon or an old town, in which the player must skillfully combine cowboys, horses and gold bars, forming rows of three or more identical items.",
        "For each successful combination, the player receives coins that will open new levels.",
        "The limited time pushes you to act quickly and strategically, collecting as much gold as possible.",
        "If you fail to complete the task, the main character is in danger of defeat, but each attempt brings him closer to mastery and the title of a legendary gold hunter.",
      ],
      gradient: const LinearGradient(
        colors: [
          Color(0xFF7E114D),
          Color(0xFF56117E),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    PageModel(
      title: 'title',
      win: Assets.slot2Win,
      gameOver: Assets.slot2Gameover,
      color: const Color(0xFF5EFF7B),
      bg: 0,
      stories: [
        "In \"Happy Monkey\" the player finds himself in a wild tropical wilderness, where monkeys and ancient ruins create an atmosphere of exciting adventures and dangers.",
        "Each level is a dense jungle, where the player must skillfully combine bananas, vines and monkeys, forming rows of three or more identical objects.",
        "For each successful combination, the player receives coins that will open new levels.",
        "The limited time pushes you to act quickly and strategically, collecting as much gold as possible.",
        "If the task is not completed, the hero is in danger of defeat, but each new attempt brings him closer to the title of the true owner of \"Happy Monkey\""
      ],
      items: [
        Assets.slot2El1,
        Assets.slot2El2,
        Assets.slot2El3,
        Assets.slot2El4,
        Assets.slot2El5,
        Assets.slot2El6,
        Assets.slot2El7,
        Assets.slot2El8,
        Assets.slot2El9,
        Assets.slot2El10,
        Assets.slot2El11,
        Assets.slot2El12,
        Assets.slot2El13,
        Assets.slot2El14,
        Assets.slot2El15,
        Assets.slot2El16,
        Assets.slot2El17,
        Assets.slot2El18,
        Assets.slot2El19,
      ],
      gradient: const LinearGradient(colors: [
        Color(0xFF377E11),
        Color(0xFF117E11),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    ),
    PageModel(
      title: 'title',
      win: Assets.slot3Win,
      gameOver: Assets.slot3Gameover,
      color: const Color(0xFFFF5E5E),
      bg: 0,
      stories: [
        "In \"Lucky Joker\" the player finds himself in a world of bright lights and mysterious attractions, where the lucky joker creates an atmosphere of bright performances and intrigue.",
        "Each level is a circus arena or a backstage area, where the player must skillfully combine fruits and gems, forming rows of three or more identical items.",
        "For each successful combination, the player receives coins that will open new levels.",
        "The limited time pushes you to act quickly and strategically, collecting as much gold as possible.",
        "If you do not complete the task, the hero is in danger of failure, but with each new attempt he gets closer to the title of the great master of \"Lucky Joker\"",
      ],
      items: [
        Assets.slot3El1,
        Assets.slot3El2,
        Assets.slot3El3,
        Assets.slot3El4,
        Assets.slot3El5,
        Assets.slot3El6,
        Assets.slot3El7,
        Assets.slot3El8,
        Assets.slot3El9,
        Assets.slot3El10,
        Assets.slot3El11,
        Assets.slot3El12,
        Assets.slot3El13,
        Assets.slot3El14,
        Assets.slot3El15,
        Assets.slot3El16,
        Assets.slot3El17,
        Assets.slot3El18,
        Assets.slot3El19,
      ],
      gradient: const LinearGradient(colors: [
        Color(0xFF7E1511),
        Color(0xFF7E1111),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
    )
  ];

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      pageIndex = index;
    });
  }

  void onPageIndicator(int index) {
    controller.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          SizedBox(height: 20 + getStatusBar(context)),
          const SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 22),
                BonusButton(),
                Spacer(),
                Column(
                  children: [
                    CoinsCard(),
                    SizedBox(height: 5),
                    GemsCard(),
                  ],
                ),
                Spacer(),
                WheelButton(),
                SizedBox(width: 22),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              carouselController: controller,
              items: [
                GameCard(
                  id: 1,
                  page: pages[0],
                ),
                GameCard(id: 2, page: pages[1]),
                GameCard(id: 3, page: pages[2]),
              ],
              options: CarouselOptions(
                clipBehavior: Clip.none,
                enableInfiniteScroll: false,
                aspectRatio: 1,
                viewportFraction: getWidth(context) >= 500 ? 1.5 : 1,
                onPageChanged: onPageChanged,
              ),
            ),
          ),
          GameTitleCard(id: pageIndex + 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PageIndicator(
                id: 0,
                active: pageIndex == 0,
                onPressed: onPageIndicator,
              ),
              const SizedBox(width: 10),
              PageIndicator(
                id: 1,
                active: pageIndex == 1,
                onPressed: onPageIndicator,
              ),
              const SizedBox(width: 10),
              PageIndicator(
                id: 2,
                active: pageIndex == 2,
                onPressed: onPageIndicator,
              ),
            ],
          ),
          const SizedBox(height: 66),
          const Row(
            children: [
              SizedBox(width: 22),
              RulesButton(),
              Spacer(),
              MusicButton(),
              SizedBox(width: 22),
            ],
          ),
          SizedBox(height: 10 + getBottom(context)),
        ],
      ),
    );
  }
}
