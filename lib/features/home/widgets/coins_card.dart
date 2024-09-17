import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project22/core/db/prefs.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/home_bloc.dart';

class CoinsCard extends StatelessWidget {
  const CoinsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/coins_card.svg'),
        Positioned(
          top: 13,
          left: 15,
          child: Image.asset(
            'assets/coin.png',
            height: 18,
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return Positioned(
                top: 11,
                left: 46,
                child: ValueListenableBuilder(
                    valueListenable: Prefs.coins,
                    builder: (context, value, child) {

                      return TextR(formatNumber(Prefs.coins.value), fontSize: 15);
                    }),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
