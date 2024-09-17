import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project22/core/db/prefs.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/home_bloc.dart';

class GemsCard extends StatelessWidget {
  const GemsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/gems_card.svg'),
        Positioned(
          top: 7,
          left: 28,
          child: Image.asset(
            'assets/gem.png',
            height: 15,
          ),
        ),
        BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return Positioned(
                top: 4,
                left: 50,
                child: ValueListenableBuilder(
                  valueListenable: Prefs.gems,
                  builder: (context, value, child) {
                    return TextR(formatNumber(state.gems.value), fontSize: 15);
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
