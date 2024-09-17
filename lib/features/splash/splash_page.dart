import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/config/router.dart';
import '../../core/db/prefs.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../../core/widgets/texts/text_r.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void _load() async {
    await getData().then((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.go(Routes.home);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            RotationTransition(
              turns: _controller,
              child: SvgPicture.asset('assets/loading.svg'),
            ),
            const TextR('LOADING...', fontSize: 36),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
