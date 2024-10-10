import 'package:go_router/go_router.dart';
import 'package:serenmind/mainlayout.dart';
import 'package:serenmind/screens/activity/activity_list_view.dart';
import 'package:serenmind/screens/login/loginView.dart';
import 'package:serenmind/screens/splash/splashView.dart';
import 'package:serenmind/screens/register/registerView.dart';
import 'package:serenmind/screens/recipe/recipeView.dart';
import 'package:serenmind/screens/recipe/recipe_list_view.dart';
import 'package:serenmind/screens/mood/moodView.dart';
import 'package:serenmind/screens/activity/activity_list_view.dart';
import 'package:serenmind/screens/music/music_list_view.dart';
import 'package:serenmind/screens/tips/tipsView.dart';
import 'package:serenmind/screens/profil/profilView.dart';
import 'package:serenmind/screens/mention/mentionView.dart';
import 'package:serenmind/widgets/menu_list.dart';

class AppRouter {
  final GoRouter router;

  AppRouter()
      : router = GoRouter(
          initialLocation: '/splash',
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => MainLayout(pageIndex: 0),
            ),
            GoRoute(
              path: '/activityList',
              name: 'activityList',
              builder: (context, state) => MainLayout(pageIndex: 1),
            ),
            GoRoute(
              path: '/musicList',
              name: 'musicList',
              builder: (context, state) => MainLayout(pageIndex: 2),
            ),
            GoRoute(
              path: '/recipeList',
              name: 'recipeList',
              builder: (context, state) => MainLayout(pageIndex: 3),
            ),
            GoRoute(
              path: '/menuList',
              name: 'menuList',
              builder: (context, state) => MainLayout(pageIndex: 4),
            ),
            GoRoute(
              path: '/tips',
              name: 'tips',
              builder: (context, state) => TipsView(),
            ),
            GoRoute(
              path: '/splash',
              name: 'splash',
              builder: (context, state) => SplashScreen(),
            ),
            GoRoute(
              path: '/mood',
              name: 'mood',
              builder: (context, state) => MoodView(),
            ),
            GoRoute(
              path: '/login',
              name: 'login',
              builder: (context, state) => LoginView(),
            ),
            GoRoute(
              path: '/register',
              name: 'register',
              builder: (context, state) => RegisterView(),
            ),
            GoRoute(
              path: '/mention',
              name: 'mention',
              builder: (context, state) => LegalMentionsView(),
            ),
            GoRoute(
              path: '/recipe/:recipeName',
              builder: (context, state) {
                final recipeName = state.pathParameters['recipeName']!;
                return RecipeDetailView(recipeName: recipeName);
              },
            ),
            GoRoute(
              path: '/profil',
              name: 'profil',
              builder: (context, state) => ProfilView(),
            ),
          ],
        );
}
