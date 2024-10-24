import 'package:go_router/go_router.dart';
import 'package:music_app/Features/Home/presentation/pages/home_page.dart';
import 'package:music_app/Features/settings/presentation/pages/settings_page.dart';

import 'app_route_const.dart';

class MyAppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConst.homePage,
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        name: MyAppRouteConst.settingsPage,
        path: '/settings_page',
        builder: (context, state) {
          return const SettingsPage();
        },
      ),
    ],
  );
}
