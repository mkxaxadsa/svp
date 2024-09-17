import 'package:go_router/go_router.dart';
import 'package:project22/core/models/page_model.dart';

import '../../features/home/pages/home_page.dart';
import '../../features/slot/pages/slot_page.dart';
import '../../features/spinner/pages/spinner_page.dart';
import '../../features/splash/onboard_page.dart';
import '../../features/splash/splash_page.dart';

export 'package:go_router/go_router.dart';

class Routes {
  static String onboard = '/onboard';
  static String home = '/home';
  static String spinner = '/spinner';
  static String slot = '/slot';
}

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
        path: Routes.onboard,
        builder: (context, state) {
          var extra = state.extra as Map;
          return OnboardPage(
            id: extra['id'] as int,
            page: extra['page'] as PageModel,
          );
        }),
    GoRoute(
      path: Routes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.spinner,
      builder: (context, state) => const SpinnerPage(),
    ),
    GoRoute(
        path: Routes.slot,
        builder: (context, state) {
          var extra = state.extra as Map;
          return SlotPage(
            id: extra['id'] as int,
            page: extra['page'] as PageModel,
          );
        }),
  ],
);
