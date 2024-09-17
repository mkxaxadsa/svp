import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project22/core/models/page_model.dart';

import '../../../core/config/router.dart';

class GameCard extends StatelessWidget {
  const GameCard({super.key, required this.id, required this.page});

  final int id;
  final PageModel page;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.width > 400 ? size.height * .5 : 380,
      width: size.width > 400 ? size.width * .8 : 380,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/$id.png',
              height: size.width > 400 ? size.height * .5 : 380,
              width: size.width > 400 ? size.width * .8 : 380,
              fit: BoxFit.fill,
            ),
          ),
          if (id == 3)
            Positioned(
              bottom: 14,
              right: 14,
              child: Image.asset(
                'assets/play3.png',
                height: 120,
              ),
            ),
          Positioned(
            bottom: 32,
            right: 32,
            child: CupertinoButton(
              onPressed: () {
                context.push(Routes.onboard, extra: {'id': id, 'page': page});
              },
              padding: EdgeInsets.zero,
              child: SvgPicture.asset('assets/play$id.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
