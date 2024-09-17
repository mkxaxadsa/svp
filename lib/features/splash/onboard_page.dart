import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/assets.dart';
import '../../core/config/router.dart';
import '../../core/models/page_model.dart';
import '../../core/utils.dart';
import '../../core/widgets/custom_scaffold.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key, required this.page, required this.id});

  final PageModel page;
  final int id;

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  ValueNotifier<int> index = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(size);
    return CustomScaffold(
      bg: widget.id + 1,
      body: Stack(
        children: [
          Center(
            child: Container(
              height: size.width * .8,
              width: size.width * .8,
              decoration: BoxDecoration(
                color: widget.page.color.withOpacity(.5),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: widget.page.color,
                  width: size.width > 400 ? 10 : 3,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ValueListenableBuilder(
                    builder: (context, value, child) {
                      return Text(
                        widget.page.stories[value],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CupertinoColors.white,
                          fontSize: size.width * .04,
                        ),
                      );
                    },
                    valueListenable: index,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * .01,
            left: 0,
            right: 0,
            child: CupertinoButton(
              child: Image.asset(
                getImage(widget.id),
                width: size.width * .6,
                // height: 40,
              ),
              onPressed: () {
                index.value++;
                if (index.value == widget.page.stories.length) {
                  index.value = 0;
                  context.push(Routes.slot, extra: {
                    'id': widget.id,
                    'page': widget.page,
                  });
                }
              },
            ),
          ),
          Positioned(
            right: 10,
            top: 20 + getStatusBar(context),
            child: CupertinoButton(
              child: Image.asset(
                Assets.assetsSkip,
                height: 40,
              ),
              onPressed: () {
                context.push(Routes.slot, extra: {
                  'id': widget.id,
                  'page': widget.page,
                });
              },
            ),
          ),
          Positioned(
            top: 20 + getStatusBar(context),
            left: 40,
            child: CupertinoButton(
              onPressed: () {
                context.pop();
              },
              padding: EdgeInsets.zero,
              child: SvgPicture.asset('assets/close.svg'),
            ),
          ),
        ],
      ),
    );
  }

  String getImage(id) {
    switch (id) {
      case 1:
        return Assets.assetsLevel1continue;
      case 2:
        return Assets.assetsLevel2continue;
      case 3:
        return Assets.assetsLevel3continue;
      default:
        return Assets.assetsLevel1continue;
    }
  }
}
