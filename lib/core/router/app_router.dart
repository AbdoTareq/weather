import 'package:go_router/go_router.dart';
import 'package:weather/core/router/app_routes.dart';
import 'package:weather/core/features/weather/presentation/page/home_page.dart';

class AppRouter {
  static final GoRouter routes = GoRouter(
    initialLocation: Routes.home,
    routes: [
      GoRoute(
        name: Routes.home,
        path: Routes.home,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}
