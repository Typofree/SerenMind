import 'package:go_router/go_router.dart';
import 'package:serenmind/mainlayout.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: '/',
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => MainLayout(pageIndex: 0),
            ),
            GoRoute(
              path: '/activity',
              name: 'activity',
              builder: (context, state) => MainLayout(pageIndex: 1),
            ),
            GoRoute(
              path: '/tips',
              name: 'tips',
              builder: (context, state) => MainLayout(pageIndex: 2),
            ),
          ],
        );
}
